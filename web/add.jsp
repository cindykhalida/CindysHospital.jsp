<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<html>
<head>
<title>Add Patient</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom right, #ffd8e4, #d6ecff);
        margin: 0;
        padding: 40px;
    }

    .container {
        background: white;
        width: 450px;
        margin: auto;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        border: 3px solid #ffe3ef;
    }

    h2 {
        text-align: center;
        color: #ff6fa8;
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
        color: #6b6b6b;
    }

    input[type="text"],
    input[type="date"] {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        margin-bottom: 15px;
        border: 2px solid #ffcfe2;
        border-radius: 10px;
        background-color: #fff8fb;
    }

    input[type="submit"] {
        width: 100%;
        padding: 12px;
        background: #ff9fc8;
        color: white;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 16px;
        transition: 0.3s;
    }

    input[type="submit"]:hover {
        background: #ff7fb8;
    }

    a {
        display: inline-block;
        margin-top: 15px;
        color: #5b8bff;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }

    .msg {
        text-align: center;
        font-weight: bold;
        margin-bottom: 15px;
    }
</style>

</head>
<body>

<div class="container">
<h2>Tambah Data Pasien</h2>

<%
if(request.getParameter("submit") != null){
    String nama = request.getParameter("nama");
    String alamat = request.getParameter("alamat");
    String telepon = request.getParameter("telepon");
    String tanggal_lahir_str = request.getParameter("tanggal_lahir");

    PreparedStatement ps = null;
    try {
        if(conn != null){
            String sql = "INSERT INTO pasien(nama, alamat, telepon, tanggal_lahir) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nama);
            ps.setString(2, alamat);
            ps.setString(3, telepon);
            ps.setDate(4, java.sql.Date.valueOf(tanggal_lahir_str));
            ps.executeUpdate();
            out.println("<p class='msg' style='color:green;'>Data pasien berhasil ditambahkan.</p>");
        } else {
            out.println("<p class='msg' style='color:red;'>Koneksi database gagal!</p>");
        }
    } catch(Exception e){
        out.println("<p class='msg' style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if(ps != null) try { ps.close(); } catch(Exception ex) {}
    }
}
%>

<form method="post">
    <label>Nama:</label>
    <input type="text" name="nama" required>

    <label>Alamat:</label>
    <input type="text" name="alamat" required>

    <label>Telepon:</label>
    <input type="text" name="telepon" required>

    <label>Tanggal Lahir:</label>
    <input type="date" name="tanggal_lahir" required>

    <input type="submit" name="submit" value="Tambah Data">
</form>

<a href="list.jsp">Back to patient's list</a>

</div>

</body>
</html>
