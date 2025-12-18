<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<html>
<head>
<title>Edit Pasien</title>
<style>
    /* Gunakan gaya yang sama seperti list.jsp untuk konsistensi */
    body { font-family: Arial, sans-serif; background: linear-gradient(to bottom right, #ffd8e4, #d6ecff); margin: 0; padding: 30px; }
    .container { width: 50%; margin: auto; background: white; padding: 20px; border-radius: 15px; border: 3px solid #ffe3ef; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #ff6fa8; }
    form { margin-top: 20px; }
    label { display: block; margin-bottom: 5px; color: #ff6fa8; }
    input[type="text"], input[type="date"] { width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ffcfe2; border-radius: 5px; }
    button { background: #ff9fc8; color: white; padding: 10px 15px; border: none; border-radius: 10px; cursor: pointer; }
    button:hover { background: #ff7fb8; }
    .back { display: inline-block; margin-top: 20px; color: #6b8bff; font-weight: bold; text-decoration: none; }
    .back:hover { text-decoration: underline; }
    .message { padding: 10px; border-radius: 5px; margin: 10px 0; text-align: center; }
    .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
</style>
</head>
<body>
<div class="container">
<h2>Edit Pasien</h2>
<%
// Cek apakah form sudah disubmit
String aksi = request.getParameter("aksi");
String submit = request.getParameter("submit");

// Jika form sudah disubmit untuk update
if ("edit".equals(aksi) && submit != null) {
    int id = Integer.parseInt(request.getParameter("id"));
    String nama = request.getParameter("nama");
    String alamat = request.getParameter("alamat");
    String telepon = request.getParameter("telepon");
    String tanggalLahir = request.getParameter("tanggal_lahir");
    
    try {
        // Update data ke database
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE pasien SET nama=?, alamat=?, telepon=?, tanggal_lahir=? WHERE id=?"
        );
        ps.setString(1, nama);
        ps.setString(2, alamat);
        ps.setString(3, telepon);
        ps.setString(4, tanggalLahir);
        ps.setInt(5, id);
        
        int rowsAffected = ps.executeUpdate();
        ps.close();
        
        if (rowsAffected > 0) {
            out.println("<div class='message success'>Data pasien berhasil diupdate!</div>");
            out.println("<p>Anda akan diarahkan kembali ke halaman list pasien...</p>");
            // Redirect otomatis ke list.jsp setelah 3 detik
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("    window.location.href = 'list.jsp';");
            out.println("}, 3000);");
            out.println("</script>");
            // Tampilkan link untuk langsung kembali tanpa menunggu
            out.println("<a href='list.jsp' class='back'>Kembali ke List Pasien Sekarang</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
            return; // Stop eksekusi lebih lanjut
        } else {
            out.println("<div class='message error'>Gagal mengupdate data pasien.</div>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
    }
}

// Jika halaman pertama kali dibuka atau untuk menampilkan form edit
int id = Integer.parseInt(request.getParameter("id"));
String nama = "", alamat = "", telepon = "", tanggalLahir = "";

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
        out.println("<div class='message error'>Pasien tidak ditemukan.</div>");
        out.println("<a href='list.jsp' class='back'>Kembali ke List Pasien</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
        return;
    }
    
    rs.close();
    ps.close();
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
    out.println("<a href='list.jsp' class='back'>Kembali ke List Pasien</a>");
    out.println("</div>");
    out.println("</body>");
    out.println("</html>");
    return;
}
%>
<!-- Form untuk edit data -->
<form action="edit.jsp" method="post">
    <input type="hidden" name="aksi" value="edit">
    <input type="hidden" name="id" value="<%= id %>">
    
    <label for="nama">Nama:</label>
    <input type="text" id="nama" name="nama" value="<%= nama %>" required>
    
    <label for="alamat">Alamat:</label>
    <input type="text" id="alamat" name="alamat" value="<%= alamat %>" required>
    
    <label for="telepon">Telepon:</label>
    <input type="text" id="telepon" name="telepon" value="<%= telepon %>" required>
    
    <label for="tanggal_lahir">Tanggal Lahir:</label>
    <input type="date" id="tanggal_lahir" name="tanggal_lahir" value="<%= tanggalLahir %>" required>
    
    <button type="submit" name="submit" value="update">Update</button>
</form>
<a href="list.jsp" class="back">Back to List</a>
</div>

<script>
// Validasi form sebelum submit
document.querySelector('form').addEventListener('submit', function(e) {
    var nama = document.getElementById('nama').value.trim();
    var alamat = document.getElementById('alamat').value.trim();
    var telepon = document.getElementById('telepon').value.trim();
    var tanggalLahir = document.getElementById('tanggal_lahir').value;
    
    if (!nama || !alamat || !telepon || !tanggalLahir) {
        e.preventDefault();
        alert('Semua field harus diisi!');
        return false;
    }
    
    // Validasi format telepon (hanya angka)
    if (!/^[0-9]+$/.test(telepon)) {
        e.preventDefault();
        alert('Nomor telepon hanya boleh mengandung angka!');
        return false;
    }
    
    return true;
});
</script>
</body>
</html>