<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<%
// Proses login ketika form disubmit
if ("POST".equals(request.getMethod())) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Hardcoded username dan password
    if ("cindy".equals(username) && "0903".equals(password)) {
        // Set session untuk menandai login berhasil
        session.setAttribute("isLoggedIn", "true");
        session.setAttribute("user", username);
        
        // Redirect ke dashboard.jsp
        response.sendRedirect("dashboard.jsp");
        return;
    } else {
        // Tampilkan alert jika login gagal
        out.println("<script>alert('Login gagal! Username atau password salah.');</script>");
    }
}
%>
<html>
<head>
<title>Login Sistem</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom right, #ffd8e4, #d6ecff);
        height: 100vh;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-box {
        background: white;
        width: 350px;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        text-align: center;
        border: 3px solid #ffe3ef;
    }

    h2 {
        color: #ff6fa8;
        margin-bottom: 20px;
    }

    input {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
        border-radius: 10px;
        border: 1px solid #ffcfe2;
        background: #fff9fc;
    }

    button {
        width: 95%;
        padding: 10px;
        border: none;
        border-radius: 10px;
        background: #ff9fc8;
        color: white;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
        transition: 0.3s;
    }

    button:hover {
        background: #ff7fb8;
    }
    
    .demo-info {
        margin-top: 20px;
        padding: 10px;
        background-color: #fff0f7;
        border-radius: 8px;
        border: 1px dashed #ff9fc8;
        font-size: 12px;
        color: #ff6fa8;
    }
    
    .demo-info strong {
        color: #ff4081;
    }
</style>

</head>
<body>

<div class="login-box">
    <h2>Login Sistem</h2>

    <form action="login.jsp" method="post">
        <input type="text" name="username" placeholder="Username" required>
        
        <input type="password" name="password" placeholder="Password" required>
        
        <button type="submit">Login</button>
    </form>
    
</div>

</body>
</html>