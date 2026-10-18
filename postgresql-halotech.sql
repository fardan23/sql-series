-- Database
CREATE DATABASE "halotech-db";

DROP DATABASE "halotech-db2";

-- Schema Database
CREATE SCHEMA halotech;

DROP SCHEMA halotech2;

-- Create Table
-- mahasiswa (default: schemas -> public)
CREATE TABLE mahasiswa (
	nim INTEGER PRIMARY KEY,
	nama_depan VARCHAR(50),
	nama_belakang VARCHAR(50),
	kota_asal TEXT,
	jurusan TEXT
); 
-- mahasiswa (custom: schemas -> halotech)
CREATE TABLE halotech.mahasiswa (
	nim INTEGER PRIMARY KEY,
	nama_depan VARCHAR(50),
	nama_belakang VARCHAR(50),
	kota_asal TEXT,
	jurusan TEXT
);

-- ipk
CREATE TABLE halotech.ipk (
	nim INTEGER,
	semester VARCHAR(3),
	ipk FLOAT
);

-- Insert Data
INSERT INTO halotech.mahasiswa 
	VALUES (10500, 'Muhamad', 'Fardan', 'Depok', 'Teknik Informatika');

INSERT INTO halotech.mahasiswa (nim, nama_depan, nama_belakang, kota_asal, jurusan)
	VALUES (10501, 'Enami', 'Asa', 'Tokyo', 'Ongakuka');

INSERT INTO halotech.mahasiswa (nama_depan, kota_asal, nama_belakang, jurusan, nim)
	VALUES ('Jung', 'Chuncheon', 'Ahyeon', 'Seong-ak', 10502);

INSERT INTO halotech.mahasiswa (nim, nama_depan, kota_asal, jurusan)
	VALUES (10503, 'Nasywaa', 'Jakarta', 'Statistika');

INSERT INTO halotech.mahasiswa
	VALUES (10504, 'Lady', 'Bekasi', 'Pendidikan Dokter');

SELECT nim, nama_depan, nama_belakang, kota_asal, jurusan FROM halotech.mahasiswa;

SELECT * FROM halotech.mahasiswa;

SELECT nim FROM halotech.mahasiswa;

-- Homework Insert Data
SELECT * FROM halotech.ipk;

INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S1', 3.74);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S2', 3.95);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S3', 3.75);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S4', 3.82);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S5', 3.70);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S6', 3.90);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S7', 3.81);
INSERT INTO halotech.ipk (nim, semester, ipk)
	VALUES (10500, 'S8', 4.00);

INSERT INTO halotech.ipk (nim, semester, ipk)
VALUES 	(10501, 'S1', 3.62),
    	(10501, 'S2', 3.78),
    	(10501, 'S3', 3.71),
    	(10501, 'S4', 3.89),
    	(10501, 'S5', 3.67),
    	(10501, 'S6', 3.94),
    	(10501, 'S7', 3.83),
    	(10501, 'S8', 3.97),

    	(10502, 'S1', 3.55),
    	(10502, 'S2', 3.69),
    	(10502, 'S3', 3.76),
    	(10502, 'S4', 3.84),
    	(10502, 'S5', 3.73),
    	(10502, 'S6', 3.91),
    	(10502, 'S7', 3.86),
    	(10502, 'S8', 3.98),

    	(10503, 'S1', 3.81),
    	(10503, 'S2', 3.66),
    	(10503, 'S3', 3.93),
    	(10503, 'S4', 3.74),
    	(10503, 'S5', 3.87),
    	(10503, 'S6', 3.95),
    	(10503, 'S7', 3.79),
    	(10503, 'S8', 3.99),

    	(10504, 'S1', 3.48),
    	(10504, 'S2', 3.57),
    	(10504, 'S3', 3.68),
    	(10504, 'S4', 3.77),
    	(10504, 'S5', 3.64),
    	(10504, 'S6', 3.82),
    	(10504, 'S7', 3.88),
    	(10504, 'S8', 3.92);

