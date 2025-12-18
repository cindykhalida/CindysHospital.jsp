<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<%
// Cek apakah ada parameter hapus
String aksi = request.getParameter("aksi");
String idHapus = request.getParameter("id_hapus");

if ("hapus".equals(aksi) && idHapus != null) {
        int id = Integer.parseInt(idHapus);
        PreparedStatement ps = conn.prepareStatement("DELETE FROM transaksi WHERE id=?");
        ps.setInt(1, id);
        int rowsAffected = ps.executeUpdate();
        ps.close();
        

}
%>
<html>
<head>
    <title>List Transaksi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffe6f0, #e3f2ff);
            padding: 20px;
        }

        h2 { 
            color: #d6336c; 
        }

        a {
            color: #4a90e2; 
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        th {
            background: linear-gradient(to right, #f8c1d9, #cbe3ff);
            color: #d6336c;
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        td {
            border: 1px solid #eee;
            padding: 8px;
            text-align: center;
        }

        tr:nth-child(even) { 
            background-color: #fff5fa; 
        }

        tr:nth-child(odd) { 
            background-color: #f4f9ff;
        }
        
        .btn-hapus {
            background: #ff6b6b;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 12px;
            transition: 0.3s;
        }
        
        .btn-hapus:hover {
            background: #ff5252;
            text-decoration: none;
        }
        
        .btn-edit {
            background: #4a90e2;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 12px;
            margin-right: 5px;
            transition: 0.3s;
        }
        
        .btn-edit:hover {
            background: #3a80d2;
            text-decoration: none;
        }
        
        .aksi-container {
            display: flex;
            justify-content: center;
            gap: 5px;
        }
    </style>
    <script>
    function konfirmasiHapus(id) {
        if (confirm("Apakah Anda yakin ingin menghapus transaksi ini?")) {
            window.location.href = 'transaksi.jsp?aksi=hapus&id_hapus=' + id;
        }
        return false;
    }
    </script>
</head>
<body>
<h2>List Transaksi</h2>
<a href="add_transaksi.jsp">Tambah Transaksi</a><br><br>

<table>
    <tr>
        <th>ID</th>
        <th>Pasien</th>
        <th>Obat (Rp)</th>
        <th>Rawat Inap (Rp/Hari)</th>
        <th>Hari</th>
        <th>Konsultasi (Rp)</th>
        <th>Total (Rp)</th>
        <th>Tunai (Rp)</th>
        <th>Sisa (Rp)</th>
        <th>Kembalian (Rp)</th>
        <th>Deskripsi</th>
        <th>Status</th>
        <th>Dibuat Pada</th>
        <th>Diverifikasi Pada</th>
        <th>Aksi</th>
    </tr>
<%
    try{
        String sql = "SELECT t.*, p.nama AS pasien FROM transaksi t LEFT JOIN pasien p ON t.id_pasien=p.id ORDER BY t.id DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            double total = rs.getDouble("jumlah");
            double tunai = rs.getDouble("tunai");
            double sisa = rs.getDouble("sisa");
            double kembalian = rs.getDouble("kembalian");
            
            // Format nilai
            String formatTotal = String.format("%,.2f", total);
            String formatTunai = String.format("%,.2f", tunai);
            String formatSisa = String.format("%,.2f", sisa);
            String formatKembalian = String.format("%,.2f", kembalian);
            String formatObat = String.format("%,.2f", rs.getDouble("obat"));
            String formatInap = String.format("%,.2f", rs.getDouble("inap"));
            String formatKonsultasi = String.format("%,.2f", rs.getDouble("konsultasi"));
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("pasien") %></td>
        <td><%= formatObat %></td>
        <td><%= formatInap %></td>
        <td><%= rs.getInt("hari") %></td>
        <td><%= formatKonsultasi %></td>
        <td><strong><%= formatTotal %></strong></td>
        <td><%= formatTunai %></td>
        <td><%= formatSisa %></td>
        <td><%= formatKembalian %></td>
        <td><%= rs.getString("deskripsi") %></td>
        <td>
            <span style="padding: 3px 8px; border-radius: 4px; font-size: 12px; 
                <%= "Lunas".equals(rs.getString("status")) ? "background:#d4edda; color:#155724;" : 
                   "Pending".equals(rs.getString("status")) ? "background:#fff3cd; color:#856404;" : 
                   "background:#f8d7da; color:#721c24;" %>">
                <%= rs.getString("status") %>
            </span>
        </td>
        <td><%= rs.getTimestamp("dibuat_pada") %></td>
        <td><%= rs.getTimestamp("diverifikasi_pada") != null ? rs.getTimestamp("diverifikasi_pada") : "-" %></td>
        <td>
            <div class="aksi-container">
                <a href="edit_transaksi.jsp?id=<%= rs.getInt("id") %>" class="btn-edit">Edit</a>
                <a href="#" onclick="return konfirmasiHapus(<%= rs.getInt("id") %>)" class="btn-hapus">Hapus</a>
            </div>
        </td>
    </tr>
<%
        }
        rs.close();
        ps.close();
    }catch(Exception e){
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
</table>

<br><a href="dashboard.jsp">Back To Dashboard</a>

<script>
// Fungsi untuk hapus dengan konfirmasi
function hapusTransaksi(id) {
    if (confirm("Apakah Anda yakin ingin menghapus transaksi ID: " + id + "?")) {
        window.location.href = "transaksi.jsp?aksi=hapus&id_hapus=" + id;
    }
}

// Alert jika ada parameter sukses
<%
if ("sukses".equals(request.getParameter("message"))) {
    out.println("alert('Data transaksi berhasil dihapus!');");
}
%>

// Setelah hapus, kembali ke list transaksi
window.onload = function() {
    // Cek jika baru saja menghapus
    if (window.location.search.includes('aksi=hapus')) {
        // Redirect ke list transaksi tanpa parameter
        setTimeout(function() {
            window.location.href = 'transaksi.jsp';
        }, 100);
    }
};
</script>
</body>
</html>