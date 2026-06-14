-- Window Functions 
-- Group by vs Window 
-- Simple aggregations vs aggregations + details
-- Both have same aggregation function but group by has limited functions whereas windows have additional functions 
-- Simple data analysis vs advance data analysis 

-- Find the total sales accross all orders 
use SalesDB

SELECT 
	SUM(Sales) Total_Sales
FROM Sales.Orders

-- Find total sales for each product
SELECT 
	ProductID,
	SUM(Sales) TotalSales 
FROM Sales.Orders 
GROUP BY ProductID 

-- Find total sales for each product 
-- additionally provide details of orderid and order date
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) Total_Sales
FROM Sales.Orders

-- Window Syntax          over clause
-- window function .... partiton/order/frame

-- Find the total sales accross all orders 
-- add orderid and orderdate column too
SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() TotalSales
FROM Sales.Orders

-- Find the total sales for each product 
-- Find total sales for each combination of product and order status
-- add orderid and orderdate
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) Sales_by_product,
	SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) Sales_by_productid_orderstatus
FROM Sales.Orders

-- Rank each order based on sales from highest to lowest
-- additional info orderid, orderdate
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	RANK() OVER(ORDER BY Sales DESC) Sales_high_low
FROM Sales.Orders	

-- FRAME Clause Example

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- Rules 
-- 1.use window function in select and order by only 
-- 2. You cannot filter data using window function
-- 3. SQL execute windows function after where clause 
-- 4. Window Function can be used together with group by clause only if the same columns are used  


-- use window function in order by 
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders 
ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus) DESC

-- Find the the total sales for each order status, only for 2 products 101 and 102
SELECT 
	OrderID,
	OrderDate,
	Sales,
	OrderStatus,
	ProductID,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) Total_sales_altered
FROM Sales.Orders 
WHERE ProductID IN (101,102)

-- use of group by and window function together example
-- Rank Customers based on their total sales 
SELECT 
	CustomerID,
	SUM(Sales) AS Total_sales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) Rank_Customers
FROM Sales.Orders 
GROUP BY CustomerID

