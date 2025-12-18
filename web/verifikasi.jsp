<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verifikasi Transaksi</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffe6f0, #e3f2ff);
            padding: 20px;
        }

        h2 {
            color: #d6336c;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        th {
            padding: 10px;
            background: linear-gradient(to right, #f8c1d9, #cbe3ff);
            color: #d6336c;
            border: 1px solid #ddd;
            text-align: center;
            font-weight: bold;
        }

        td {
            padding: 8px;
            border: 1px solid #eee;
            text-align: center;
        }

        tr:nth-child(even){
            background-color: #fff5fa;
        }

        tr:nth-child(odd){
            background-color: #f4f9ff;
        }

        a {
            color: #4a90e2;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<h2>Verifikasi Transaksi</h2>

<table>
<tr>
    <th>ID</th>
    <th>Pasien</th>
    <th>Jumlah</th>
    <th>Status</th>
    <th>Aksi</th>
</tr>

<%
Statement tv = conn.createStatement();
ResultSet rt = tv.executeQuery(
"SELECT t.id, p.nama, t.jumlah, t.status FROM transaksi t JOIN pasien p ON t.id_pasien = p.id WHERE status='PENDING'"
);

while(rt.next()){ 
%>

<tr>
    <td><%= rt.getInt("id") %></td>
    <td><%= rt.getString("nama") %></td>
    <td><%= rt.getDouble("jumlah") %></td>
    <td><%= rt.getString("status") %></td>
    <td>
        <a href="VerifikasiServlet?action=verify&id=<%= rt.getInt("id") %>">Verifikasi</a>
    </td>
</tr>

<% } %>

</table>

</body>
</html>
