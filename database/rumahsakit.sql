-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 18 Des 2025 pada 10.21
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rumahsakit`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `antrian`
--

CREATE TABLE `antrian` (
  `id` int(11) NOT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `poli` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `waktu_daftar` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `antrian`
--

INSERT INTO `antrian` (`id`, `nama_pasien`, `poli`, `status`, `waktu_daftar`) VALUES
(1, 'cindy', 'Gigi', 'Selesai', '2025-12-15 14:01:24'),
(2, 'lala', 'Kandungan', 'Selesai', '2025-12-15 14:02:04'),
(3, 'joe', 'Kandungan', 'Selesai', '2025-12-16 08:28:59'),
(4, 'joe', 'Kandungan', 'Dipanggil', '2025-12-16 08:33:54'),
(5, 'joe', 'Umum', 'Dipanggil', '2025-12-16 08:35:59'),
(6, 'cutan', 'Anak', 'Dipanggil', '2025-12-16 08:36:29'),
(7, 'cindy', 'Anak', 'Dipanggil', '2025-12-16 08:42:28'),
(8, 'cutan', 'Anak', 'Menunggu', '2025-12-16 08:43:14'),
(9, 'cutan', 'Anak', 'Dipanggil', '2025-12-16 08:48:21'),
(10, 'lili', 'Umum', 'Menunggu', '2025-12-18 15:11:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `spesialis` varchar(100) DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id`, `nama`, `spesialis`, `telepon`) VALUES
(1, 'Dr. Cindy Khalida, Sp.PD', 'Penyakit Dalam', '081234567890'),
(2, 'Dr. Kim Mingyu, Sp.KG', 'Kedokteran Gigi', '081234567891'),
(3, 'Dr. Sylus, Sp.A', 'Anak', '081234567892'),
(4, 'Dr. Chelsa Jo Agatha, Sp.B', 'Bedah', '081234567893'),
(5, 'Dr. Lala Rh, Sp.JP', 'Jantung', '081234567894');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_kontrol`
--

CREATE TABLE `jadwal_kontrol` (
  `id` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `tanggal_kontrol` date NOT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kasir_shift`
--

CREATE TABLE `kasir_shift` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nama_kasir` varchar(100) DEFAULT NULL,
  `shift_mulai` timestamp NOT NULL DEFAULT current_timestamp(),
  `shift_selesai` timestamp NULL DEFAULT NULL,
  `saldo_awal` decimal(12,2) DEFAULT 0.00,
  `saldo_akhir` decimal(12,2) DEFAULT 0.00,
  `total_transaksi` int(11) DEFAULT 0,
  `total_pendapatan` decimal(12,2) DEFAULT 0.00,
  `status` varchar(20) DEFAULT 'Aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `otoritas`
--

CREATE TABLE `otoritas` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `level_akses` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `alamat`, `telepon`, `tanggal_lahir`) VALUES
(12, 'yuki', 'xgandu', '089262962839', '2025-06-10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `poli`
--

CREATE TABLE `poli` (
  `id` int(11) NOT NULL,
  `kode_poli` varchar(10) DEFAULT NULL,
  `nama_poli` varchar(50) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `biaya_konsultasi` decimal(10,2) DEFAULT 0.00,
  `status` enum('Aktif','Nonaktif') DEFAULT 'Aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `poli`
--

INSERT INTO `poli` (`id`, `kode_poli`, `nama_poli`, `deskripsi`, `biaya_konsultasi`, `status`, `created_at`) VALUES
(1, 'UMUM', 'Poli Umum', NULL, 75000.00, 'Aktif', '2025-12-10 16:50:22'),
(2, 'GIGI', 'Poli Gigi', NULL, 100000.00, 'Aktif', '2025-12-10 16:50:22'),
(3, 'ANAK', 'Poli Anak', NULL, 85000.00, 'Aktif', '2025-12-10 16:50:22'),
(4, 'BEDAH', 'Poli Bedah', NULL, 150000.00, 'Aktif', '2025-12-10 16:50:22'),
(5, 'JANTUNG', 'Poli Jantung', NULL, 200000.00, 'Aktif', '2025-12-10 16:50:22'),
(6, 'KULIT', 'Poli Kulit & Kelamin', NULL, 120000.00, 'Aktif', '2025-12-10 16:50:22'),
(7, 'MATA', 'Poli Mata', NULL, 90000.00, 'Aktif', '2025-12-10 16:50:22'),
(8, 'THT', 'Poli THT', NULL, 95000.00, 'Aktif', '2025-12-10 16:50:22'),
(9, 'SARAF', 'Poli Saraf', NULL, 180000.00, 'Aktif', '2025-12-10 16:50:22'),
(10, 'PSIK', 'Poli Psikiatri', NULL, 175000.00, 'Aktif', '2025-12-10 16:50:22'),
(11, 'OBGYN', 'Poli Kandungan', NULL, 125000.00, 'Aktif', '2025-12-10 16:50:22'),
(12, 'FISIOT', 'Poli Fisioterapi', NULL, 80000.00, 'Aktif', '2025-12-10 16:50:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `obat` double DEFAULT 0,
  `inap` double DEFAULT 0,
  `hari` int(11) DEFAULT 0,
  `konsultasi` double DEFAULT 0,
  `jumlah` double DEFAULT 0,
  `tunai` double DEFAULT 0,
  `sisa` double DEFAULT 0,
  `kembalian` double DEFAULT 0,
  `deskripsi` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `diverifikasi_oleh` varchar(50) DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diverifikasi_pada` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `id_pasien`, `obat`, `inap`, `hari`, `konsultasi`, `jumlah`, `tunai`, `sisa`, `kembalian`, `deskripsi`, `status`, `diverifikasi_oleh`, `dibuat_pada`, `diverifikasi_pada`) VALUES
(13, 12, 75000, 150000, 300, 50000, 45125000, 90000000, -44875000, 44875000, 'suka ngejar orang', 'Lunas', NULL, '2025-12-16 01:28:19', '2025-12-16 01:28:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `antrian`
--
ALTER TABLE `antrian`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jadwal_kontrol`
--
ALTER TABLE `jadwal_kontrol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indeks untuk tabel `kasir_shift`
--
ALTER TABLE `kasir_shift`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `otoritas`
--
ALTER TABLE `otoritas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `poli`
--
ALTER TABLE `poli`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_poli` (`kode_poli`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pasien` (`id_pasien`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `antrian`
--
ALTER TABLE `antrian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `jadwal_kontrol`
--
ALTER TABLE `jadwal_kontrol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kasir_shift`
--
ALTER TABLE `kasir_shift`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `otoritas`
--
ALTER TABLE `otoritas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `poli`
--
ALTER TABLE `poli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jadwal_kontrol`
--
ALTER TABLE `jadwal_kontrol`
  ADD CONSTRAINT `jadwal_kontrol_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_kontrol_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `otoritas`
--
ALTER TABLE `otoritas`
  ADD CONSTRAINT `otoritas_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
