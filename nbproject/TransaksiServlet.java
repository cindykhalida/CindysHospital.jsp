import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class TransaksiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String aksi = request.getParameter("aksi");
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/rumahsakit?useSSL=false&serverTimezone=UTC",
                "root", ""
            );

            if("hapus".equals(aksi)){
                PreparedStatement ps = conn.prepareStatement("DELETE FROM transaksi WHERE id=?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
            }

            conn.close();
        } catch(Exception e){
            e.printStackTrace();
        }

        response.sendRedirect("transaksi.jsp");
    }
}