SELECT * FROM halotech.ipk;

-- Update Table
SELECT * FROM halotech.mahasiswa;

-- menambah kolom
ALTER TABLE halotech.mahasiswa
	ADD COLUMN fakultas TEXT;

-- mengubah nama kolom
ALTER TABLE halotech.mahasiswa 
	RENAME COLUMN jurusan TO prodi;

-- mengubah tipe data kolom
ALTER TABLE halotech.mahasiswa
	ALTER COLUMN kota_asal SET DATA TYPE VARCHAR(20);

-- membuang kolom
ALTER TABLE halotech.mahasiswa
	DROP COLUMN IF EXISTS fakultas;

-- mengubah nilai untuk satu kolom
UPDATE halotech.mahasiswa 
	SET nama_belakang = NULL WHERE nim = 10504;

-- mengubah nilai untuk lebih dari satu kolom
UPDATE halotech.mahasiswa 
	SET kota_asal = 'Bekasi', prodi = 'Pendidikan Dokter' WHERE nim = 10504;

-- select data -> DQL: Data Query Language
SELECT * FROM halotech.mahasiswa;

SELECT nim, nama_depan, nama_belakang, kota_asal, prodi FROM halotech.mahasiswa;

/* 
	condition, keyword: WHERE
	=, !=, >, <, >=, <=
*/

/* string = kode ASCII: 
	A -> 65, B -> 66, C -> 67 hingga z = 90
    a -> 97, b -> 98, c -> 99 hingga z = 122
*/

SELECT * FROM halotech.mahasiswa WHERE kota_asal = 'Jakarta';

SELECT * FROM halotech.mahasiswa WHERE kota_asal != 'Jakarta';

SELECT * FROM halotech.mahasiswa WHERE nim > 10500;

SELECT * FROM halotech.mahasiswa WHERE nim < 10500;

SELECT * FROM halotech.mahasiswa WHERE nim >= 10500;

SELECT * FROM halotech.mahasiswa WHERE nim <= 10500;

SELECT * FROM halotech.mahasiswa WHERE kota_asal > 'Bandung';

SELECT * FROM halotech.mahasiswa WHERE kota_asal < 'Bandung';

SELECT * FROM halotech.mahasiswa WHERE kota_asal >= 'Bandung';

SELECT * FROM halotech.mahasiswa WHERE kota_asal <= 'Bandung';

SELECT * FROM halotech.mahasiswa WHERE nama_belakang > NULL; -- ?

-- delete data
CREATE TABLE halotech.tablea (
	user_id INTEGER PRIMARY KEY,
	kota TEXT,
	jabatan TEXT
);

INSERT INTO halotech.tablea 
	VALUES (1, 'Jakarta', 'Data Engineer'),
	(2, 'Bandung', 'Data Analyst'),
	(3, 'Yogyakarta', 'Data Scientist'),
	(4, 'Bogor', 'Product Manager'),
	(5, 'Jakarta', 'Payment Analyst');

SELECT * FROM halotech.tablea;

DELETE FROM halotech.tablea
	WHERE user_id = 4;

DELETE FROM halotech.tablea
	WHERE kota = 'Jakarta';

DELETE FROM halotech.tablea;

-- truncate table
SELECT * FROM halotech.tablea;

TRUNCATE halotech.tablea;

-- drop table
INSERT INTO halotech.tablea 
	VALUES (1, 'Jakarta', 'Data Engineer');

SELECT * FROM halotech.tablea;

DROP TABLE halotech.tablea;

-- distinct and limit data
SELECT * FROM halotech.ipk;

SELECT DISTINCT * FROM halotech.ipk;

SELECT semester FROM halotech.ipk;

SELECT DISTINCT semester FROM halotech.ipk;

SELECT DISTINCT semester FROM halotech.ipk LIMIT 3;

