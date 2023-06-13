USE ap;

-- Mengambil data dari 2 table menggunakan JOIN USING
-- Mencari Vendor yang tagihannya masih berjalan
-- Inner Join antara table vendor dengan table invoices
SELECT vendor_name, vendor_phone, invoice_number, invoice_due_date,
	invoice_total - payment_total - credit_total AS balance_due	
FROM vendors
JOIN invoices
	USING(vendor_id)
HAVING balance_due > 0
ORDER BY invoice_due_date;

-- LEFT Outer JOIN
SELECT vendor_name, invoice_number, invoice_total
FROM vendors
LEFT JOIN invoices
USING (vendor_id)
ORDER BY vendor_name;

-- RIGHT Outer JOIN
SELECT vendor_name, invoice_number, invoice_total
FROM vendors
RIGHT JOIN invoices
USING (vendor_id)
ORDER BY vendor_name;

-- Menggabungkan informasi lebih dari 2 table
-- Menggabungkan operator INNER JOIN dan OUTER Join
SELECT vendor_name, invoice_number, invoice_date, line_item_amount
FROM vendors
	JOIN invoices
		USING (vendor_id)
	LEFT JOIN invoice_line_items
		USING (invoice_id)
ORDER BY vendor_name DESC, line_item_amount DESC;

-- SELF JOIN
-- Mencari nama vendor yang berada di kota yang sama
SELECT DISTINCT v1.vendor_name, v1.vendor_city, v1.vendor_state
FROM vendors v1
JOIN vendors v2
	ON v1.vendor_city = v2.vendor_city AND
		v1.vendor_state = v2.vendor_state AND
        v1.vendor_name != v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city;

-- UNION
-- Menggabungkan table hasil query dari table yang berbeda dengan struktur data yang sama
	SELECT invoice_number, invoice_date, invoice_total,
		'Active' AS 'Status'
	FROM active_invoices
	WHERE invoice_date > '2018-06-01'
UNION
	SELECT invoice_number, invoice_date, invoice_total,
		'Paid' AS 'Status'
	FROM paid_invoices
	WHERE invoice_date > '2018-06-01'
ORDER BY invoice_total;

-- Menampilkan total invoice yang perlu dibayarkan
-- Melakukan operasi UNION pada tabel yang sama
	SELECT invoice_number, vendor_name,
		invoice_total AS 'Total',
		'30% Payment' AS 'Payment_Type',
		invoice_total * 0.3 AS 'Payment'
	FROM invoices JOIN vendors
	USING (vendor_id)
	WHERE invoice_total > 15000
UNION
	SELECT invoice_number, vendor_name,
		invoice_total AS 'Total',
		'50% Payment' AS 'Payment_Type',
		invoice_total * 0.5 AS 'Payment'
	FROM invoices JOIN vendors
	USING (vendor_id)
	WHERE invoice_total BETWEEN 500 AND 15000
UNION
	SELECT invoice_number, vendor_name,
		invoice_total AS 'Total',
		'Full Payment' AS 'Payment_Type',
		invoice_total AS 'Payment'
	FROM invoices JOIN vendors
	USING (vendor_id)
	WHERE invoice_total < 500
ORDER BY Payment_Type , vendor_name, invoice_number;

-- WITH ROLLUP; Menambahkan Grand Total dan Sub Total di table hasil aggregasi/summary
SELECT vendor_id,
	COUNT(*) AS invoice_count,
    SUM(invoice_total) AS invoice_total
FROM invoices
GROUP BY vendor_id WITH ROLLUP
ORDER BY vendor_id ASC;



-- By: Mhd. Fisabilludin
SELECT i.vendor_id, v.vendor_name, 
COUNT(*) AS invoice_count, 
SUM(invoice_total) AS invoice_total
FROM invoices AS i
JOIN vendors AS v
	ON i.vendor_id = v.vendor_id
GROUP BY i.vendor_id, v.vendor_name WITH ROLLUP;

-- GROUPING() DAN IF() untuk membuat Subtotal dan Grand Total
SELECT 
	IF(GROUPING(invoice_date) = 1 , 'Grand Totals', invoice_date) AS invoice_date, 
	IF(GROUPING(payment_date) = 1, 'Invoice Date Totals', payment_date) AS payment_date,
	SUM(invoice_total) AS invoice_total,
    SUM(invoice_total - payment_total - credit_total) AS balance_due
FROM invoices
GROUP BY invoice_date, payment_date WITH ROLLUP;