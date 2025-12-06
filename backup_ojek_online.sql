--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    admin_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    nama_lengkap character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_admin_id_seq OWNER TO postgres;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_admin_id_seq OWNED BY public.admin.admin_id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    nama_lengkap character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    no_telepon character varying(15) NOT NULL,
    alamat text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_customer_id_seq OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver (
    driver_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    nama_lengkap character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    no_telepon character varying(15) NOT NULL,
    no_plat_kendaraan character varying(15) NOT NULL,
    jenis_kendaraan character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_available boolean DEFAULT true,
    is_active boolean DEFAULT true
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- Name: driver_driver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_driver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.driver_driver_id_seq OWNER TO postgres;

--
-- Name: driver_driver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.driver_driver_id_seq OWNED BY public.driver.driver_id;


--
-- Name: lokasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lokasi (
    lokasi_id integer NOT NULL,
    nama_lokasi character varying(100) NOT NULL,
    daerah character varying(100) NOT NULL,
    kota character varying(100) NOT NULL,
    latitude numeric(10,8),
    longitude numeric(11,8)
);


ALTER TABLE public.lokasi OWNER TO postgres;

--
-- Name: lokasi_lokasi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lokasi_lokasi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lokasi_lokasi_id_seq OWNER TO postgres;

--
-- Name: lokasi_lokasi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lokasi_lokasi_id_seq OWNED BY public.lokasi.lokasi_id;


--
-- Name: order_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_detail (
    detail_id integer NOT NULL,
    order_id integer NOT NULL,
    jarak_km numeric(5,2),
    durasi_menit integer,
    catatan text,
    rating integer,
    review text,
    CONSTRAINT order_detail_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.order_detail OWNER TO postgres;

--
-- Name: order_detail_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_detail_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_detail_detail_id_seq OWNER TO postgres;

--
-- Name: order_detail_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_detail_detail_id_seq OWNED BY public.order_detail.detail_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    driver_id integer,
    lokasi_penjemputan_id integer NOT NULL,
    lokasi_tujuan_id integer NOT NULL,
    waktu_order timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    waktu_selesai timestamp without time zone,
    status character varying(20) DEFAULT 'pending'::character varying,
    total_biaya numeric(12,2),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'on_the_way'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: user_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_log (
    log_id integer NOT NULL,
    user_type character varying(20) NOT NULL,
    user_id integer NOT NULL,
    action character varying(20) NOT NULL,
    login_time timestamp without time zone,
    logout_time timestamp without time zone,
    is_logged_in boolean DEFAULT false,
    CONSTRAINT user_log_action_check CHECK (((action)::text = ANY ((ARRAY['login'::character varying, 'logout'::character varying])::text[]))),
    CONSTRAINT user_log_user_type_check CHECK (((user_type)::text = ANY ((ARRAY['admin'::character varying, 'customer'::character varying, 'driver'::character varying])::text[])))
);


ALTER TABLE public.user_log OWNER TO postgres;

--
-- Name: user_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_log_log_id_seq OWNER TO postgres;

--
-- Name: user_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_log_log_id_seq OWNED BY public.user_log.log_id;


--
-- Name: admin admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN admin_id SET DEFAULT nextval('public.admin_admin_id_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- Name: driver driver_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver ALTER COLUMN driver_id SET DEFAULT nextval('public.driver_driver_id_seq'::regclass);


--
-- Name: lokasi lokasi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokasi ALTER COLUMN lokasi_id SET DEFAULT nextval('public.lokasi_lokasi_id_seq'::regclass);


--
-- Name: order_detail detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_detail ALTER COLUMN detail_id SET DEFAULT nextval('public.order_detail_detail_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: user_log log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_log ALTER COLUMN log_id SET DEFAULT nextval('public.user_log_log_id_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (admin_id, username, password, nama_lengkap, email, created_at) FROM stdin;
1	admin1	admin123	Super Admin	admin@lumoshive.com	2025-12-06 23:12:29.875917
2	admin2	admin456	Admin Operasional	operasional@lumoshive.com	2025-12-06 23:12:29.875917
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, username, password, nama_lengkap, email, no_telepon, alamat, created_at, is_active) FROM stdin;
1	budi_santoso	pass123	Budi Santoso	budi@email.com	081234567890	Jl. Sudirman No. 10, Jakarta	2025-12-06 23:12:49.982571	t
2	ani_wijaya	pass123	Ani Wijaya	ani@email.com	081234567891	Jl. Thamrin No. 20, Jakarta	2025-12-06 23:12:49.982571	t
3	citra_dewi	pass123	Citra Dewi	citra@email.com	081234567892	Jl. Gatot Subroto No. 30, Jakarta	2025-12-06 23:12:49.982571	t
4	doni_pratama	pass123	Doni Pratama	doni@email.com	081234567893	Jl. Kuningan No. 40, Jakarta	2025-12-06 23:12:49.982571	t
5	eka_putri	pass123	Eka Putri	eka@email.com	081234567894	Jl. Senayan No. 50, Jakarta	2025-12-06 23:12:49.982571	t
6	fajar_hidayat	pass123	Fajar Hidayat	fajar@email.com	081234567895	Jl. Kemang No. 60, Jakarta	2025-12-06 23:12:49.982571	t
7	gita_sari	pass123	Gita Sari	gita@email.com	081234567896	Jl. Pondok Indah No. 70, Jakarta	2025-12-06 23:12:49.982571	t
8	hendra_gun	pass123	Hendra Gunawan	hendra@email.com	081234567897	Jl. BSD No. 80, Tangerang	2025-12-06 23:12:49.982571	t
9	indah_permata	pass123	Indah Permata	indah@email.com	081234567898	Jl. Bekasi No. 90, Bekasi	2025-12-06 23:12:49.982571	t
10	joko_widodo	pass123	Joko Susilo	joko@email.com	081234567899	Jl. Depok No. 100, Depok	2025-12-06 23:12:49.982571	t
\.


--
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.driver (driver_id, username, password, nama_lengkap, email, no_telepon, no_plat_kendaraan, jenis_kendaraan, created_at, is_available, is_active) FROM stdin;
1	driver_andi	driver123	Andi Setiawan	andi.driver@email.com	082345678901	B 1234 ABC	Honda Vario 150	2025-12-06 23:13:00.70191	t	t
2	driver_bambang	driver123	Bambang Sudrajat	bambang.driver@email.com	082345678902	B 2345 DEF	Yamaha NMAX	2025-12-06 23:13:00.70191	t	t
3	driver_cahyo	driver123	Cahyo Nugroho	cahyo.driver@email.com	082345678903	B 3456 GHI	Honda PCX	2025-12-06 23:13:00.70191	t	t
4	driver_dedi	driver123	Dedi Kurniawan	dedi.driver@email.com	082345678904	B 4567 JKL	Yamaha Aerox	2025-12-06 23:13:00.70191	t	t
5	driver_eko	driver123	Eko Prasetyo	eko.driver@email.com	082345678905	B 5678 MNO	Honda Beat	2025-12-06 23:13:00.70191	t	t
6	driver_feri	driver123	Feri Irawan	feri.driver@email.com	082345678906	B 6789 PQR	Yamaha Mio	2025-12-06 23:13:00.70191	t	t
7	driver_guntur	driver123	Guntur Wibowo	guntur.driver@email.com	082345678907	B 7890 STU	Honda Scoopy	2025-12-06 23:13:00.70191	t	t
8	driver_hasan	driver123	Hasan Abdullah	hasan.driver@email.com	082345678908	B 8901 VWX	Suzuki NEX	2025-12-06 23:13:00.70191	t	t
\.


--
-- Data for Name: lokasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lokasi (lokasi_id, nama_lokasi, daerah, kota, latitude, longitude) FROM stdin;
1	Stasiun Sudirman	Sudirman	Jakarta Pusat	-6.20239400	106.82355500
2	Mall Grand Indonesia	Thamrin	Jakarta Pusat	-6.19523900	106.82181700
3	Monas	Gambir	Jakarta Pusat	-6.17539200	106.82715300
4	Blok M Plaza	Blok M	Jakarta Selatan	-6.24385600	106.79863100
5	Pondok Indah Mall	Pondok Indah	Jakarta Selatan	-6.26584700	106.78438200
6	Kemang Village	Kemang	Jakarta Selatan	-6.26014300	106.81382800
7	Senayan City	Senayan	Jakarta Selatan	-6.22709300	106.79723400
8	Mall Kelapa Gading	Kelapa Gading	Jakarta Utara	-6.15847600	106.90827200
9	Ancol Beach	Ancol	Jakarta Utara	-6.12583300	106.84194400
10	Kota Tua	Taman Sari	Jakarta Barat	-6.13521800	106.81330100
11	Central Park Mall	Tanjung Duren	Jakarta Barat	-6.17685000	106.79014000
12	Mall Bekasi	Bekasi Selatan	Bekasi	-6.24876400	107.00515200
13	Summarecon Bekasi	Bekasi Utara	Bekasi	-6.22549800	107.00016800
14	Depok Town Square	Margonda	Depok	-6.38701200	106.83221700
15	Mall Taman Anggrek	Grogol	Jakarta Barat	-6.17882500	106.79269400
\.


--
-- Data for Name: order_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_detail (detail_id, order_id, jarak_km, durasi_menit, catatan, rating, review) FROM stdin;
1	1	3.50	30	Perjalanan lancar	5	Driver ramah dan tepat waktu
2	2	2.80	30	\N	4	Baik
3	3	5.20	40	Macet di jalan	4	Cukup baik
4	4	4.00	30	\N	5	Excellent!
5	5	3.20	25	\N	5	Very good
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, driver_id, lokasi_penjemputan_id, lokasi_tujuan_id, waktu_order, waktu_selesai, status, total_biaya) FROM stdin;
1	1	1	1	2	2025-11-01 08:30:00	2025-11-01 09:00:00	completed	25000.00
2	1	2	2	3	2025-11-02 09:15:00	2025-11-02 09:45:00	completed	20000.00
3	2	1	3	4	2025-11-03 10:00:00	2025-11-03 10:40:00	completed	35000.00
4	3	3	4	5	2025-11-04 12:30:00	2025-11-04 13:00:00	completed	28000.00
5	1	4	5	6	2025-11-05 14:00:00	2025-11-05 14:25:00	completed	22000.00
\.


--
-- Data for Name: user_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_log (log_id, user_type, user_id, action, login_time, logout_time, is_logged_in) FROM stdin;
1	customer	1	login	2025-12-06 07:00:00	\N	t
2	customer	2	login	2025-12-06 07:30:00	\N	t
3	customer	3	login	2025-12-06 08:00:00	\N	t
4	driver	1	login	2025-12-06 06:00:00	\N	t
5	driver	2	login	2025-12-06 06:30:00	\N	t
\.


--
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_admin_id_seq', 2, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 10, true);


--
-- Name: driver_driver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.driver_driver_id_seq', 8, true);


--
-- Name: lokasi_lokasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lokasi_lokasi_id_seq', 15, true);


--
-- Name: order_detail_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_detail_detail_id_seq', 5, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 5, true);


--
-- Name: user_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_log_log_id_seq', 5, true);


--
-- Name: admin admin_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_email_key UNIQUE (email);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- Name: admin admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);


--
-- Name: customer customer_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_email_key UNIQUE (email);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: customer customer_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_username_key UNIQUE (username);


--
-- Name: driver driver_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_email_key UNIQUE (email);


--
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- Name: driver driver_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_username_key UNIQUE (username);


--
-- Name: lokasi lokasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokasi
    ADD CONSTRAINT lokasi_pkey PRIMARY KEY (lokasi_id);


--
-- Name: order_detail order_detail_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_detail
    ADD CONSTRAINT order_detail_order_id_key UNIQUE (order_id);


--
-- Name: order_detail order_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_detail
    ADD CONSTRAINT order_detail_pkey PRIMARY KEY (detail_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: user_log user_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_log
    ADD CONSTRAINT user_log_pkey PRIMARY KEY (log_id);


--
-- Name: idx_lokasi_daerah; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lokasi_daerah ON public.lokasi USING btree (daerah);


--
-- Name: idx_orders_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_customer ON public.orders USING btree (customer_id);


--
-- Name: idx_orders_driver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_driver ON public.orders USING btree (driver_id);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- Name: idx_orders_waktu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_waktu ON public.orders USING btree (waktu_order);


--
-- Name: idx_user_log_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_log_type ON public.user_log USING btree (user_type, user_id);


--
-- Name: order_detail order_detail_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_detail
    ADD CONSTRAINT order_detail_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: orders orders_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- Name: orders orders_lokasi_penjemputan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_lokasi_penjemputan_id_fkey FOREIGN KEY (lokasi_penjemputan_id) REFERENCES public.lokasi(lokasi_id);


--
-- Name: orders orders_lokasi_tujuan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_lokasi_tujuan_id_fkey FOREIGN KEY (lokasi_tujuan_id) REFERENCES public.lokasi(lokasi_id);


--
-- PostgreSQL database dump complete
--