SELECT DISTINCT semester FROM halotech.ipk ORDER BY semester LIMIT 3;

-- operator not, and, or
SELECT NOT (2 = 2)

SELECT NOT (3 != 3)

SELECT * FROM halotech.mahasiswa;

SELECT * FROM halotech.mahasiswa WHERE nim = 10500;

SELECT * FROM halotech.mahasiswa WHERE NOT nim = 10500;

SELECT (2 = 2) AND (3 = 3);

SELECT (2 = 2) AND (3 != 3);

SELECT (2 = 2) OR (3 != 3);

SELECT * FROM halotech.mahasiswa WHERE (kota_asal = 'Jakarta') AND (prodi = 'Statistika');

SELECT * FROM halotech.mahasiswa WHERE (kota_asal = 'Jakarta') OR (prodi = 'Pendidikan Dokter');

-- operator in, between, like
SELECT 1 IN (1, 2, 3);

SELECT * FROM halotech.mahasiswa;

SELECT * FROM halotech.mahasiswa WHERE kota_asal IN ('Jakarta', 'Bekasi', 'Bogor');

SELECT * FROM halotech.mahasiswa WHERE nim IN (10501, 10502, 10503);

SELECT 7 BETWEEN 1 AND 10;

SELECT 19 BETWEEN 1 AND 10;

SELECT * FROM halotech.mahasiswa WHERE kota_asal BETWEEN 'Jakarta' AND 'Bogor';

SELECT 'jakarta' LIKE 'jakarta';

SELECT 'jakarta selatan' LIKE 'jakarta';

SELECT 'jakarta selatan' LIKE '%jakarta'; -- akhir

SELECT 'jakarta selatan' LIKE 'jakarta%'; -- depan

SELECT 'jakarta selatan' LIKE '%jakarta%'; -- keseluruhan

SELECT 'kakiku kaku gara-gara kakakku' LIKE '%ka';

SELECT 'kakiku kaku gara-gara kakakku' LIKE 'ka%';

SELECT 'kakiku kaku gara-gara kakakku' LIKE '%ka%';

SELECT * FROM halotech.mahasiswa;

SELECT * FROM halotech.mahasiswa WHERE prodi LIKE 'Teknik%';

-- is null dan not null
SELECT * FROM halotech.mahasiswa WHERE nama_belakang > NULL; -- ?

SELECT * FROM halotech.mahasiswa WHERE nama_belakang IS NULL;

SELECT * FROM halotech.mahasiswa WHERE nama_belakang IS NOT NULL;

-- order by = mengurutkan data (default: ASC)
SELECT * FROM halotech.mahasiswa;

SELECT * FROM halotech.mahasiswa ORDER BY nim DESC;

SELECT * FROM halotech.mahasiswa ORDER BY nim ASC;

SELECT * FROM halotech.mahasiswa ORDER BY nim;

SELECT * FROM halotech.ipk;

SELECT * FROM halotech.ipk ORDER BY ipk DESC;

SELECT * FROM halotech.ipk ORDER BY ipk ASC;

SELECT * FROM halotech.ipk ORDER BY ipk;

-- aggregate function: count, max, min
SELECT * FROM halotech.mahasiswa;

SELECT COUNT(*) FROM halotech.mahasiswa;

SELECT COUNT(nim) FROM halotech.mahasiswa;

SELECT COUNT(nama_belakang) FROM halotech.mahasiswa;

SELECT COUNT(kota_asal) FROM halotech.mahasiswa;

SELECT COUNT(DISTINCT kota_asal) FROM halotech.mahasiswa;

SELECT * FROM halotech.ipk;

SELECT * FROM halotech.ipk ORDER BY ipk DESC;

SELECT MAX(ipk) FROM halotech.ipk;

SELECT MIN(ipk) FROM halotech.ipk;

SELECT * FROM halotech.mahasiswa;

-- ASCII Table
SELECT MAX(prodi) FROM halotech.mahasiswa;

