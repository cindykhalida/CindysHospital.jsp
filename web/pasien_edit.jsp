<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
PreparedStatement ps = null;
ResultSet rs = null;

String nama="", alamat="", telepon="";
java.sql.Date tanggal_lahir = null;

if(request.getParameter("submit") != null){
    // UPDATE DATA
    try{
        ps = conn.prepareStatement(
            "UPDATE pasien SET nama=?, alamat=?, telepon=?, tanggal_lahir=? WHERE id=?"
        );
        ps.setString(1, request.getParameter("nama"));
        ps.setString(2, request.getParameter("alamat"));
        ps.setString(3, request.getParameter("telepon"));
        ps.setDate(4, java.sql.Date.valueOf(request.getParameter("tanggal_lahir")));
        ps.setInt(5, id);
        ps.executeUpdate();
        ps.close();

        response.sendRedirect("list.jsp");
        return;
    } catch(Exception e){
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
} else {
    // GET DATA LAMA
    ps = conn.prepareStatement("SELECT * FROM pasien WHERE id=?");
    ps.setInt(1, id);
    rs = ps.executeQuery();

    if(rs.next()){
        nama = rs.getString("nama");
        alamat = rs.getString("alamat");
        telepon = rs.getString("telepon");
        tanggal_lahir = rs.getDate("tanggal_lahir");
    }

    rs.close();
    ps.close();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Pasien</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom right, #ffd8e4, #d6ecff);
        margin: 0;
        padding: 30px;
    }

    h2 {
        color: #ff6fa8;
        text-align: center;
        margin-bottom: 25px;
    }

    form {
        background: white;
        max-width: 450px;
        margin: auto;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    input[type=text], input[type=date] {
        width: 100%;
        padding: 10px;
        margin-bottom: 12px;
        border-radius: 8px;
        border: 1px solid #ffb6d6;
    }

    input[type=submit] {
        width: 100%;
        padding: 12px;
        background: #ff85bb;
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        cursor: pointer;
    }

    input[type=submit]:hover {
        background: #ff6fa8;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-top: 15px;
        text-decoration: none;
        color: #ff6fa8;
        font-weight: bold;
    }
    .back-link:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<h2>Edit Data Pasien</h2>

<form method="post">
    Nama:
    <input type="text" name="nama" value="<%=nama%>" required>

    Alamat:
    <input type="text" name="alamat" value="<%=alamat%>" required>

    Telepon:
    <input type="text" name="telepon" value="<%=telepon%>" required>

    Tanggal Lahir:
    <input type="date" name="tanggal_lahir" value="<%=tanggal_lahir%>" required>

    <input type="submit" name="submit" value="Update Data">
</form>

<a class="back-link" href="list.jsp">Back To The Patient's List</a>

</body>
</html>
