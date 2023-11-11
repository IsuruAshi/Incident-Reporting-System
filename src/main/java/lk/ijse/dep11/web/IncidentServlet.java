package lk.ijse.dep11.web;

import lk.ijse.dep11.web.to.Incident;
import org.apache.commons.dbcp2.BasicDataSource;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
                getServletContext().getRequestDispatcher("index.jsp").forward(req,resp);

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
