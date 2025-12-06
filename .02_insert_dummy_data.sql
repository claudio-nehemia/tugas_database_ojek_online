-- ============================================
-- INSERT DATA DUMMY
-- ============================================

-- ADMIN
INSERT INTO admin (username, password, nama_lengkap, email) VALUES
('admin1', 'admin123', 'Super Admin', 'admin@lumoshive.com'),
('admin2', 'admin456', 'Admin Operasional', 'operasional@lumoshive.com');

-- CUSTOMER
INSERT INTO customer (username, password, nama_lengkap, email, no_telepon, alamat) VALUES
('budi_santoso', 'pass123', 'Budi Santoso', 'budi@email.com', '081234567890', 'Jl. Sudirman No.  10, Jakarta'),
('ani_wijaya', 'pass123', 'Ani Wijaya', 'ani@email. com', '081234567891', 'Jl.  Thamrin No. 20, Jakarta'),
('citra_dewi', 'pass123', 'Citra Dewi', 'citra@email.com', '081234567892', 'Jl. Gatot Subroto No. 30, Jakarta'),
('doni_pratama', 'pass123', 'Doni Pratama', 'doni@email.com', '081234567893', 'Jl. Kuningan No. 40, Jakarta'),
('eka_putri', 'pass123', 'Eka Putri', 'eka@email.com', '081234567894', 'Jl. Senayan No. 50, Jakarta'),
('fajar_hidayat', 'pass123', 'Fajar Hidayat', 'fajar@email. com', '081234567895', 'Jl.  Kemang No. 60, Jakarta'),
('gita_sari', 'pass123', 'Gita Sari', 'gita@email.com', '081234567896', 'Jl. Pondok Indah No.  70, Jakarta'),
('hendra_gun', 'pass123', 'Hendra Gunawan', 'hendra@email.com', '081234567897', 'Jl. BSD No. 80, Tangerang'),
('indah_permata', 'pass123', 'Indah Permata', 'indah@email.com', '081234567898', 'Jl. Bekasi No. 90, Bekasi'),
('joko_widodo', 'pass123', 'Joko Susilo', 'joko@email.com', '081234567899', 'Jl. Depok No. 100, Depok');

-- DRIVER
INSERT INTO driver (username, password, nama_lengkap, email, no_telepon, no_plat_kendaraan, jenis_kendaraan) VALUES
('driver_andi', 'driver123', 'Andi Setiawan', 'andi. driver@email.com', '082345678901', 'B 1234 ABC', 'Honda Vario 150'),
('driver_bambang', 'driver123', 'Bambang Sudrajat', 'bambang.driver@email. com', '082345678902', 'B 2345 DEF', 'Yamaha NMAX'),
('driver_cahyo', 'driver123', 'Cahyo Nugroho', 'cahyo.driver@email.com', '082345678903', 'B 3456 GHI', 'Honda PCX'),
('driver_dedi', 'driver123', 'Dedi Kurniawan', 'dedi.driver@email.com', '082345678904', 'B 4567 JKL', 'Yamaha Aerox'),
('driver_eko', 'driver123', 'Eko Prasetyo', 'eko.driver@email.com', '082345678905', 'B 5678 MNO', 'Honda Beat'),
('driver_feri', 'driver123', 'Feri Irawan', 'feri.driver@email.com', '082345678906', 'B 6789 PQR', 'Yamaha Mio'),
('driver_guntur', 'driver123', 'Guntur Wibowo', 'guntur.driver@email. com', '082345678907', 'B 7890 STU', 'Honda Scoopy'),
('driver_hasan', 'driver123', 'Hasan Abdullah', 'hasan.driver@email. com', '082345678908', 'B 8901 VWX', 'Suzuki NEX');

