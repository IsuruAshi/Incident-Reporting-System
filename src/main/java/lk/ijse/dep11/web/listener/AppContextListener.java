package lk.ijse.dep11.web.listener;

import org.apache.commons.dbcp2.BasicDataSource;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.sql.SQLException;

public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String appPath = sce.getServletContext().getRealPath("/");
        new File(appPath,"uploads").mkdir();
        BasicDataSource pool=new BasicDataSource();
        pool.setUsername("root");
        pool.setPassword("mysql");
        pool.setDriverClassName("com.mysql.cj.jdbc.Driver");
        pool.setUrl("jdbc:mysql://localhost:3306/incidents_database");
        pool.setInitialSize(10);
        pool.setMaxTotal(15);

        sce.getServletContext().setAttribute("connectionPool",pool);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
           ((BasicDataSource) sce.getServletContext().getAttribute("connectionPool")).close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
