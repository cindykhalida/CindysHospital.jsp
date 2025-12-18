<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<%
String aksi = request.getParameter("aksi");

/* ===== VAR CETAK STRUK ===== */
boolean cetak = false;
String cetakNama = "";
String cetakPoli = "";
String cetakWaktu = "";
int cetakNo = 0;

/* ===== TAMBAH ANTRIAN ===== */
if("tambah".equals(aksi)){
    String nama = request.getParameter("nama");
    String poli = request.getParameter("poli");

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO antrian (nama_pasien, poli, status, waktu_daftar) VALUES (?, ?, 'Menunggu', NOW())",
        Statement.RETURN_GENERATED_KEYS
    );
    ps.setString(1, nama);
    ps.setString(2, poli);
    ps.executeUpdate();

    ResultSet gen = ps.getGeneratedKeys();
    if(gen.next()){
        int lastId = gen.getInt(1);
        PreparedStatement ps2 = conn.prepareStatement(
            "SELECT * FROM antrian WHERE id=?"
        );
        ps2.setInt(1, lastId);
        ResultSet rs2 = ps2.executeQuery();
        if(rs2.next()){
            cetak = true;
            cetakNo = rs2.getInt("id");
            cetakNama = rs2.getString("nama_pasien");
            cetakPoli = rs2.getString("poli");
            cetakWaktu = rs2.getString("waktu_daftar");
        }
        rs2.close();
        ps2.close();
    }
    gen.close();
    ps.close();
}

/* ===== PANGGIL ===== */
if("panggil".equals(aksi)){
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = conn.prepareStatement(
        "UPDATE antrian SET status='Dipanggil' WHERE id=?"
    );
    ps.setInt(1, id);
    ps.executeUpdate();
    ps.close();
}

/* ===== SELESAI ===== */
if("selesai".equals(aksi)){
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = conn.prepareStatement(
        "UPDATE antrian SET status='Selesai' WHERE id=?"
    );
    ps.setInt(1, id);
    ps.executeUpdate();
    ps.close();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Antrian Online</title>
<style>
body{
    font-family:Arial, sans-serif;
    background:linear-gradient(to bottom right,#ffe6f0,#e3f2ff);
    padding:20px;
}
h2{color:#d6336c;}
.container{
    background:#fff;
    padding:20px;
    border-radius:14px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

/* ===== FORM & TABLE ===== */
input,select{
    padding:8px;
    border-radius:6px;
    border:1px solid #ddd;
    width:100%;
    margin-bottom:10px;
}
button{
    padding:8px 12px;
    border:none;
    border-radius:8px;
    background:#8cc9ff;
    color:#fff;
    cursor:pointer;
}
button:hover{background:#6fbaff;}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}
th,td{
    border:1px solid #eee;
    padding:8px;
    text-align:center;
}
th{
    background:#ffd6eb;
    color:#d6336c;
}

/* ===== STRUK ===== */
#struk{
    width:100%;
    margin:20px auto;
    background:#ffffff;
    border-radius:18px;
    border:3px solid #ffd6eb;
    padding:25px;
    box-shadow:0 0 20px rgba(255,156,201,0.45);
}

#struk .title{
    text-align:center;
    font-size:26px;
    font-weight:bold;
    color:#ff6fa4;
}

#struk .subtitle{
    text-align:center;
    color:#5fa8dd;
    margin-bottom:15px;
}

#struk .nomor{
    text-align:center;
    font-size:72px;
    font-weight:bold;
    color:#ffffff;
    background:linear-gradient(to right,#ff9cc9,#8cc9ff);
    border-radius:16px;
    padding:25px 0;
    margin:20px 0;
}

#struk hr{
    border:none;
    border-top:2px dashed #ffc1dc;
    margin:15px 0;
}

#struk p{
    font-size:15px;
    margin:6px 0;
}

#struk .footer{
    text-align:center;
    font-size:13px;
    color:#777;
    margin-top:10px;
}

#struk .btn-print{
    margin-top:15px;
    width:100%;
    padding:12px;
    font-size:15px;
    background:#ff9cc9;
    border-radius:12px;
}

/* ===== PRINT ===== */
@media print {
    body * { visibility: hidden; }
    #struk, #struk * { visibility: visible; }
    #struk {
        position:absolute;
        left:0;
        top:0;
        width:100%;
        box-shadow:none;
        border-radius:0;
    }
}
</style>
</head>

<body>
<h2>Antrian Online</h2>

<div class="container">

<form method="post" action="antrian.jsp?aksi=tambah">
    <label>Nama Pasien</label>
    <input type="text" name="nama" required>

    <label>Poli</label>
    <select name="poli">
        <option>Umum</option>
        <option>Gigi</option>
        <option>Anak</option>
        <option>Kandungan</option>
    </select>

    <button type="submit">Ambil Antrian</button>
</form>

<% if(cetak){ %>
<div id="struk">
    <div class="title">Cindy's Hospital</div>
    <div class="subtitle">Nomor Antrian Anda</div>

    <div class="nomor"><%= cetakNo %></div>

    <hr>
    <p>Nama Pasien : <b><%= cetakNama %></b></p>
    <p>Poli : <b><%= cetakPoli %></b></p>
    <p>Status : <b>Menunggu</b></p>
    <p>Waktu Daftar : <%= cetakWaktu %></p>
    <hr>

    <div class="footer">
        Harap menunggu hingga nomor Anda dipanggil
    </div>

    <button class="btn-print" onclick="window.print()">Cetak Struk</button>
</div>
<% } %>

<table>
<tr>
    <th>No</th>
    <th>Nama</th>
    <th>Poli</th>
    <th>Status</th>
    <th>Aksi</th>
</tr>

<%
PreparedStatement ps = conn.prepareStatement(
    "SELECT * FROM antrian ORDER BY id ASC"
);
ResultSet rs = ps.executeQuery();
int no=1;
while(rs.next()){
    String st = rs.getString("status");
%>
<tr>
    <td><%= no++ %></td>
    <td><%= rs.getString("nama_pasien") %></td>
    <td><%= rs.getString("poli") %></td>
    <td><%= st %></td>
    <td>
        <% if("Menunggu".equals(st)){ %>
            <a href="antrian.jsp?aksi=panggil&id=<%= rs.getInt("id") %>">Panggil</a>
        <% } else if("Dipanggil".equals(st)){ %>
            <a href="antrian.jsp?aksi=selesai&id=<%= rs.getInt("id") %>">Selesai</a>
        <% } %>
    </td>
</tr>
<% } rs.close(); ps.close(); %>
</table>

</div>

<br>
<a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