-- LOKASI
INSERT INTO lokasi (nama_lokasi, daerah, kota, latitude, longitude) VALUES
('Stasiun Sudirman', 'Sudirman', 'Jakarta Pusat', -6.202394, 106.823555),
('Mall Grand Indonesia', 'Thamrin', 'Jakarta Pusat', -6. 195239, 106.821817),
('Monas', 'Gambir', 'Jakarta Pusat', -6.175392, 106.827153),
('Blok M Plaza', 'Blok M', 'Jakarta Selatan', -6. 243856, 106.798631),
('Pondok Indah Mall', 'Pondok Indah', 'Jakarta Selatan', -6. 265847, 106.784382),
('Kemang Village', 'Kemang', 'Jakarta Selatan', -6.260143, 106.813828),
('Senayan City', 'Senayan', 'Jakarta Selatan', -6. 227093, 106.797234),
('Mall Kelapa Gading', 'Kelapa Gading', 'Jakarta Utara', -6.158476, 106.908272),
('Ancol Beach', 'Ancol', 'Jakarta Utara', -6.125833, 106.841944),
('Kota Tua', 'Taman Sari', 'Jakarta Barat', -6. 135218, 106.813301),
('Central Park Mall', 'Tanjung Duren', 'Jakarta Barat', -6. 176850, 106.790140),
('Mall Bekasi', 'Bekasi Selatan', 'Bekasi', -6. 248764, 107.005152),
('Summarecon Bekasi', 'Bekasi Utara', 'Bekasi', -6.225498, 107. 000168),
('Depok Town Square', 'Margonda', 'Depok', -6. 387012, 106.832217),
('Mall Taman Anggrek', 'Grogol', 'Jakarta Barat', -6. 178825, 106.792694);

-- ORDERS (berbagai bulan untuk testing query)
INSERT INTO orders (customer_id, driver_id, lokasi_penjemputan_id, lokasi_tujuan_id, waktu_order, waktu_selesai, status, total_biaya) VALUES
-- November 2025
(1, 1, 1, 2, '2025-11-01 08:30:00', '2025-11-01 09:00:00', 'completed', 25000),
(1, 2, 2, 3, '2025-11-02 09:15:00', '2025-11-02 09:45:00', 'completed', 20000),
(2, 1, 3, 4, '2025-11-03 10:00:00', '2025-11-03 10:40:00', 'completed', 35000),
(3, 3, 4, 5, '2025-11-04 12:30:00', '2025-11-04 13:00:00', 'completed', 28000),
(1, 4, 5, 6, '2025-11-05 14:00:00', '2025-11-05 14:25:00', 'completed', 22000),
(4, 1, 6, 7, '2025-11-06 07:00:00', '2025-11-06 07:35:00', 'completed', 30000),
(5, 2, 7, 8, '2025-11-07 18:30:00', '2025-11-07 19:15:00', 'completed', 45000),
(1, 3, 8, 9, '2025-11-08 20:00:00', '2025-11-08 20:30:00', 'completed', 25000),
(6, 4, 9, 10, '2025-11-09 08:45:00', '2025-11-09 09:20:00', 'completed', 32000),
(7, 5, 10, 11, '2025-11-10 11:00:00', '2025-11-10 11:30:00', 'completed', 27000),
(1, 1, 1, 4, '2025-11-11 13:00:00', '2025-11-11 13:45:00', 'completed', 38000),
(2, 2, 2, 5, '2025-11-12 15:30:00', '2025-11-12 16:15:00', 'completed', 42000),
(8, 3, 3, 6, '2025-11-13 17:00:00', '2025-11-13 17:40:00', 'completed', 35000),
(9, 4, 4, 7, '2025-11-14 19:00:00', '2025-11-14 19:35:00', 'completed', 30000),
(10, 5, 5, 8, '2025-11-15 21:00:00', '2025-11-15 21:50:00', 'completed', 48000),

-- Desember 2025
(1, 1, 1, 3, '2025-12-01 07:30:00', '2025-12-01 08:00:00', 'completed', 23000),
(1, 2, 2, 4, '2025-12-01 09:00:00', '2025-12-01 09:40:00', 'completed', 32000),
(2, 1, 3, 5, '2025-12-01 12:00:00', '2025-12-01 12:45:00', 'completed', 40000),
(3, 3, 1, 6, '2025-12-02 08:00:00', '2025-12-02 08:35:00', 'completed', 28000),
(1, 4, 2, 7, '2025-12-02 10:30:00', '2025-12-02 11:10:00', 'completed', 36000),
(4, 1, 3, 8, '2025-12-02 13:00:00', '2025-12-02 13:55:00', 'completed', 50000),
(5, 2, 4, 9, '2025-12-03 07:00:00', '2025-12-03 07:40:00', 'completed', 35000),
(1, 3, 5, 10, '2025-12-03 08:30:00', '2025-12-03 09:05:00', 'completed', 30000),
(6, 4, 6, 11, '2025-12-03 18:00:00', '2025-12-03 18:30:00', 'completed', 25000),
(1, 5, 7, 12, '2025-12-04 19:30:00', '2025-12-04 20:20:00', 'completed', 55000),
(7, 6, 8, 13, '2025-12-04 20:00:00', '2025-12-04 20:35:00', 'completed', 28000),
(8, 7, 9, 14, '2025-12-05 07:15:00', '2025-12-05 08:00:00', 'completed', 40000),
(1, 8, 10, 15, '2025-12-05 08:00:00', '2025-12-05 08:25:00', 'completed', 22000),
(9, 1, 11, 1, '2025-12-05 12:30:00', '2025-12-05 13:10:00', 'completed', 35000),
(10, 2, 12, 2, '2025-12-05 17:00:00', '2025-12-05 17:50:00', 'completed', 48000),

