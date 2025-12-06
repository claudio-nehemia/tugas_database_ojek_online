-- ============================================
-- DATABASE APLIKASI OJEK ONLINE
-- Lumoshive Tech
-- ============================================

-- Drop tables if exists (untuk fresh install)
DROP TABLE IF EXISTS order_detail CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS user_log CASCADE;
DROP TABLE IF EXISTS lokasi CASCADE;
DROP TABLE IF EXISTS driver CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS admin CASCADE;

-- ============================================
-- 1. TABEL ADMIN
-- ============================================
CREATE TABLE admin (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. TABEL CUSTOMER
-- ============================================
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- ============================================
-- 3. TABEL DRIVER
-- ============================================
CREATE TABLE driver (
    driver_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    no_plat_kendaraan VARCHAR(15) NOT NULL,
    jenis_kendaraan VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_available BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE
);

-- ============================================
-- 4. TABEL LOKASI
-- ============================================
CREATE TABLE lokasi (
    lokasi_id SERIAL PRIMARY KEY,
    nama_lokasi VARCHAR(100) NOT NULL,
    daerah VARCHAR(100) NOT NULL,
    kota VARCHAR(100) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8)
);

-- ============================================
-- 5. TABEL ORDERS
-- ============================================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    driver_id INT,
    lokasi_penjemputan_id INT NOT NULL,
    lokasi_tujuan_id INT NOT NULL,
    waktu_order TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_selesai TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'on_the_way', 'completed', 'cancelled')),
    total_biaya DECIMAL(12, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id),
    FOREIGN KEY (lokasi_penjemputan_id) REFERENCES lokasi(lokasi_id),
    FOREIGN KEY (lokasi_tujuan_id) REFERENCES lokasi(lokasi_id)
);

-- ============================================
-- 6. TABEL ORDER_DETAIL
-- ============================================
CREATE TABLE order_detail (
    detail_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    jarak_km DECIMAL(5, 2),
    durasi_menit INT,
    catatan TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ============================================
-- 7. TABEL USER_LOG (untuk tracking login/logout)
-- ============================================
CREATE TABLE user_log (
    log_id SERIAL PRIMARY KEY,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('admin', 'customer', 'driver')),
    user_id INT NOT NULL,
    action VARCHAR(20) NOT NULL CHECK (action IN ('login', 'logout')),
    login_time TIMESTAMP,
    logout_time TIMESTAMP,
    is_logged_in BOOLEAN DEFAULT FALSE
);

-- ============================================
-- INDEXES untuk optimasi query
-- ============================================
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_driver ON orders(driver_id);
CREATE INDEX idx_orders_waktu ON orders(waktu_order);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_lokasi_daerah ON lokasi(daerah);
CREATE INDEX idx_user_log_type ON user_log(user_type, user_id);
