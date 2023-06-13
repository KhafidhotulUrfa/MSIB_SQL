-- Fungsi String
-- CONCAT
-- Menggabungkan dua atau lebih string menjadi satu string
help length;
SELECT CONCAT('   Hello, ' , '   World!   ') AS result_concat;

-- LENGTH
-- Menghitung jumlah karakter dalam sebuah string
SELECT LENGTH('Kampus Merdeka') AS result_length;

-- SUBSTRING
-- Mengambil bagian dari sebuah string (str, posisi_awal, jumlah_karakter)
help substring;
SELECT SUBSTRING('Kampus Merdeka', 3, 3) AS result_substring;

-- REPLACE
-- Menggantikan bagian string dengan teks lain
SELECT REPLACE ('SQL Functions', 'SQL', 'Built-in') AS result_replace;

-- UPPER/LOWER
-- Mengubah string menjadi huruf besar
SELECT UPPER('sql') AS result_upper;
-- Mengubah string menjadi huruf kecil
SELECT LOWER('SQL Functions') AS result_lower;

-- TRIM
-- Menghapus spasi di awal dan akhir string
SELECT TRIM('  Hello, World!   ') AS result_trim;
SELECT CONCAT(TRIM('    SQL '), ' Functions' );

-- LEFT/RIGHT
SELECT LEFT('Kampus Merdeka', 5) AS result_left;
SELECT RIGHT('Kampus Merdeka', 5) as result_right;

-- CHAR_LENGTH
-- Menghitung jumlah karakter (UNICODE)
SELECT CHAR_LENGTH('MSIB') AS result_char_length;

-- POSITION
-- Menemukan posisi pertama dari sebuah string dalam string lain
SELECT POSITION('Merdeka' IN 'Kampus Merdeka') AS result_position;

-- REVERSE
-- Membalik urutan karakter dalam sebuah string
SELECT REVERSE('Kampus Merdeka') AS result_reverse;

-- Menampilkan inisial customers
USE ex;
SELECT CONCAT(LEFT(customer_last_name, 1), LEFT(customer_first_name, 1)) AS Customer_Initials
FROM customers;

-- Fungsi Date
-- NOW
-- Mengembalikan tanggal dan waktu saat ini
SELECT NOW() AS current_datetime;

-- CURDATE
-- Mengembalikan tanggal saat ini
SELECT CURDATE() AS currentdate;

-- CURTIME
-- Mengembalikan waktu saat ini
SELECT CURTIME() AS currenttime;

-- DATE_ADD
-- Menambahkan interval waktu pada tanggal
SELECT DATE_ADD('2023-03-23', INTERVAL 7 DAY) AS result_date_add;
SELECT invoice_date ,DATE_ADD(invoice_date, INTERVAL 1 MONTH) AS result_date_add FROM ap.invoices;

-- DATE_SUB
-- Mengurangkan interval waktu dari tanggal
SELECT invoice_date , DATE_SUB(invoice_date, INTERVAL 1 YEAR) AS result_date_sub FROM ap.invoices;

-- DATEDIFF
-- Menghitung selisih antara dua tanggal dalam satuan hari
SELECT invoice_number ,DATEDIFF(invoice_date, invoice_due_date) AS Durasi_jatuh_tempo FROM ap.invoices;

-- DAYOFWEEK
-- Mengembalikan angka yang mewakili hari dalam seminggu (1 = Minggu, 2 = Senin, dst...)
SELECT DAYOFWEEK('2023-03-19') AS result_dayofweek;

-- MONTHNAME
-- Mengembalikan nama bulan berdasarkan tanggal
SELECT MONTHNAME(invoice_date) AS result_monthname FROM ap.invoices;

-- DATE_FORMAT
help date_format;
SELECT invoice_date, DATE_FORMAT(invoice_date, '%w, %M %Y') AS tanggal FROM ap.invoices;

-- Fungsi Numeric/Math
-- ABS
-- Mengembalikan nilai absolut dari angka
SELECT ABS(-9999.88) AS result_abs;

-- CEIL/CEILING
-- Pembulatan ke atas (ke integer terdekat)
SELECT CEIL(6.5) AS result_ceiling;

-- FLOOR
-- Pembulatan ke bawah (ke integer terdekat)
SELECT FLOOR(6.5) AS result_floor;

-- ROUND
-- Membulatkan angka ke integer terdekat
SELECT ROUND(7.5) AS result_round;

-- SQRT
-- Menghitung akar kuadrat dari sebuah angka
SELECT SQRT(25) AS result_square_root;

-- POWER (angka, pangkat)
-- Menghitung pangkat dari angka
SELECT POWER(8, 3) AS result_power;

-- MOD / REMAINDER
-- Menghitung sisa dari pembagian antara dua angka
SELECT MOD(8543576, 7) AS result_mod;

-- RAND
help rand;
-- Menghasilkan angka acak
SELECT invoice_number, (ROUND(RAND(8) * 10000)) AS payment_amount FROM ap.invoices;

help pi;

SELECT PI() * POWER(7, 2) AS luas_lingkaran;

-- Fungsi untuk menghitung luas lingkaran
USE ap;
DROP FUNCTION IF EXISTS `luas_lingkaran`;

DELIMITER $$
USE ap $$
CREATE FUNCTION `luas_lingkaran` (radius DOUBLE)
RETURNS DOUBLE
BEGIN
	RETURN PI() * POWER(radius, 2);
END $$
DELIMITER ;

-- Contoh penggunaan fungsi luas lingkaran
SELECT luas_lingkaran(14) AS Luas_Lingkaran;

-- Fungsi untuk mengubah huruf pertama menjadi huruf kapital (Capitalizing)
DROP FUNCTION IF EXISTS `Capitalize`;

DELIMITER $$
USE ap $$
CREATE FUNCTION `Capitalize` (str VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
	DECLARE result VARCHAR(255);
    SET result = CONCAT(UPPER(LEFT(str, 1)), LOWER(SUBSTRING(str, 2)));
    RETURN result;
END $$
DELIMITER ;

-- Contoh penggunaan fungsi Capitalize
SELECT Capitalize('kampus merdeka') AS result;





