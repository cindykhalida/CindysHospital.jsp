<%@ page session="true" %>
<%
    // hapus session
    if (session != null) {
        session.invalidate();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffe0ec, #d6ecff);
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 40%;
            background: white;
            margin: 120px auto;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 0 25px rgba(0,0,0,0.1);
            border: 2px solid #ffd6eb;
            text-align: center;
        }

        h2 {
            color: #ff6fa4;
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            margin-bottom: 25px;
        }

        a {
            display: inline-block;
            padding: 12px 20px;
            text-decoration: none;
            color: white;
            background: #8cc9ff;
            border-radius: 12px;
            font-weight: bold;
            transition: 0.25s;
        }

        a:hover {
            background: #6fbaff;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Logout Berhasil</h2>
    <p>Terima kasih telah menggunakan Cindy's Hospital ?</p>
    <a href="<%= request.getContextPath() %>/login.jsp">Login Kembali</a>
</div>

</body>
</html>
