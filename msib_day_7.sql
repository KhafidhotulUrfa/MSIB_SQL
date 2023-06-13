-- 1. Stored Procedure yang mengambil input dari user
USE belajar;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test(input VARCHAR (255))
BEGIN
	SELECT input AS Message;
END//
DELIMITER ;

-- Contoh pemanggilan stored procedure test()
CALL test('Hello_World!');

-- 2. Stored Procedure untuk menampilkan data dari tabel Products sesuai jumlah baris yang di input
USE belajar;
DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts(jumlah_baris INT)
BEGIN
	SELECT * FROM belajar.products
    LIMIT jumlah_baris;
END//
DELIMITER ;

-- Contoh pemanggilan stored procedure GetAllProducts()
CALL GetAllProducts(50);

-- Challenge: Buat stored procedure GetProductQuantity() untuk memanggil data Products yang jumlah kuantitas stoknya
-- sesuai dengan input dari parameter
-- hint: buat filter menggunakan perintah WHERE stok >= input
-- Answered by: Shintya Rahmawati & Sela Septiana
USE belajar;
DROP PROCEDURE IF EXISTS GetProductsQty;
DELIMITER //
CREATE PROCEDURE GetProductsQty(stock INT)
BEGIN
	SELECT productCode,
		   productName,
           quantityInStock
           FROM belajar.products
           WHERE quantityInStock > stock;
END //
DELIMITER ;

CALL GetProductsQty(10);

-- 3. Stored Procedure untuk menambahkan product baru
USE belajar;
DROP PROCEDURE IF EXISTS AddProducts;
DELIMITER //
CREATE PROCEDURE AddProducts(i_productName VARCHAR(70), i_productCode VARCHAR(15))
BEGIN
	INSERT INTO products(productName, productCode) VALUES (i_productName , i_productCode);
END //
DELIMITER ;

CALL AddProducts("Power_Rangers", "P_123");

-- Challenge:
-- Answered By: Zalfa Putri Nabilah
-- C1. Buatlah Stored Procedure untuk mengupdate nomor telpon customers berdasarkan customerNumber (103, 114, 119, 121)
CALL UpdateCustomers_ZPN("081924", 121);
SELECT phone FROM customers WHERE customerNumber = 121;
-- C2. Buatlah Stored Procedure untuk menghapus nama employee berdasarkan employeeNumber (1002, 1056, 1076, 1088)
SELECT * FROM employees;
CALL DeleteEmployees_ZPN(1286);
-- C3. Buatlah Stored Procedure untuk mencari nama product berdasarkan productName ('Ferrari') ; Hint: Gunakan perintah LIKE
CALL GetProduct_ZPN("Ferrari");

-- C1: Answered by: Ferdy Atmaja
USE belajar;
DROP PROCEDURE IF EXISTS UpdatePhone_FA;
DELIMITER //
CREATE PROCEDURE UpdatePhone_FA(i_customerNumber INT, i_phone VARCHAR(50))
BEGIN
	UPDATE customers
    SET phone = i_phone
    WHERE customerNumber = i_customerNumber;
END //
DELIMITER ;

CALL UpdatePhone_FA("103", "1111111");
SELECT phone FROM customers WHERE customerNumber = 103;

-- Study Case
USE ap;
-- Mencari invoice yang sudah jatuh tempo per tanggal hari ini
SELECT
	IF (MIN(invoice_due_date) < NOW(), 'Tagihan sudah jatuh tempo!', 'Tidak ada invoice yang jatuh tempo.' ) AS Message
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

-- Stored Procedure menggunakan IF Statement
USE ap;
DROP PROCEDURE IF EXISTS Message;

DELIMITER //

CREATE PROCEDURE message_js()
BEGIN
	DECLARE first_invoice_due_date DATE;
    
    SELECT MIN(invoice_due_date)
    INTO first_invoice_due_date
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0;

/**    
    IF first_invoice_due_date < NOW() THEN
		SELECT 'Invoice sudah lewat jauh dari jatuh tempo!' AS Message;
	ELSE IF first_invoice_due_date = NOW() THEN
		SELECT 'Invoice jatuh tempo hari ini!' AS Message;
	ELSE
		SELECT 'Belum ada Invoice yang jatuh tempo.' AS Message;
	END IF;
**/    
END//

DELIMITER ;

CALL messageN();

SELECT vendor_id, invoice_total FROM invoices
ORDER BY vendor_id;

-- Mencari Rasio Invoice untuk masing-masing vendor (37, 80, 95, 96, 110)
-- Mencari selisih antara nilai maksimum invoice_total dengan nilai minimum invoice_total dibagi dengan nilai minimum invoice_total
-- (21842 - 85.31) / 85.31 * 100
USE ap;

DROP PROCEDURE IF EXISTS invoice_ratio;

DELIMITER //

CREATE PROCEDURE invoice_ratio(vendor_id_var INT)
BEGIN
	-- Query untuk mendefinisikan variable
	DECLARE max_invoice_total DECIMAL(9,2);
    DECLARE min_invoice_total DECIMAL(9,2);
    DECLARE percent_difference DECIMAL(9,2);
    DECLARE count_invoice_id INT;
    
    -- Query untuk filtering data berdasarkan input parameter, kemudian memasukan data tsb ke dalam variable value
    SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
    INTO max_invoice_total, min_invoice_total, count_invoice_id
    FROM invoices WHERE vendor_id = vendor_id_var;
    
    -- Memasukan hasil kalkulasi ke variable menggunakan SET
    SET percent_difference = (max_invoice_total - min_invoice_total) / 
    min_invoice_total * 100;
    
    -- Mengembalikan nilai yang disimpan oleh variable
    SELECT 
		vendor_id_var AS 'ID Vendor',
		CONCAT('$',  max_invoice_total) AS 'Maximum Invoice',
		CONCAT('$',  min_invoice_total) AS 'Minimum Invoice' ,
        CONCAT(percent_difference, '%') AS 'Difference',
        count_invoice_id AS 'Number of Invoices';
END//

DELIMITER ;

CALL invoice_ratio_and_Credit_totalFISABIL(110);

SELECT * FROM invoices;