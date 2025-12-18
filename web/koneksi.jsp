<%@ page import="java.sql.*" %>
<%
Connection conn = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/rumahsakit?useSSL=false&serverTimezone=UTC",
        "root",
        ""
    );
} catch(Exception e){
    out.println("Koneksi gagal: " + e.getMessage());
    e.printStackTrace();
}
%>

