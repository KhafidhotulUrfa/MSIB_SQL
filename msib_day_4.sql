SELECT * FROM invoices;
SELECT DISTINCT * FROM ap.terms;
SELECT * FROM vendors;

DESCRIBE ap.invoices;

-- Memasukan satu baris data sesuai urutan kolom
INSERT INTO ap.invoices VALUES(
	116, 97, '999890', '2014-07-05', 250.6, 0, 0, 2, '2014-08-05', '2014-08-04');

-- Memasukan satu baris data sesuai urutan kolom yang didefinisikan
INSERT INTO ap.invoices (
	vendor_id, invoice_number, invoice_total, terms_id, invoice_date, invoice_due_date)
VALUES (96, '999678', 8654.90, 3, '2014-08-01', '2014-09-01');

-- Menggunakan subquery untuk memasukkan satu baris data atau lebih
-- INSERT INTO table_name ([column_list])
-- Menyalin data dari tabel invoice ke invoice_archive untuk tagihan yang sudah lunas.
INSERT INTO invoice_archive
(SELECT * FROM invoices
WHERE invoice_total - payment_total - credit_total = 0);

SELECT * FROM invoice_archive;
-- Menghapus data namun tidak menghapus schema table
TRUNCATE invoice_archive;

-- Menghapus baris data di tabel invoice.
DELETE FROM ap.invoices WHERE vendor_id = 88;

-- Update baris data terhadap 2 kolom 
UPDATE invoices SET payment_date = '2014-09-21', payment_total = 85.31 
WHERE invoice_number = '39104';

-- Update baris data menggunakan operasi antar kolom
UPDATE invoices SET credit_total = credit_total + 100
WHERE invoice_number = '97/522';
SELECT * FROM invoices WHERE invoice_number = '97/522';

-- Update baris data menggunakan subquery (mencari data dari table lain)
UPDATE invoices SET terms_id = 1
WHERE vendor_id IN (
	SELECT vendor_id
    FROM vendors
    WHERE vendor_name = 'Pacific Bell'
    );
    
-- Konversi Tipe Data Implisit
-- Number ke String
SELECT 
	invoice_total,
    CONCAT('$' , invoice_total) AS Total_USD
FROM invoices;

-- String ke Number
SELECT 
	invoice_number,
    88894/invoice_number
FROM invoices;

-- Date ke Number
SELECT
	invoice_date,
    invoice_date + 1
FROM invoices;

-- Konversi Tipe Data Eksplisit
-- CAST() Function
SELECT invoice_id, invoice_date, invoice_total,
	CAST(invoice_date AS CHAR(10)) AS char_date,
    CAST(invoice_total AS SIGNED) AS integer_total
FROM invoices;

-- CONVERT() Function
SELECT invoice_id, invoice_date, invoice_total,
	CONVERT(invoice_date, CHAR(10)) AS char_date,
    CONVERT(invoice_total, SIGNED) AS integer_total
FROM invoices;



