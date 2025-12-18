<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tambah Transaksi</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffe0ec, #d6ecff); 
            /* pink pastel ? biru pastel */
            padding: 40px;
            margin: 0;
        }

        .container {
            max-width: 650px;
            background: #ffffff;
            margin: auto;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 0 25px rgba(0,0,0,0.1);
            border: 2px solid #ffd6eb;
        }

        h2 {
            text-align: center;
            color: #ff6fa4; /* pink pastel */
            margin-top: 0;
        }

        label {
            font-weight: bold;
            color: #6fa8dc; /* biru pastel */
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 10px;
            border: 1px solid #bbb;
            background-color: #f8f9fc;
        }

        input[readonly] {
            background-color: #f2edf3;
        }

        input[type=submit] {
            background: #ff9cc9;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            border-radius: 12px;
            padding: 12px;
            transition: 0.2s;
        }

        input[type=submit]:hover {
            background: #ff7fb6;
        }

        a {
            text-decoration: none;
            color: #6fa8dc;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .msg-success {
            color: green;
            font-weight: bold;
        }
        .msg-error {
            color: red;
            font-weight: bold;
        }
    </style>

    <script>
        function updateTotal() {
            var obat = parseFloat(document.getElementById("obat").value);
            var inap = parseFloat(document.getElementById("inap").value);
            var hari = parseInt(document.getElementById("hari").value);
            var konsultasi = parseFloat(document.getElementById("konsultasi").value);
            var tunai = parseFloat(document.getElementById("dibayar").value);

            if (isNaN(hari)) hari = 0;
            if (isNaN(tunai)) tunai = 0;

            var total = obat + (inap * hari) + konsultasi;
            var sisa = total - tunai;
            var kembalian = 0;

            if (tunai >= total) {
                kembalian = tunai - total;
                sisa = 0;
            }

            document.getElementById("total").value = total.toFixed(2);
            document.getElementById("sisa").value = sisa.toFixed(2);
            document.getElementById("kembalian").value = kembalian.toFixed(2);
        }
    </script>
</head>

<body>

<div class="container">
<h2>Tambah Transaksi</h2>

<%
    if (request.getParameter("submit") != null) {
        try {
            int id_pasien = Integer.parseInt(request.getParameter("id_pasien"));
            double obat = Double.parseDouble(request.getParameter("obat"));
            double inap = Double.parseDouble(request.getParameter("inap"));
            int hari = Integer.parseInt(request.getParameter("hari"));
            double konsultasi = Double.parseDouble(request.getParameter("konsultasi"));
            double tunai = Double.parseDouble(request.getParameter("dibayar"));

            double total = obat + (inap * hari) + konsultasi;
            double sisa = total - tunai;
            double kembalian = tunai >= total ? tunai - total : 0;
            if (tunai >= total) sisa = 0;

            String deskripsi = request.getParameter("deskripsi");

            String sql = "INSERT INTO transaksi(id_pasien, obat, inap, hari, konsultasi, jumlah, tunai, sisa, kembalian, deskripsi, status, diverifikasi_oleh, diverifikasi_pada) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'VERIFIKASI', NULL, NOW())";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id_pasien);
            ps.setDouble(2, obat);
            ps.setDouble(3, inap);
            ps.setInt(4, hari);
            ps.setDouble(5, konsultasi);
            ps.setDouble(6, total);
            ps.setDouble(7, tunai);
            ps.setDouble(8, sisa);
            ps.setDouble(9, kembalian);
            ps.setString(10, deskripsi);
            ps.executeUpdate();
            ps.close();
%>
<p class="msg-success">Transaksi berhasil ditambahkan!</p>
<%
        } catch (Exception e) {
            out.println("<p class='msg-error'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<form method="post">

    <label>Pasien:</label>
    <select name="id_pasien" required>
        <%
            PreparedStatement ps2 = conn.prepareStatement("SELECT id, nama FROM pasien");
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
        %>
        <option value="<%= rs2.getInt("id") %>"><%= rs2.getString("nama") %></option>
        <% } rs2.close(); ps2.close(); %>
    </select>

    <label>Obat (Rp):</label>
    <select id="obat" name="obat" onchange="updateTotal()">
        <option value="0">0</option>
        <option value="50000">50,000</option>
        <option value="75000">75,000</option>
    </select>

    <label>Rawat Inap per Hari (Rp):</label>
    <select id="inap" name="inap" onchange="updateTotal()">
        <option value="0">0</option>
        <option value="150000">150,000</option>
        <option value="200000">200,000</option>
    </select>

    <label>Hari:</label>
    <input type="number" id="hari" name="hari" value="1" min="1" onchange="updateTotal()">

    <label>Konsultasi (Rp):</label>
    <select id="konsultasi" name="konsultasi" onchange="updateTotal()">
        <option value="0">0</option>
        <option value="50000">50,000</option>
        <option value="75000">75,000</option>
    </select>

    <label>Tunai yang dibayar:</label>
    <input type="number" id="dibayar" name="dibayar" value="0" min="0" onchange="updateTotal()">

    <label>Total biaya:</label>
    <input type="text" id="total" readonly>

    <label>Sisa bayar:</label>
    <input type="text" id="sisa" readonly>

    <label>Kembalian:</label>
    <input type="text" id="kembalian" readonly>

    <label>Deskripsi:</label>
    <textarea name="deskripsi" required></textarea>

    <input type="submit" name="submit" value="Tambah Transaksi">
</form>

<br>
<a href="transaksi.jsp">Back to Transaction</a>
</div>

</body>
</html>
