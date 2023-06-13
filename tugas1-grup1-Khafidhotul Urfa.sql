-- TUGAS 1 SQL
-- NAMA : KHAFIDHOTUL URFA
-- GRUP : 1

/** 
1. Buatlah syntax SELECT yang mengambil nilai dari tabel invoices
	untuk masing-masing vendor yang berisi kolom:
		- vendor_id dari tabel Vendors
        - SUM dari kolom invoice_total di tabel Invoices untuk vendor tsb.
**/
SELECT v.vendor_id, 
	SUM(i.invoice_total) AS total_invoice
	FROM ap.vendors  v
	JOIN ap.invoices  i
    ON v.vendor_id = i.vendor_id
GROUP BY v.vendor_id
ORDER BY v.vendor_id ASC;



/**
2. Carilah Vendor yang memiliki jumlah invoice terbanyak.
	- vendor_name dari table Vendors
    - Hitung jumlah invoices dari table invoices untuk masing-masing vendor
    - SUM dari kolom invoice_total dari table invoices untuk masing-masing vendor
**/
SELECT
	v.vendor_name,
    count(i.invoice_id) AS invoice_jumlah,
    SUM(i.invoice_total) AS Total_invoice
From ap.vendors v
JOIN ap.invoices i
ON v.vendor_id= i.vendor_id
GROUP BY v.vendor_name
ORDER BY  invoice_jumlah DESC, Total_invoice DESC
LIMIT 1;


/**
3. Buatlah syntax SQL untuk memasukkan data ke table Invoice_Line_Items
	- invoice_id = 115
    - invoice sequences = 1, 2
    - account number = 160, 557
    - line item amount = $180.67 , $654.35
    - line item description = Hard Drive,  Network Wiring
**/
INSERT INTO ap.invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amount,line_item_description)
VALUES
(115, 1,160, '180.67', 'Hard Drive'), 
(115, 2,557, '654.35', 'Network wiring');


/**
4. Tuliskan syntax UPDATE yang mengubah tabel Invoices.
	Ubahlah kolom terms_id menjadi "2" , untuk masing-masing invoice yang
    memiliki default_terms_id = 2 di tabel Vendor
**/
UPDATE ap.invoices 
SET terms_id = 2
WHERE vendor_id IN (
	SELECT vendor_id 
	FROM ap.vendors
	WHERE default_terms_id =2);

    
/**    
5. Tuliskan syntax UPDATE yang mengubah tabel Invoices.
	UPDATE kolom terms_id menjadi "1" , untuk masing-masing vendor yang
    berada di vendor_state = 'CA', 'AZ', 'NV'
    Hint: vendor_state berada di tabel vendors
**/
UPDATE ap.invoices 
SET terms_id =1
WHERE vendor_id IN (
	SELECT vendor_id
	FROM ap.vendors
	WHERE vendor_state IN ('CA','AZ', 'NV'));





    