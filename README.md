# CindysHospital.jsp
Sistem Informasi Rumah Sakit merupakan aplikasi berbasis komputer yang dirancang untuk membantu pengelolaan data pasien, antrian online, serta transaksi pelayanan secara terstruktur dan terkomputerisasi sehingga mempermudah administrasi rumah sakit dan meningkatkan efisiensi pelayanan. Proyek dibuat untuk keperluan tugas dan pembelajaran.
### 🎯 Fitur Aplikasi

* Login Admin
* Manajemen data pasien
* Booking antrian pasien secara online
* Cetak bukti antrian pasien
* Manajemen transaksi pasien
* Edit dan hapus data pasien
* Edit dan hapus data transaksi pasien
* Logout sistem

---

### 🔐 Informasi Login

Gunakan akun berikut untuk masuk ke sistem:

* **Username:** `cindy`
* **Password:** `0903`

---

### 🛠️ Teknologi yang Digunakan

* Java JSP
* MySQL
* Apache Tomcat
* NetBeans IDE

---

### 🗄️ Struktur Database

**Nama Database:** `db_rumahsakit`

**Tabel Utama:**

* `users` (admin)
* `pasien`
* `antrian`
* `transaksi`

---

### 📝 Catatan

Seluruh data yang digunakan pada aplikasi ini merupakan **data dummy (contoh)** dan hanya digunakan untuk **keperluan pembelajaran**, bukan data rumah sakit yang sebenarnya.

---

# 📘 (3) Buku Panduan Pengguna

## Sistem Informasi Rumah Sakit

### 1. Halaman Login

1. Buka aplikasi Sistem Informasi Rumah Sakit.
2. Masukkan:

   * Username: **cindy**
   * Password: **0903**
3. Klik tombol **Login**.
4. Jika username dan password benar, sistem akan menampilkan halaman dashboard.

---

### 2. Dashboard

Pada halaman dashboard, admin dapat mengakses menu:

* Data Pasien
* Booking Antrian
* Transaksi Pasien
* Logout

---

### 3. Menambahkan Data Booking Antrian Pasien

1. Pilih menu **Booking Antrian**.
2. Klik tombol **Tambah Antrian**.
3. Isi data pasien sesuai form yang tersedia.
4. Klik tombol **Simpan**.
5. Data antrian akan tersimpan dan dapat **dicetak sebagai bukti antrian**.

---

### 4. Mencetak Bukti Antrian

1. Pilih data antrian pasien.
2. Klik tombol **Cetak Antrian**.
3. Sistem akan menampilkan bukti antrian yang siap dicetak.

---

### 5. Menambahkan Data Pasien

1. Pilih menu **Data Pasien**.
2. Klik tombol **Tambah Pasien**.
3. Isi data pasien dengan lengkap.
4. Klik tombol **Simpan**.
5. Data pasien akan tersimpan ke dalam database.

---

### 6. Mengedit dan Menghapus Data Pasien

* **Edit Data Pasien**

  1. Pilih data pasien.
  2. Klik tombol **Edit**.
  3. Ubah data yang diperlukan.
  4. Klik **Simpan**.

* **Hapus Data Pasien**

  1. Pilih data pasien.
  2. Klik tombol **Hapus**.
  3. Konfirmasi penghapusan data.

---

### 7. Menambahkan Data Transaksi Pasien

1. Pilih menu **Transaksi Pasien**.
2. Klik tombol **Tambah Transaksi**.
3. Pilih data pasien.
4. Isi detail transaksi (jenis layanan, biaya, dll).
5. Klik tombol **Simpan**.

---

### 8. Mengedit dan Menghapus Data Transaksi Pasien

* **Edit Transaksi**

  1. Pilih data transaksi.
  2. Klik tombol **Edit**.
  3. Perbarui data transaksi.
  4. Klik **Simpan**.

* **Hapus Transaksi**

  1. Pilih data transaksi.
  2. Klik tombol **Hapus**.
  3. Konfirmasi penghapusan.

---

### 9. Logout

1. Klik menu **Logout**.
2. Sistem akan mengakhiri sesi dan kembali ke halaman login.

---
# 🏩 Link Youtube Video Demo Aplikasi

https://youtu.be/3W17LEjtpyc?si=mHtsrdTwBPUjVm6d

# 💻 Cara Menjalankan Aplikasi 

1. Import database dbrumahsakit.sql ke phpMyAdmin
2. Jalankan project menggunakan Apache Tomcat
3. Akses aplikasi melalui browser: http://localhost:8080/rumahsakit/login.jsp

# 👩🏻‍💻 Author
Cindy Khalida
