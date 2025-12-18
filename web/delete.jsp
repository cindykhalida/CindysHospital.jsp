<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<html>
<head>
<title>Hapus Pasien</title>
<style>
    /* Gunakan gaya yang sama seperti list.jsp untuk konsistensi */
    body { font-family: Arial, sans-serif; background: linear-gradient(to bottom right, #ffd8e4, #d6ecff); margin: 0; padding: 30px; }
    .container { width: 50%; margin: auto; background: white; padding: 20px; border-radius: 15px; border: 3px solid #ffe3ef; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #ff6fa8; }
    p { margin: 10px 0; color: #333; }
    .btn { display: inline-block; background: #ff9fc8; color: white; padding: 10px 15px; text-decoration: none; border-radius: 10px; margin: 10px 5px; transition: 0.3s; }
    .btn:hover { background: #ff7fb8; }
    .btn-danger { background: #ff6b6b; }
    .btn-danger:hover { background: #ff5252; }
    .back { display: inline-block; margin-top: 20px; color: #6b8bff; font-weight: bold; text-decoration: none; }
    .back:hover { text-decoration: underline; }
    .message { padding: 10px; border-radius: 5px; margin: 10px 0; text-align: center; }
    .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
</style>
</head>
<body>
<div class="container">
<h2>Konfirmasi Hapus Pasien</h2>
<%
int id = Integer.parseInt(request.getParameter("id"));
String confirm = request.getParameter("confirm");
String nama = "", alamat = "", telepon = "", tanggalLahir = "";

// Proses penghapusan jika konfirmasi "yes"
if ("yes".equals(confirm)) {
    try {
        // Hapus data dari database
        PreparedStatement ps = conn.prepareStatement("DELETE FROM pasien WHERE id=?");
        ps.setInt(1, id);
        int rowsAffected = ps.executeUpdate();
        ps.close();
        
        if (rowsAffected > 0) {
            out.println("<div class='message success'>Data pasien berhasil dihapus!</div>");
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("    window.location.href = 'list.jsp';");
            out.println("}, 2000);"); // Redirect setelah 2 detik
            out.println("</script>");
        } else {
            out.println("<div class='message error'>Gagal menghapus data pasien.</div>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
    }
    return;
}

// Tampilkan data pasien untuk konfirmasi
try {
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM pasien WHERE id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        nama = rs.getString("nama");
        alamat = rs.getString("alamat");
        telepon = rs.getString("telepon");
        tanggalLahir = rs.getString("tanggal_lahir");
    } else {
        out.println("<p>Pasien tidak ditemukan.</p>");
        out.println("<a href='list.jsp' class='btn'>Kembali ke List Pasien</a>");
        return;
    }
    rs.close();
    ps.close();
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<p>Error: " + e.getMessage() + "</p>");
    out.println("<a href='list.jsp' class='btn'>Kembali ke List Pasien</a>");
    return;
}
%>
<p>Apakah Anda yakin ingin menghapus pasien berikut?</p>
<p><strong>ID:</strong> <%= id %></p>
<p><strong>Nama:</strong> <%= nama %></p>
<p><strong>Alamat:</strong> <%= alamat %></p>
<p><strong>Telepon:</strong> <%= telepon %></p>
<p><strong>Tanggal Lahir:</strong> <%= tanggalLahir %></p>

<form action="" method="get">
    <input type="hidden" name="id" value="<%= id %>">
    <input type="hidden" name="confirm" value="yes">
    <button type="submit" class="btn btn-danger">Ya, Hapus</button>
</form>

<a href="list.jsp" class="btn">Batal</a>

<a href="list.jsp" class="back">Back to List</a>
</div>
</body>
</html>