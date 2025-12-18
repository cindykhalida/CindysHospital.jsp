<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Rumah Sakit</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffe0ec, #d6ecff); 
            /* pink pastel -> biru pastel */
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 60%;
            background: white;
            margin: 40px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 25px rgba(0,0,0,0.1);
            border: 2px solid #ffd6eb;
        }

        h2 {
            text-align: center;
            color: #ff6fa4; /* pink pastel */
        }

        h3 {
            margin-top: 30px;
            color: #5fa8dd; /* biru pastel */
        }

        a {
            display: inline-block;
            padding: 10px 18px;
            margin: 6px 0;
            text-decoration: none;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            transition: 0.25s;
        }

        /* tombol default: pink pastel */
        .btn {
            background: #ff9cc9;
        }

        .btn:hover {
            background: #ff7fb6;
        }

        /* tombol biru pastel */
        .btn-blue {
            background: #8cc9ff;
        }

        .btn-blue:hover {
            background: #6fbaff;
        }

        .logout-btn {
            background: #ff6f9e;
            margin-top: 25px;
        }

        .logout-btn:hover {
            background: #ff558e;
        }
    </style>
</head>

<body>

<div class="container">

<h2>Welcome To Cindy's Hospital</h2>

<%
    String username = (String) session.getAttribute("Cindy Khalida");
    String role = (String) session.getAttribute("Admin");
%>



<h3>Menu Pasien</h3>
<a class="btn" href="<%=request.getContextPath()%>/add.jsp">Add Patient</a><br>
<a class="btn-blue" href="<%=request.getContextPath()%>/list.jsp">Patient's List</a><br>

<h3>Menu Transaksi</h3>
<a class="btn-blue" href="<%=request.getContextPath()%>/transaksi.jsp">Transaksi</a><br>

<h3>Menu Antrian</h3>
<a class="btn" href="<%=request.getContextPath()%>/antrian.jsp">Antrian Online</a><br>

<% if(role != null && (role.equals("VERIFIKATOR") || role.equals("ADMIN"))) { %>
<h3>Verifikasi</h3>
<a class="btn" href="<%=request.getContextPath()%>/verifikasi.jsp">Verifikasi Transaksi</a><br>
<% } %>

<h3>Menu Pasien</h3>
<a class="btn" href="<%=request.getContextPath()%>/add.jsp">Add Patient</a><br>
<a class="btn-blue" href="<%=request.getContextPath()%>/list.jsp">Patient's List</a><br>

<h3>Menu Transaksi</h3>
<a class="btn-blue" href="<%=request.getContextPath()%>/transaksi.jsp">Transaksi</a><br>

<% if(role != null && (role.equals("VERIFIKATOR") || role.equals("ADMIN"))) { %>
<h3>Verifikasi</h3>
<a class="btn" href="<%=request.getContextPath()%>/verifikasi.jsp">Verifikasi Transaksi</a><br>
<% } %>

<a class="logout-btn" href="<%=request.getContextPath()%>/logout">Logout</a>

</div>

</body>
</html>
