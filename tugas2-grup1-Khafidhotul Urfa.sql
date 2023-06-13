-- Tugas 2 SQL Data Analytic
-- Tugas Individu
-- Nama: Khafidhotul Urfa
-- Grup: 1


-- Deadline 24 Maret 2023
/** 
1. Buatlah syntax SELECT yang mengambil kolom berikut ini:
	- 'vendor_name' dari tabel Vendors
    - 'invoice_number' dari tabel Invoices
    - 'invoice_date' dari tabel Invoices
    - 'balance_due' = 'invoice_total' - 'payment_total' - 'credit_total'
	
    *Tampilkan tabelnya dengan nilai balance_due yang masih berjalan (non-zero)
    *Gunakan Inner Join
    *Gunakan table alias: 'v' untuk Vendors, dan 'i' untuk Invoices
    *Urutkan dari nilai balance_due terbesar
**/
SELECT
	v.vendor_name, 
	i.invoice_number,
	i.invoice_date,
	invoice_total - payment_total - credit_total AS balance_due
FROM ap.vendors v
INNER JOIN ap.invoices i
ON v.vendor_id=i.vendor_id
HAVING balance_due > 0
ORDER BY balance_due DESC;


/** 
2. Buatlah syntax SELECT yang mengambil kolom berikut ini:
	- 'vendor_name'			=	dari tabel Vendors
    - 'default_account'		=	'default_account_number' dari tabel Vendors
    - 'description'			=	'account_description' dari tabel General_Ledger_Accounts
    
    *Masing-masing baris mewakili satu vendor
    *Table alias: 'v' untuk Vendors, dan 'gl' untuk General_Ledger_Accounts
    *Gunakan Inner Join
    *Urutkan berdasarkan kolom 'account_description' diikuti dengan 'vendor_name'
**/
SELECT 
	v.vendor_name, 
	v.default_account_number,
	gl.account_description
FROM ap.vendors v
INNER JOIN ap.general_ledger_accounts gl
ON v.default_account_number= gl.account_number
ORDER BY gl.account_description, v.vendor_name;


/** 
3. Buatlah syntax SELECT yang mengambil kolom berikut ini:
	- 'account_number'		=	dari tabel General_Ledger_Accounts
    - 'account_description'	=	dari tabel General_Ledger_Accounts
    - 'invoice_id'			=	dari tabel Invoice_Line_Items
    
    *Masing-masing baris mewakili nomor akun di general ledger yang tidak pernah digunakan
    *Gunakan outer join dan seleksi 'invoice_id' yang memiliki null value
    *Table alias: 'li' untuk Invoice_Line_Items, dan 'gl' untuk General_Ledger_Accounts
    *Urutkan berdasarkan kolom 'account_number'

**/
SELECT 
	gl.account_number, 
	gl.account_description,
    il.invoice_id
FROM ap.general_ledger_accounts gl
LEFT JOIN ap.invoice_line_items il
ON gl.account_number = il.account_number
WHERE invoice_id IS NULL
ORDER BY account_number;



/**
4.	*Tampilkan table yang berisi 2 kolom dari tabel Vendors: 'vendor_name' dan 'vendor_state'
	*Gunakan operator UNION
    *Jika vendor tersebut berada di California, 'vendor_state' = 'CA'
    *Sebaliknya jika di luar California, 'vendor_state' = 'Outside CA'
    *Urutkan berdasarkan nama vendor

**/
SELECT 
	vendor_name, 
    vendor_state
FROM ap.vendors
WHERE vendor_state ='CA'
UNION
SELECT 
	vendor_name, 
    IF (vendor_state ='CA', 'CA','Outside CA')
FROM ap.vendors
ORDER BY vendor_name;