-- Order pending dan cancelled
(2, NULL, 1, 5, '2025-12-06 08:00:00', NULL, 'pending', 38000),
(3, 1, 2, 6, '2025-12-06 09:00:00', NULL, 'accepted', 32000),
(4, NULL, 3, 7, '2025-12-05 10:00:00', NULL, 'cancelled', 40000);

-- ORDER DETAIL
INSERT INTO order_detail (order_id, jarak_km, durasi_menit, catatan, rating, review) VALUES
(1, 3. 5, 30, 'Perjalanan lancar', 5, 'Driver ramah dan tepat waktu'),
(2, 2.8, 30, NULL, 4, 'Baik'),
(3, 5.2, 40, 'Macet di jalan', 4, 'Cukup baik'),
(4, 4.0, 30, NULL, 5, 'Excellent! '),
(5, 3.2, 25, NULL, 5, 'Very good'),
(6, 4.5, 35, 'Pagi hari', 4, 'Good'),
(7, 8.0, 45, 'Jarak jauh', 5, 'Driver sangat baik'),
(8, 3.8, 30, NULL, 4, NULL),
(9, 5.0, 35, NULL, 5, 'Recommended'),
(10, 4.2, 30, NULL, 4, 'Nice'),
(11, 6.0, 45, NULL, 5, 'Great service'),
(12, 7.5, 45, 'Hujan', 4, 'Baik meski hujan'),
(13, 5.5, 40, NULL, 5, 'Mantap'),
(14, 4.8, 35, NULL, 4, NULL),
(15, 9.0, 50, 'Malam hari', 5, 'Driver hati-hati'),
(16, 3. 0, 30, NULL, 5, 'Pagi yang baik'),
(17, 5.0, 40, NULL, 4, 'OK'),
(18, 7.0, 45, NULL, 5, 'Bagus'),
(19, 4.5, 35, NULL, 4, NULL),
(20, 6.5, 40, NULL, 5, 'Top'),
(21, 8.5, 55, NULL, 5, 'Excellent'),
(22, 5.8, 40, NULL, 4, 'Good'),
(23, 4.2, 35, NULL, 5, 'Nice'),
(24, 3.5, 30, NULL, 4, NULL),
(25, 10.0, 50, NULL, 5, 'Great'),
(26, 4.0, 35, NULL, 5, 'Good'),
(27, 7.2, 45, NULL, 4, NULL),
(28, 3.0, 25, NULL, 5, 'Fast'),
(29, 5.5, 40, NULL, 4, 'OK'),
(30, 9.5, 50, NULL, 5, 'Very good');

-- USER_LOG
INSERT INTO user_log (user_type, user_id, action, login_time, logout_time, is_logged_in) VALUES
-- Customer yang sedang login
('customer', 1, 'login', '2025-12-06 07:00:00', NULL, TRUE),
('customer', 2, 'login', '2025-12-06 07:30:00', NULL, TRUE),
('customer', 3, 'login', '2025-12-06 08:00:00', NULL, TRUE),
('customer', 4, 'login', '2025-12-05 09:00:00', '2025-12-05 17:00:00', FALSE),
('customer', 5, 'login', '2025-12-05 10:00:00', '2025-12-05 18:00:00', FALSE),
('customer', 6, 'login', '2025-12-06 08:30:00', NULL, TRUE),
('customer', 7, 'login', '2025-12-04 08:00:00', '2025-12-04 20:00:00', FALSE),
-- Driver yang sedang login
('driver', 1, 'login', '2025-12-06 06:00:00', NULL, TRUE),
('driver', 2, 'login', '2025-12-06 06:30:00', NULL, TRUE),
('driver', 3, 'login', '2025-12-05 06:00:00', '2025-12-05 22:00:00', FALSE),
('driver', 4, 'login', '2025-12-06 07:00:00', NULL, TRUE),
('driver', 5, 'login', '2025-12-05 07:00:00', '2025-12-05 21:00:00', FALSE);
