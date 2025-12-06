-- ============================================
-- QUERY-QUERY UNTUK SEMUA FITUR
-- Aplikasi Ojek Online - Lumoshive Tech
-- ============================================

-- ============================================
-- FITUR 1: Menampilkan total order setiap bulan
-- ============================================
SELECT 
    TO_CHAR(waktu_order, 'YYYY-MM') AS bulan,
    TO_CHAR(waktu_order, 'Month YYYY') AS nama_bulan,
    COUNT(*) AS total_order,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) AS order_selesai,
    COUNT(CASE WHEN status = 'cancelled' THEN 1 END) AS order_batal,
    COUNT(CASE WHEN status IN ('pending', 'accepted', 'on_the_way') THEN 1 END) AS order_ongoing,
    SUM(CASE WHEN status = 'completed' THEN total_biaya ELSE 0 END) AS total_pendapatan
FROM orders
GROUP BY TO_CHAR(waktu_order, 'YYYY-MM'), TO_CHAR(waktu_order, 'Month YYYY')
ORDER BY bulan DESC;


-- ============================================
-- FITUR 2: Nama customer yang paling sering melakukan order tiap bulan
-- ============================================
WITH customer_order_monthly AS (
    SELECT 
        TO_CHAR(o.waktu_order, 'YYYY-MM') AS bulan,
        TO_CHAR(o.waktu_order, 'Month YYYY') AS nama_bulan,
        c.customer_id,
        c.nama_lengkap,
        COUNT(*) AS jumlah_order,
        RANK() OVER (PARTITION BY TO_CHAR(o.waktu_order, 'YYYY-MM') ORDER BY COUNT(*) DESC) AS ranking
    FROM orders o
    JOIN customer c ON o.customer_id = c. customer_id
    GROUP BY TO_CHAR(o.waktu_order, 'YYYY-MM'), TO_CHAR(o.waktu_order, 'Month YYYY'), c. customer_id, c.nama_lengkap
)
SELECT 
    bulan,
    nama_bulan,
    nama_lengkap AS customer_teraktif,
    jumlah_order
FROM customer_order_monthly
WHERE ranking = 1
ORDER BY bulan DESC;


-- ============================================
-- FITUR 3: Daerah/lokasi dengan jumlah order terbanyak
-- ============================================
-- 3a. Berdasarkan lokasi penjemputan
SELECT 
    l. daerah,
    l.kota,
    COUNT(*) AS total_order_dari_lokasi_ini,
    SUM(o.total_biaya) AS total_pendapatan
FROM orders o
JOIN lokasi l ON o.lokasi_penjemputan_id = l.lokasi_id
WHERE o.status = 'completed'
GROUP BY l.daerah, l.kota
ORDER BY total_order_dari_lokasi_ini DESC
LIMIT 10;

-- 3b. Berdasarkan lokasi tujuan
SELECT 
    l.daerah,
    l.kota,
    COUNT(*) AS total_order_ke_lokasi_ini
FROM orders o
JOIN lokasi l ON o.lokasi_tujuan_id = l.lokasi_id
WHERE o. status = 'completed'
GROUP BY l.daerah, l.kota
ORDER BY total_order_ke_lokasi_ini DESC
LIMIT 10;

-- 3c.  Kombinasi (penjemputan + tujuan)
SELECT 
    l. daerah,
    l.kota,
    SUM(CASE WHEN o. lokasi_penjemputan_id = l.lokasi_id THEN 1 ELSE 0 END) AS sebagai_penjemputan,
    SUM(CASE WHEN o.lokasi_tujuan_id = l.lokasi_id THEN 1 ELSE 0 END) AS sebagai_tujuan,
    COUNT(*) AS total_aktivitas
FROM orders o
JOIN lokasi l ON o.lokasi_penjemputan_id = l.lokasi_id OR o.lokasi_tujuan_id = l.lokasi_id
WHERE o.status = 'completed'
GROUP BY l.daerah, l.kota
ORDER BY total_aktivitas DESC;


-- ============================================
-- FITUR 4: Waktu (jam) order ramai dan sepi
-- ============================================
-- 4a. Distribusi order per jam
SELECT 
    EXTRACT(HOUR FROM waktu_order) AS jam,
    COUNT(*) AS jumlah_order,
    CASE 
        WHEN COUNT(*) >= 5 THEN 'RAMAI'
        WHEN COUNT(*) >= 3 THEN 'SEDANG'
        ELSE 'SEPI'
    END AS kategori
FROM orders
GROUP BY EXTRACT(HOUR FROM waktu_order)
ORDER BY jam;

-- 4b. Jam paling ramai (TOP 5)
SELECT 
    EXTRACT(HOUR FROM waktu_order) AS jam,
    CONCAT(EXTRACT(HOUR FROM waktu_order)::TEXT, ':00 - ', (EXTRACT(HOUR FROM waktu_order) + 1)::TEXT, ':00') AS rentang_waktu,
    COUNT(*) AS jumlah_order,
    'RAMAI' AS status
FROM orders
GROUP BY EXTRACT(HOUR FROM waktu_order)
ORDER BY jumlah_order DESC
LIMIT 5;

-- 4c. Jam paling sepi (TOP 5)
SELECT 
    EXTRACT(HOUR FROM waktu_order) AS jam,
    CONCAT(EXTRACT(HOUR FROM waktu_order)::TEXT, ':00 - ', (EXTRACT(HOUR FROM waktu_order) + 1)::TEXT, ':00') AS rentang_waktu,
    COUNT(*) AS jumlah_order,
    'SEPI' AS status
