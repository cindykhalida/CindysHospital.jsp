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


public class VerifikasiServlet extends HttpServlet {
protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws IOException {


try {
int id = Integer.parseInt(request.getParameter("id"));
String user = (String) request.getSession().getAttribute("username");


Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/rumahsakit", "root", "");


PreparedStatement ps = conn.prepareStatement(
"UPDATE transaksi SET status='VERIFIKASI', diverifikasi_oleh=?, diverifikasi_pada=NOW() WHERE id=?");
ps.setString(1, user);
ps.setInt(2, id);
ps.executeUpdate();


response.sendRedirect("verifikasi.jsp");
} catch (Exception e) {
response.getWriter().println("Error: " + e.getMessage());
}
}
}