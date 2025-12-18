<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<html>
<head>
<title>List Pasien</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom right, #ffd8e4, #d6ecff);
        margin: 0;
        padding: 30px;
    }

    h2 {
        text-align: center;
        color: #ff6fa8;
    }

    .container {
        width: 85%;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 15px;
        border: 3px solid #ffe3ef;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    a.btn {
        display: inline-block;
        background: #ff9fc8;
        color: white;
        padding: 10px 15px;
        text-decoration: none;
        border-radius: 10px;
        margin-bottom: 15px;
        transition: 0.3s;
    }

    a.btn:hover {
        background: #ff7fb8;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }

    table th {
        background: #ffb7d6;
        color: white;
        padding: 10px;
        border: 1px solid #ffcfe2;
    }

    table td {
        padding: 10px;
        border: 1px solid #ffdee9;
        background: #fff9fc;
    }

    table tr:nth-child(even) td {
        background: #f7faff;
    }

    a.action {
        color: #5b8bff;
        font-weight: bold;
        text-decoration: none;
    }

    a.action:hover {
        text-decoration: underline;
    }

    .back {
        display: inline-block;
        margin-top: 20px;
        color: #6b8bff;
        font-weight: bold;
        text-decoration: none;
    }

    .back:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<div class="container">

<h2>List Pasien</h2>

<a href="add.jsp" class="btn">+ Tambah Pasien</a>

<table>
<tr>
    <th>ID</th>
    <th>Nama</th>
    <th>Alamat</th>
    <th>Telepon</th>
    <th>Tanggal Lahir</th>
    <th>Aksi</th>
</tr>

<%
PreparedStatement ps = conn.prepareStatement("SELECT * FROM pasien");
ResultSet rs = ps.executeQuery();
while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("nama") %></td>
    <td><%= rs.getString("alamat") %></td>
    <td><%= rs.getString("telepon") %></td>
    <td><%= rs.getDate("tanggal_lahir") %></td>
    <td>
        <a class="action" href="edit.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
        <a class="action" href="delete.jsp?id=<%= rs.getInt("id") %>">Hapus</a>
    </td>
</tr>

<%
}
rs.close();
ps.close();
%>

</table>

<a href="dashboard.jsp" class="back">Back To Dashboard</a>

</div>

</body>
</html>