FROM orders
GROUP BY EXTRACT(HOUR FROM waktu_order)
ORDER BY jumlah_order ASC
LIMIT 5;

-- 4d. Ringkasan jam ramai vs sepi
WITH hourly_stats AS (
    SELECT 
        EXTRACT(HOUR FROM waktu_order) AS jam,
        COUNT(*) AS jumlah_order
    FROM orders
    GROUP BY EXTRACT(HOUR FROM waktu_order)
)
SELECT 
    'Jam Paling Ramai' AS kategori,
    jam::TEXT || ':00' AS waktu,
    jumlah_order
FROM hourly_stats
WHERE jumlah_order = (SELECT MAX(jumlah_order) FROM hourly_stats)
UNION ALL
SELECT 
    'Jam Paling Sepi' AS kategori,
    jam::TEXT || ':00' AS waktu,
    jumlah_order
FROM hourly_stats
WHERE jumlah_order = (SELECT MIN(jumlah_order) FROM hourly_stats);


-- ============================================
-- FITUR 5: Jumlah customer yang sedang login dan logout
-- ============================================
-- 5a. Summary login status
SELECT 
    COUNT(CASE WHEN is_logged_in = TRUE THEN 1 END) AS customer_sedang_login,
    COUNT(CASE WHEN is_logged_in = FALSE THEN 1 END) AS customer_sudah_logout,
    COUNT(*) AS total_log_entries
FROM user_log
WHERE user_type = 'customer';

-- 5b. Detail customer yang sedang login
SELECT 
    c.customer_id,
    c.nama_lengkap,
    c.email,
    ul.login_time AS waktu_login,
    'ONLINE' AS status
FROM user_log ul
JOIN customer c ON ul. user_id = c. customer_id
WHERE ul.user_type = 'customer' AND ul.is_logged_in = TRUE
ORDER BY ul.login_time DESC;

-- 5c. Detail customer yang sudah logout
SELECT 
    c. customer_id,
    c.nama_lengkap,
    c.email,
    ul.login_time AS waktu_login,
    ul.logout_time AS waktu_logout,
    'OFFLINE' AS status
FROM user_log ul
JOIN customer c ON ul.user_id = c.customer_id
WHERE ul.user_type = 'customer' AND ul. is_logged_in = FALSE
ORDER BY ul.logout_time DESC;

-- 5d.  Status driver (bonus)
SELECT 
    'Driver' AS tipe_user,
    COUNT(CASE WHEN is_logged_in = TRUE THEN 1 END) AS sedang_login,
    COUNT(CASE WHEN is_logged_in = FALSE THEN 1 END) AS sudah_logout
FROM user_log
WHERE user_type = 'driver'
UNION ALL
SELECT 
    'Customer' AS tipe_user,
    COUNT(CASE WHEN is_logged_in = TRUE THEN 1 END) AS sedang_login,
    COUNT(CASE WHEN is_logged_in = FALSE THEN 1 END) AS sudah_logout
FROM user_log
WHERE user_type = 'customer';


-- ============================================
-- FITUR 6: Driver paling rajin (paling banyak order selesai) setiap bulan
-- ============================================
WITH driver_order_monthly AS (
    SELECT 
        TO_CHAR(o. waktu_order, 'YYYY-MM') AS bulan,
        TO_CHAR(o. waktu_order, 'Month YYYY') AS nama_bulan,
        d.driver_id,
        d.nama_lengkap,
        d.no_plat_kendaraan,
        COUNT(*) AS jumlah_order_selesai,
        SUM(o.total_biaya) AS total_pendapatan,
        AVG(od.rating) AS rata_rata_rating,
        RANK() OVER (PARTITION BY TO_CHAR(o. waktu_order, 'YYYY-MM') ORDER BY COUNT(*) DESC) AS ranking
    FROM orders o
    JOIN driver d ON o.driver_id = d. driver_id
    LEFT JOIN order_detail od ON o.order_id = od. order_id
    WHERE o.status = 'completed'
    GROUP BY TO_CHAR(o.waktu_order, 'YYYY-MM'), TO_CHAR(o.waktu_order, 'Month YYYY'), 
             d.driver_id, d. nama_lengkap, d.no_plat_kendaraan
)
SELECT 
    bulan,
    nama_bulan,
    nama_lengkap AS driver_terajin,
    no_plat_kendaraan,
    jumlah_order_selesai,
    total_pendapatan,
    ROUND(rata_rata_rating, 2) AS avg_rating
FROM driver_order_monthly
WHERE ranking = 1
ORDER BY bulan DESC;

-- 6b. Top 5 Driver paling rajin (all time)
SELECT 
    d.driver_id,
    d.nama_lengkap,
    d.no_plat_kendaraan,
    d.jenis_kendaraan,
    COUNT(*) AS total_order_selesai,
    SUM(o.total_biaya) AS total_pendapatan,
    ROUND(AVG(od.rating), 2) AS rata_rata_rating
FROM orders o
JOIN driver d ON o. driver_id = d.driver_id
LEFT JOIN order_detail od ON o.order_id = od. order_id
WHERE o.status = 'completed'
GROUP BY d.driver_id, d.nama_lengkap, d.no_plat_kendaraan, d.jenis_kendaraan
ORDER BY total_order_selesai DESC
LIMIT 5;
