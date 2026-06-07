-- Aggregate functions 

-- Find the total number of orders 

 use MyDatabase

 SELECT 
	COUNT(*) AS Total_no_orders
 FROM orders

 -- Find the total sales 
 SELECT 
	SUM(sales) AS Total_sales
 FROM orders

 -- Find the average sales
 SELECT 
	AVG(sales) AS Avg_sales
FROM orders

-- Highest sale and Lowest sale
SELECT 
	MAX(sales) AS Highest_sale,
	MIN(sales) AS Lowest_sale
FROM orders 

SELECT 
	customer_id,
	COUNT(*) AS total_orders,
	SUM(sales) AS total_sales,
	AVG(sales) AS avg_sales,
	MAX(sales) As highest_sale,
	MIN(sales) AS lowest_sale
FROM orders 
GROUP BY customer_id

