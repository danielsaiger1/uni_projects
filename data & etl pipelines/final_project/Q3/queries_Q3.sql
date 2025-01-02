-- Question 3.1.
SELECT TOP 10 i.item_name, SUM(CAST(f.total_price AS float)) total_sales_amount
FROM item_dim i
JOIN 
	fact_table f 
ON 
	i.item_key = f.item_key
GROUP BY i.item_name
ORDER BY total_sales_amount DESC

-- Question 3.2.
SELECT TOP 10 i.item_name, SUM(CAST(f.quantity AS int)) total_quantity_sold
FROM item_dim i
JOIN 
	fact_table f 
ON 
	i.item_key = f.item_key
GROUP BY i.item_name
ORDER BY total_quantity_sold DESC

--Question 3.3.
SELECT TOP 5 i.man_country, SUM(CAST(f.quantity AS int)) total_quantity_sold, SUM(CAST(f.total_price AS float)) total_sales_amount
FROM item_dim i
JOIN 
	fact_table f 
ON 
	i.item_key = f.item_key
GROUP BY i.man_country
ORDER BY total_sales_amount DESC

--Question 3.4.
SELECT t.year, t.quarter, t.month, SUM(CAST(f.total_price AS float)) total_sales_amount
FROM time_dim t
JOIN 
	fact_table f
ON 
	t.time_key = f.time_key
GROUP BY t.year, t.quarter, t.month
ORDER BY total_sales_amount, t.year, t.quarter, t.month

--Question 3.5.
SELECT 
    f.coustomer_key, 
    c.name, 
    COUNT(DISTINCT tr.trans_type) AS count_used_trans_type
FROM 
    fact_table f
JOIN 
    Trans_dim tr ON f.payment_key = tr.payment_key
JOIN 
    customer_dim c ON f.coustomer_key = c.coustomer_key
GROUP BY 
    f.coustomer_key, c.name
HAVING 
    COUNT(DISTINCT tr.trans_type) > 1;
