-- Melakukan JOIN
SELECT
	orderdetails.productCode,
    products.productName,
    products.productDescription,
    products.productLine,
    SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS Total
FROM belajar.orderdetails
JOIN belajar.products
ON belajar.orderdetails.productCode = belajar.products.productcode
GROUP BY orderdetails.productCode
ORDER BY Total DESC;

-- Tabel alias (Mempersingkat penulisan JOIN
SELECT
	a.productCode,
    b.productName,
    b.productDescription,
    b.productLine,
    SUM(a.quantityOrdered * a.priceEach) AS Total
FROM belajar.orderdetails AS a
JOIN belajar.products AS b
ON a.productCode = b.productcode
GROUP BY a.productCode
ORDER BY Total DESC;

-- Challenge
-- Tampilkan top 10 customers yang melakukan transaksi terbanyak
-- Tampilkan informasi detail mengenai customer
-- Hint: Gunakan tabel Orders lalu joinkan dengan tabel Customers
-- Hint: Gunakan fungsi aggregate COUNT(...)
-- Answer By: Firman Wahyudi
SELECT
	customers.customerName,
	CONCAT(customers.contactFirstName," ", customers.contactLastName) as "Contact Name",
	customers.phone,
	customers.city,
	customers.country,
	COUNT( orders.customerNumber ) as total
FROM
	customers
	JOIN orders ON customers.customerNumber = orders.customerNumber
GROUP BY orders.customerNumber
ORDER BY total DESC
LIMIT 10;

-- Challenge
-- Tampilkan seluruh customer yg melakukan pemesanan tetapi statusnya on hold
-- Hint: Gunakan tabel Orders lalu joinkan dengan tabel Customers
-- Hint: Filtering pada kolom status On Hold atau Disputed
-- Answer Firman Wahyudi
SELECT
	customers.customerName,
	CONCAT( customers.contactFirstName, " ", customers.contactLastName ) AS "Contact Name",
	customers.phone,
	customers.city,
	customers.country,
	orders.`status`
FROM
	customers
	JOIN orders ON customers.customerNumber = orders.customerNumber 
WHERE orders.`status` = 'On Hold' or orders.`status` = 'Disputed';

-- Join Lebih dari satu tabel
SELECT 
    b.orderDate,
    c.customerName,
    SUM(a.quantityOrdered * a.priceEach) AS Total
FROM belajar.orderdetails AS a
JOIN belajar.orders AS b
ON a.orderNumber = b.orderNumber
JOIN belajar.customers c
ON b.customerNumber = c.customerNumber
GROUP BY b.orderDate, c.customerName
ORDER BY c.customerName DESC;

-- Melakukan grouping dengan urutan kolom
SELECT 
    b.orderDate,
    c.customerName,
    SUM(a.quantityOrdered * a.priceEach) AS Total
FROM belajar.orderdetails AS a
JOIN belajar.orders AS b
ON a.orderNumber = b.orderNumber
JOIN belajar.customers c
ON b.customerNumber = c.customerNumber
GROUP BY 1,2
ORDER BY c.customerName DESC;

-- Melakukan subquery
SELECT
    b.productName,
    AVG(a.quantityOrdered) AS avg_qty
FROM belajar.orderdetails AS a
JOIN belajar.products AS b
ON a.productCode = b.productcode
GROUP BY a.productCode
HAVING avg_qty > (SELECT AVG(quantityOrdered) FROM belajar.orderdetails)
ORDER BY avg_qty DESC;

-- Melakukan subquery (2)
SELECT
    b.productName,
    AVG(a.quantityOrdered) AS avg_qty
FROM (SELECT * FROM belajar.orderdetails) AS a
JOIN (SELECT * FROM belajar.products) AS b
ON a.productCode = b.productcode
GROUP BY a.productCode
HAVING avg_qty > (
	SELECT AVG(x.quantityOrdered) FROM (
		SELECT * FROM (
			SELECT * FROM belajar.orderdetails
		) AS y
	) AS x
)
ORDER BY avg_qty DESC;

-- Menampilkan customers yg belum pernah melakukan orders pada bulan february
SELECT
	customerNumber,
    customerName,
    phone,
    creditLimit
FROM belajar.customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM belajar.orders WHERE MONTHNAME(orderDate) != "February")
ORDER BY creditLimit DESC;

-- Answer By: Fisabiluddin
SELECT
	c.customerNumber,
    c.customerName,
    c.phone,
    c.creditLimit
FROM belajar.customers AS c
JOIN belajar.orders AS o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL OR MONTHNAME(o.orderDate) = "January"
ORDER BY c.creditLimit DESC;