SELECT MIN(prodi) FROM halotech.mahasiswa;

-- aggregate function: average, median, modus
SELECT AVG(ipk) FROM halotech.ipk;

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY ipk) FROM halotech.ipk;

SELECT MOD(10, 2);

SELECT MOD(10, 3);

SELECT MOD(nim, 2) FROM halotech.ipk;

-- group by
SELECT * FROM halotech.mahasiswa;

SELECT COUNT(*) FROM halotech.mahasiswa;

SELECT COUNT(kota_asal) FROM halotech.mahasiswa WHERE kota_asal = 'Jakarta';

SELECT kota_asal, COUNT(*) jumlah_kemunculan FROM halotech.mahasiswa GROUP BY kota_asal;

SELECT nim, kota_asal, COUNT(*) FROM halotech.mahasiswa GROUP BY nim, kota_asal;

SELECT nim, kota_asal, COUNT(*), MAX(nim), MIN(nim) FROM halotech.mahasiswa GROUP BY nim, kota_asal;

SELECT semester, COUNT(*), MAX(ipk), MIN(ipk) FROM halotech.ipk GROUP BY semester;

-- having pada group by
SELECT * FROM halotech.ipk;

SELECT 
	semester, 
	AVG(ipk) rerata_ipk
FROM halotech.ipk
GROUP BY semester;

SELECT 
	semester, 
	AVG(ipk) rerata_ipk
FROM halotech.ipk
WHERE semester = 'S1'
GROUP BY semester;

SELECT 
	semester, 
	AVG(ipk) rerata_ipk
FROM halotech.ipk
GROUP BY semester
HAVING semester = 'S1';

SELECT 
	semester, 
	AVG(ipk) rerata_ipk
FROM halotech.ipk
GROUP BY semester
HAVING AVG(ipk) > 3.8;

-- join table
CREATE TABLE halotech.tableA (
	user_id INTEGER PRIMARY KEY,
	kota TEXT,
	jabatan TEXT
);

CREATE TABLE halotech.tableB (
	user_id INTEGER PRIMARY KEY,
	gaji INTEGER,
	hewan_peliharaan TEXT
);

INSERT INTO halotech.tableA(user_id, kota, jabatan) 
	VALUES (1, 'Jakarta', 'Data Engineer'),
	(2, 'Bandung', 'Data Analyst'),
	(6, 'Yogyakarta', 'Data Scientist'),
	(7, 'Bogor', 'Product Manager'),
	(8, 'Jakarta', 'Payment Analyst');

INSERT INTO halotech.tableB(user_id, gaji, hewan_peliharaan) 
	VALUES (1, 1000, 'Kucing'),
	(2, 1500, 'Angsa'),
	(3, 7500, 'Bebek'),
	(4, 10000, 'Ayam'),
	(5, 800, 'Kelinci');

SELECT
	A.user_id,
	A.kota,
	A.jabatan,
	B.gaji,
	B.hewan_peliharaan
FROM halotech.tableA A LEFT JOIN halotech.tableB B ON A.user_id = B.user_id;

SELECT
	A.user_id,
	A.kota,
	A.jabatan,
	B.gaji,
	B.hewan_peliharaan
FROM halotech.tableA A RIGHT JOIN halotech.tableB B ON A.user_id = B.user_id;

SELECT
	A.user_id,
	A.kota,
	A.jabatan,
	B.gaji,
	B.hewan_peliharaan
FROM halotech.tableA A INNER JOIN halotech.tableB B ON A.user_id = B.user_id;

SELECT
	A.user_id,
	A.kota,
	A.jabatan,
	B.gaji,
	B.hewan_peliharaan,
	"C".kota kota_c,
	"C".jabatan jabatan_c
FROM halotech.tableA A 
	LEFT JOIN halotech.tableB B ON A.user_id = B.user_id
	LEFT JOIN halotech.tableA "C" ON A.user_id = "C".user_id;
