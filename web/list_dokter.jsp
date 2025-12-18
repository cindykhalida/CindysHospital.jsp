<%@ page import="java.sql.*, java.text.*" %>
<%@ include file="koneksi.jsp" %>
<html>
<head>
    <title>Data Dokter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #e6f7ff, #f0e6ff);
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            color: #4a90e2;
            text-align: center;
            margin-bottom: 20px;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
        }
        .btn-primary {
            background: #4a90e2;
            color: white;
        }
        .btn-primary:hover {
            background: #3a80d2;
        }
        .btn-success {
            background: #28a745;
            color: white;
        }
        .btn-success:hover {
            background: #218838;
        }
        .btn-warning {
            background: #ffc107;
            color: black;
        }
        .btn-warning:hover {
            background: #e0a800;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background: linear-gradient(to right, #a8d0ff, #c8b3ff);
            color: #333;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f0f7ff;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-aktif {
            background: #d4edda;
            color: #155724;
        }
        .status-cuti {
            background: #fff3cd;
            color: #856404;
        }
        .status-nonaktif {
            background: #f8d7da;
            color: #721c24;
        }
        .search-box {
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .search-box input, .search-box select {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .doctor-photo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #4a90e2;
        }
        .actions {
            display: flex;
            gap: 5px;
        }
    </style>
    <script>
        function confirmDelete(id, name) {
            if (confirm("Apakah Anda yakin ingin menghapus data dokter " + name + "?")) {
                window.location.href = "dokter_action.jsp?action=delete&id=" + id;
            }
        }
        
        function searchDoctors() {
            var keyword = document.getElementById('searchKeyword').value;
            var poli = document.getElementById('searchPoli').value;
            var status = document.getElementById('searchStatus').value;
            
            var url = "list_dokter.jsp?";
            if (keyword) url += "keyword=" + encodeURIComponent(keyword) + "&";
            if (poli) url += "poli=" + poli + "&";
            if (status) url += "status=" + status + "&";
            
            window.location.href = url;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>? Data Dokter Rumah Sakit</h2>
    
    <div class="header-actions">
        <a href="dashboard.jsp" class="btn">? Dashboard</a>
        <div>
            <a href="add_dokter.jsp" class="btn btn-primary">? Tambah Dokter Baru</a>
            <a href="jadwal_dokter.jsp" class="btn btn-success">? Jadwal Dokter</a>
        </div>
    </div>
    
    <!-- Search Box -->
    <div class="search-box">
        <h4>? Pencarian Dokter</h4>
        <input type="text" id="searchKeyword" placeholder="Nama dokter / spesialisasi..." 
               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
        <select id="searchPoli">
            <option value="">Semua Poli</option>
            <%
            try {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM poli WHERE status='Aktif' ORDER BY nama_poli");
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    String selected = rs.getInt("id") == Integer.parseInt(request.getParameter("poli") != null ? request.getParameter("poli") : "0") ? "selected" : "";
            %>
            <option value="<%= rs.getInt("id") %>" <%= selected %>><%= rs.getString("nama_poli") %></option>
            <%
                }
                rs.close();
                ps.close();
            } catch(Exception e) {}
            %>
        </select>
        <select id="searchStatus">
            <option value="">Semua Status</option>
            <option value="Aktif" <%= "Aktif".equals(request.getParameter("status")) ? "selected" : "" %>>Aktif</option>
            <option value="Cuti" <%= "Cuti".equals(request.getParameter("status")) ? "selected" : "" %>>Cuti</option>
            <option value="Nonaktif" <%= "Nonaktif".equals(request.getParameter("status")) ? "selected" : "" %>>Nonaktif</option>
        </select>
        <button class="btn btn-primary" onclick="searchDoctors()">Cari</button>
        <a href="list_dokter.jsp" class="btn">Reset</a>
    </div>
    
    <!-- Dokter Statistics -->
    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-bottom: 20px;">
        <%
        try {
            String sql1 = "SELECT COUNT(*) as total FROM dokter";
            String sql2 = "SELECT COUNT(*) as aktif FROM dokter WHERE status='Aktif'";
            String sql3 = "SELECT COUNT(*) as cuti FROM dokter WHERE status='Cuti'";
            String sql4 = "SELECT COUNT(DISTINCT spesialisasi) as spesialis FROM dokter";
            
            PreparedStatement ps = conn.prepareStatement(sql1);
            ResultSet rs = ps.executeQuery();
            int total = 0, aktif = 0, cuti = 0, spesialis = 0;
            if(rs.next()) total = rs.getInt("total");
            rs.close();
            
            ps = conn.prepareStatement(sql2);
            rs = ps.executeQuery();
            if(rs.next()) aktif = rs.getInt("aktif");
            rs.close();
            
            ps = conn.prepareStatement(sql3);
            rs = ps.executeQuery();
            if(rs.next()) cuti = rs.getInt("cuti");
            rs.close();
            
            ps = conn.prepareStatement(sql4);
            rs = ps.executeQuery();
            if(rs.next()) spesialis = rs.getInt("spesialisasi");
            rs.close();
        %>
        <div style="background: #e3f2fd; padding: 15px; border-radius: 8px; text-align: center;">
            <div style="font-size: 24px; font-weight: bold; color: #1976d2;"><%= total %></div>
            <div>Total Dokter</div>
        </div>
        <div style="background: #e8f5e9; padding: 15px; border-radius: 8px; text-align: center;">
            <div style="font-size: 24px; font-weight: bold; color: #388e3c;"><%= aktif %></div>
            <div>Dokter Aktif</div>
        </div>
        <div style="background: #fff3e0; padding: 15px; border-radius: 8px; text-align: center;">
            <div style="font-size: 24px; font-weight: bold; color: #f57c00;"><%= cuti %></div>
            <div>Sedang Cuti</div>
        </div>
        <div style="background: #f3e5f5; padding: 15px; border-radius: 8px; text-align: center;">
            <div style="font-size: 24px; font-weight: bold; color: #7b1fa2;"><%= spesialis %></div>
            <div>Spesialisasi</div>
        </div>
        <%
        } catch(Exception e) {}
        %>
    </div>
    
    <!-- Doctor Table -->
    <table>
        <thead>
            <tr>
                <th>Foto</th>
                <th>Kode</th>
                <th>Nama Dokter</th>
                <th>Spesialisasi</th>
                <th>Poli</th>
                <th>Telepon</th>
                <th>Biaya Konsul</th>
                <th>Status</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
        <%
        try {
            // Build query berdasarkan parameter search
            String keyword = request.getParameter("keyword");
            String poliId = request.getParameter("poli");
            String status = request.getParameter("status");
            
            StringBuilder sql = new StringBuilder("SELECT d.*, p.nama_poli FROM dokter d LEFT JOIN poli p ON d.id_poli = p.id WHERE 1=1");
            
            if(keyword != null && !keyword.isEmpty()) {
                sql.append(" AND (d.nama_dokter LIKE ? OR d.spesialisasi LIKE ? OR d.kode_dokter LIKE ?)");
            }
            if(poliId != null && !poliId.isEmpty()) {
                sql.append(" AND d.id_poli = ?");
            }
            if(status != null && !status.isEmpty()) {
                sql.append(" AND d.status = ?");
            }
            sql.append(" ORDER BY d.nama_dokter");
            
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if(keyword != null && !keyword.isEmpty()) {
                String likeKeyword = "%" + keyword + "%";
                ps.setString(paramIndex++, likeKeyword);
                ps.setString(paramIndex++, likeKeyword);
                ps.setString(paramIndex++, likeKeyword);
            }
            if(poliId != null && !poliId.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(poliId));
            }
            if(status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            
            ResultSet rs = ps.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            while(rs.next()) {
        %>
            <tr>
                <td align="center">
                    <% if(rs.getString("foto") != null && !rs.getString("foto").isEmpty()) { %>
                        <img src="uploads/<%= rs.getString("foto") %>" class="doctor