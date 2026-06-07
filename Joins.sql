-- Joins
-- No join
SELECT *
from customers;
SELECT *
FROM orders

-- Inner Join

-- Get all the customers along with their orders, but only customers who have placed an order 
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id

-- LEFT JOIN ..all the data from left table and only matching data from right table 

-- Get all the customers along with their orders including those without orders 
SELECT 
	c.id,
	c.first_name,
	o.customer_id,
	o.sales
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id 

-- Right Join ..all the data from right table and only matching ones from left table 

-- Get all the data from orders and from customers only matching ones 
SELECT 
	o.customer_id,
	o.sales,
	c.id,
	c.first_name
FROM orders o
RIGHT JOIN customers c
ON o.customer_id = c.id

-- Full join
-- Get all customers and order even if there is no match 
SELECT 
	c.id,
	c.first_name,
	o.customer_id,
	o.sales
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id


-- Advance joins 
-- Left Anti Join 

-- Get all customers who havent placed any order 
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id is NULL 

-- Right Anti Join

-- Get all orders without matching customers 
SELECT *
FROM orders o
RIGHT JOIN customers c
ON o.customer_id = c.id 
WHERE c.id is NULL

-- Full Anti Join 
-- Returns rows that don't match in either tables 
-- Only unmatching data 

-- Find customers without orders and orders without customers 
SELECT *
FROM customers c
FULL JOIN orders o 
ON c.id = o.customer_id
WHERE c.id is NULL OR o.customer_id is NULL

-- Get all the customers along with their orders, but only for customers who have placed an order 
SELECT * 
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id 
WHERE o.customer_id is NOT NULL

-- Cross Join 
-- Combined every row from left with every row from right 
-- all possile combinations - Cartesian Join

-- Generate all possible combination of customers and orders 
SELECT * 
FROM customers 
CROSS JOIN orders 

use SalesDB

-- Multi Joins 
 SELECT *
 FROM Sales.Orders

 SELECT 
	o.OrderID,
	o.Sales,
	e.FirstName,
	e.LastName,
	p.Product AS ProductName 
 FROM Sales.Orders AS o
 LEFT JOIN Sales.Customers AS c
 ON o.CustomerID = c.CustomerID 
 LEFT JOIN Sales.Products AS p
 ON o.ProductID = p.ProductID 
 LEFT JOIN Sales.Employees AS e
 ON o.SalesPersonID = e.EmployeeID










