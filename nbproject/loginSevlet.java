/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


public class loginSevlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws IOException, ServletException {


String username = request.getParameter("username");
String password = request.getParameter("password");


try {
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/rumahsakit", "root", "");


PreparedStatement ps = conn.prepareStatement(
"SELECT * FROM users WHERE username=? AND password=?");
ps.setString(1, username);
ps.setString(2, password);
ResultSet rs = ps.executeQuery();


if (rs.next()) {
HttpSession session = request.getSession();
session.setAttribute("username", username);
session.setAttribute("role", rs.getString("role"));
response.sendRedirect("dashboard.jsp");
} else {
response.getWriter().println("Login gagal!");
}
} catch (Exception e) {
response.getWriter().println("Error: " + e.getMessage());
}
}
}
