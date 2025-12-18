<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<%
String idParam = request.getParameter("id");
if(idParam == null){
    response.sendRedirect("transaksi.jsp");
    return;
}
int id = Integer.parseInt(idParam);

String pasien="", deskripsi="", status="";
double obat=0, inap=0, konsultasi=0, tunai=0;
int hari=0;

if(request.getMethod().equalsIgnoreCase("POST")){
    obat = Double.parseDouble(request.getParameter("obat"));
    inap = Double.parseDouble(request.getParameter("inap"));
    hari = Integer.parseInt(request.getParameter("hari"));
    konsultasi = Double.parseDouble(request.getParameter("konsultasi"));
    tunai = Double.parseDouble(request.getParameter("tunai"));
    deskripsi = request.getParameter("deskripsi");
    status = request.getParameter("status");

    double total = obat + (inap * hari) + konsultasi;
    double sisa = total - tunai;
    double kembalian = tunai > total ? tunai - total : 0;

    PreparedStatement ups = conn.prepareStatement(
        "UPDATE transaksi SET obat=?, inap=?, hari=?, konsultasi=?, jumlah=?, tunai=?, sisa=?, kembalian=?, deskripsi=?, status=? WHERE id=?"
    );
    ups.setDouble(1, obat);
    ups.setDouble(2, inap);
    ups.setInt(3, hari);
    ups.setDouble(4, konsultasi);
    ups.setDouble(5, total);
    ups.setDouble(6, tunai);
    ups.setDouble(7, sisa);
    ups.setDouble(8, kembalian);
    ups.setString(9, deskripsi);
    ups.setString(10, status);
    ups.setInt(11, id);
    ups.executeUpdate();
    ups.close();

    response.sendRedirect("transaksi.jsp");
    return;
}

PreparedStatement ps = conn.prepareStatement(
    "SELECT t.*, p.nama AS pasien FROM transaksi t LEFT JOIN pasien p ON t.id_pasien=p.id WHERE t.id=?"
);
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
if(rs.next()){
    pasien = rs.getString("pasien");
    obat = rs.getDouble("obat");
    inap = rs.getDouble("inap");
    hari = rs.getInt("hari");
    konsultasi = rs.getDouble("konsultasi");
    tunai = rs.getDouble("tunai");
    deskripsi = rs.getString("deskripsi");
    status = rs.getString("status");
}
rs.close(); ps.close();
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Transaksi</title>
<style>
body{
    font-family: Arial, sans-serif;
    background: linear-gradient(to bottom right, #ffe6f0, #e3f2ff);
    padding:20px;
}
.container{
    max-width:700px;
    margin:auto;
    background:#fff;
    padding:25px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}
h2{color:#d6336c; text-align:center;}
label{display:block; margin-top:12px; font-weight:bold; color:#555;}
input, textarea, select{
    width:100%;
    padding:8px;
    margin-top:5px;
    border-radius:6px;
    border:1px solid #ddd;
}
.btn{
    margin-top:20px;
    padding:10px;
    width:100%;
    border:none;
    border-radius:8px;
    background:#4a90e2;
    color:white;
    font-size:14px;
    cursor:pointer;
}
.btn:hover{background:#3a80d2;}
.back{display:block; text-align:center; margin-top:15px; color:#4a90e2; text-decoration:none;}
</style>
</head>
<body>
<div class="container">
<h2>Edit Transaksi</h2>
<form method="post">
    <label>Pasien</label>
    <input type="text" value="<%= pasien %>" disabled>

    <label>Biaya Obat (Rp)</label>
    <input type="number" step="0.01" name="obat" value="<%= obat %>" required>

    <label>Rawat Inap (Rp/Hari)</label>
    <input type="number" step="0.01" name="inap" value="<%= inap %>" required>

    <label>Jumlah Hari</label>
    <input type="number" name="hari" value="<%= hari %>" required>

    <label>Konsultasi (Rp)</label>
    <input type="number" step="0.01" name="konsultasi" value="<%= konsultasi %>" required>

    <label>Tunai (Rp)</label>
    <input type="number" step="0.01" name="tunai" value="<%= tunai %>" required>

    <label>Deskripsi</label>
    <textarea name="deskripsi"><%= deskripsi %></textarea>

    <label>Status</label>
    <select name="status">
        <option value="Pending" <%= "Pending".equals(status)?"selected":"" %>>Pending</option>
        <option value="Lunas" <%= "Lunas".equals(status)?"selected":"" %>>Lunas</option>
        <option value="Batal" <%= "Batal".equals(status)?"selected":"" %>>Batal</option>
    </select>

    <button class="btn" type="submit">Save</button>
</form>
<a class="back" href="transaksi.jsp">Back To Transaction</a>
</div>
</body>
</html>
