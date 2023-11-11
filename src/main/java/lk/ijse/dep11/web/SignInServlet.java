package lk.ijse.dep11.web;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.dbcp2.BasicDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/sign-in")
public class SignInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String mode = req.getParameter("mode");
        String rememberMe = req.getParameter("remember-me");
        BasicDataSource pool = (BasicDataSource) getServletContext().getAttribute("connectionPool");
        try (Connection connection = pool.getConnection()) {
            PreparedStatement stm = connection.prepareStatement("SELECT full_name, password FROM user WHERE username = ?");
            stm.setString(1, email);
            ResultSet rst = stm.executeQuery();
            if (rst.next()) {
                if (rst.getString("password").equals(DigestUtils.sha256Hex(password))) {
                    HttpSession session = req.getSession();
                    if (rememberMe != null) {
                        String setCookieHeader = resp.getHeader("Set-Cookie");
                        setCookieHeader += " Max-Age: " + (60 * 3);
                        System.out.println("SetCookie" + setCookieHeader);
                    }
                    session.setAttribute("fullName", rst.getString("full_name"));
                    session.setAttribute("mode", mode == null ? "dark" : mode);
                    resp.sendRedirect(req.getContextPath());
                } else {
                    req.setAttribute("denied", true);
                    getServletContext().getRequestDispatcher("/sign-in.jsp").forward(req, resp);
                }
            }else {
                req.setAttribute("denied", true);
                getServletContext().getRequestDispatcher("/sign-in.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error",true);
            getServletContext().getRequestDispatcher("/sign-in.jsp").forward(req,resp);
        }
    }
}
