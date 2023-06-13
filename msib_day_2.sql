-- Menampilkan data seluruh kolom
SELECT * FROM belajar.orderdetails;

-- Menampilkan kolom tertentu
SELECT productCode, quantityOrdered, priceEach FROM belajar.orderdetails;

-- Melakukan filtering (kolom karakter)
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
WHERE productCode = "S18_1749";

-- Melakukan filtering berdasarkan keyword
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
WHERE productCode LIKE "S700_%";

-- Melakukan filtering kolom numeric
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
WHERE quantityOrdered > 40;

-- Melakukan filtering lebih dari satu kondisi
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
WHERE quantityOrdered > 40 AND productCode LIKE "S700_%";

-- Melakukan sorting (ASC Menaik, DESC Menurun)
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
ORDER BY quantityOrdered DESC;

-- Menampilkan data dengan jumlah tertentu
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
LIMIT 10;

-- Menampilkan data dengan rentang dari 10 ke 15
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach 
FROM belajar.orderdetails
LIMIT 5
OFFSET 10;

-- Melakukan operasi antar kolom
SELECT 
	productCode, 
    quantityOrdered, 
    priceEach,
    (quantityOrdered * priceEach)
FROM belajar.orderdetails;

-- Membuat alias pada kolom
SELECT 
	productCode AS "Produk Code", 
    quantityOrdered AS Jumlah, 
    priceEach AS "Harga Satuan",
    (quantityOrdered * priceEach) AS Total
FROM belajar.orderdetails;

-- Melakukan filtering kolom operasi
SELECT 
	productCode AS "Produk Code", 
    quantityOrdered AS Jumlah, 
    priceEach AS "Harga Satuan",
    (quantityOrdered * priceEach) AS Total
FROM belajar.orderdetails
HAVING Total > 4000;

-- Menampilkan data unik
SELECT DISTINCT
	productCode
FROM belajar.orderdetails
ORDER BY productCode ASC;

-- Melakukan operasi antar baris, fungsi aggregate
SELECT
	SUM(quantityOrdered) AS "Total Quantity",
    AVG(quantityOrdered) AS "Rata-Rata Quantity",
    MIN(quantityOrdered) AS "Quantity Terkecil",
    MAX(quantityOrdered) As "Quantity Terbesar",
    STDDEV(quantityOrdered) AS "Standar Deviasi",
    VARIANCE(quantityOrdered) AS "Variansi"
FROM belajar.orderdetails;

-- Melakukan grouping
SELECT 
	productCode AS "Produk Code", 
    SUM(quantityOrdered * priceEach) AS Total
FROM belajar.orderdetails
GROUP BY productCode;

-- Challenge: Tampilkan top 10 product dengan rata2 quantityOrdered terbesar
-- Answer By: Shintya Rahmawati
SELECT 
	productCode, 
    AVG(quantityOrdered)
FROM belajar.orderdetails
GROUP BY productCode
ORDER BY AVG(quantityOrdered) DESC
LIMIT 10;

-- Challenge
-- Tampilkan, customerName, contactFirstName, contactLastName, phone
-- Untuk 10 Cutomers dengan credit limit terbesar
-- hint: Pilih kolomnya, sorting kredit limit
-- Answer By: Wisnu Arya
SELECT
	customerName,
    contactFirstName,
    contactLastName,
    phone
FROM belajar.customers
ORDER BY creditLimit DESC
LIMIT 10;
-- Answer By: Firman Wahyudi
SELECT
	customerName,
    CONCAT(contactFirstName, " ", contactLastName),
    phone
FROM belajar.customers
ORDER BY creditLimit DESC
LIMIT 10;

-- Challenge, Tampilkan paymentDate pada bulan apa transaksi terbesar
-- Hint: Gunakan fungsi MONTH(paymentDate)
-- Hint: Lakukan SUM(amount)
-- Hint: Lakukan sorting
-- Optional, cari di google agar bulannya menggunakan nama bulan Ex: January, February dst
-- Answer By: Wisnu Arya
SELECT
	monthname(paymentDate),
    SUM(amount)
FROM belajar.payments
GROUP BY monthname(paymentDate)
ORDER BY SUM(amount) DESC;

-- Membuat view table
CREATE VIEW MSIB_WAREHOUSE.garda_summary_total_payment_amount_per_month AS 
	SELECT
		monthname(paymentDate),
		SUM(amount)
	FROM belajar.payments
	GROUP BY monthname(paymentDate)
	ORDER BY SUM(amount) DESC;
    
-- Menarik data pada view table
SELECT * FROM MSIB_WAREHOUSE.garda_summary_total_payment_amount_per_month;

