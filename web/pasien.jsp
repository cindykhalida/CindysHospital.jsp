<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Data Pasien</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom right, #ffd8e4, #d6ecff);
        margin: 0;
        padding: 20px;
    }

    h2 {
        color: #ff6fa8;
        text-align: center;
        margin-bottom: 20px;
    }

    a.add-btn {
        display: inline-block;
        padding: 10px 15px;
        background: #ff9fc8;
        color: white;
        border-radius: 10px;
        text-decoration: none;
        margin-bottom: 15px;
    }
    a.add-btn:hover {
        background: #ff7fb8;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    th {
        background: #ffb6d6;
        padding: 12px;
        color: white;
    }

    td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ffe5f1;
    }

    tr:hover {
        background: #fff4fa;
    }

    a.edit, a.delete {
        color: #ff6fa8;
        text-decoration: none;
        font-weight: bold;
    }
    a.edit:hover, a.delete:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<h2>Daftar Pasien</h2>

<a href="pasien_tambah.jsp" class="add-btn">+ Tambah Pasien</a>

<table>
<tr>
    <th>ID</th>
    <th>Nama</th>
    <th>Alamat</th>
    <th>Telepon</th>
    <th>Aksi</th>
</tr>

<%
Statement st = conn.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM pasien");
while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("nama") %></td>
    <td><%= rs.getString("alamat") %></td>
    <td><%= rs.getString("telepon") %></td> <!-- sudah dibenerin -->
    <td>
        <a class="edit" href="pasien_edit.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
        <a class="delete" href="PasienServlet?action=delete&id=<%= rs.getInt("id") %>">Hapus</a>
    </td>
</tr>

<% } rs.close(); st.close(); %>
</table>

</body>
</html>
