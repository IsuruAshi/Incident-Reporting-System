package lk.ijse.dep11.web;

import lk.ijse.dep11.web.to.Incident;
import org.apache.commons.dbcp2.BasicDataSource;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class IncidentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicDataSource pool = (BasicDataSource) getServletContext().getAttribute("connectionPool");
        try (Connection connection = pool.getConnection()){
            Statement stm = connection.createStatement();
            ResultSet rst = stm.executeQuery("SELECT I.* ,P.path FROM incident AS I LEFT OUTER JOIN picture AS P ON I.id=P.incident_id");
            List<Incident> incidentList=new ArrayList<>();
            while (rst.next()){
                String id=String.format("I%03d",rst.getInt("id"));
                String incident = rst.getString("incident_name");
                Date date =rst.getDate("date");
                String description=rst.getString("description");
                String location =rst.getString("location");
                String reporting_person=rst.getString("reporting_person");
                String path=rst.getString("path");
                incidentList.add(new Incident(id,date,incident,description,location,reporting_person,path));
                getServletContext().getRequestDispatcher("#").forward(req,resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String incident=req.getParameter("incident");
        String date=req.getParameter("date");
        String description=req.getParameter("description");
        String location =req.getParameter("location");
        String reporting_person=req.getParameter("person");
        Part picture=req.getPart("picture");

        BasicDataSource pool = (BasicDataSource) getServletContext().getAttribute("connectionPool");
        try {
            Connection connection = pool.getConnection();
            connection.setAutoCommit(false);
            try {
                PreparedStatement stmIncident = connection
                        .prepareStatement("INSERT INTO incident" +
                                "(date, incident_name, description, location, reporting_person)" +
                                "VALUES (?,?,?,?,?) ", Statement.RETURN_GENERATED_KEYS);
                stmIncident.setString(1,date);
                stmIncident.setString(2,incident);
                stmIncident.setString(3,description);
                stmIncident.setString(4,location);
                stmIncident.setString(5,reporting_person);
                if(picture.getSize()>0){
                    String uploadsDirPath = getServletContext().getRealPath("/uploads");
                    UUID imageID = UUID.randomUUID();
                    String picturePath=uploadsDirPath+imageID;

                    ResultSet generatedKeys = stmIncident.getGeneratedKeys();
                    generatedKeys.next();

                    PreparedStatement stmPicture = connection.prepareStatement("INSERT INTO picture (incident_id, path)" +
                            "VALUES (?,?)");
                    stmPicture.setInt(1,generatedKeys.getInt(1));
                    stmPicture.setString(2,"uploads/"+imageID);
                    stmPicture.executeUpdate();
                    picture.write(picturePath);
                }
                connection.commit();
            }catch (Throwable t){
                connection.rollback();
                t.printStackTrace();
            }finally {
                connection.setAutoCommit(true);
                connection.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        resp.sendRedirect("/app");
    }
}
