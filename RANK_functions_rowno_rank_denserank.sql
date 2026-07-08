-- Rank Functions 
-- Integer based ranking
-- Rank the orders based on their sales from highest to lowest 
SELECT 
	OrderID,
	OrderDate,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) Sales_Rank
FROM Sales.Orders

-- RANK()	
-- Assign a rank to each row 
-- It handles ties 
-- It leaves gap in ranking 

-- Rank the orders based on their sales from highest to lowest 
-- Same example
SELECT 
	OrderID, 
	OrderDate,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales) AS Sales_Rank,
	RANK() OVER(ORDER BY Sales) AS Sales_Rank2
FROM Sales.Orders 

-- DENSE_RANK()
-- Assign a rank to each row 
-- It handle ties 
-- It doesn't leave any gaps 
-- Same example
SELECT 
	OrderID,
	OrderDate,
	Sales, 
	ROW_NUMBER() OVER(ORDER BY Sales) AS Sales_rank,
	RANK() OVER(ORDER BY Sales) AS Sales_rank2,
	DENSE_RANK() OVER(ORDER BY Sales) AS Sales_rank3
FROM Sales.Orders 

-- ROW NUMBER 
-- Use case 
-- Find the top highest sales for each product 
SELECT*
FROM(
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) Rank_number
FROM Sales.Orders)t WHERE Rank_number = 1

-- Use Case BOTTOM-N Analysis row number
-- help analysis the underperformance to manage risks and do optimizations 
-- Find the lowest two customers based on their total sales
SELECT *
FROM(
SELECT 
	CustomerID,
	SUM(Sales) AS Total_Sales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) AS Low_sales
FROM Sales.Orders
GROUP BY CustomerID)t WHERE Low_sales <= 2

-- USE CASE -- row number 
-- Generate unique ids
-- Help assign unique identifiers for each row to help paginating 
-- Paginating meaning dividing large data into smaller, more manageable chunks
-- Assign unique ids to the rows of the OrdersArchive 
SELECT 
	ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueIDS,
	*
FROM Sales.OrdersArchive 
  
-- USE CASE ROW_NUmber 
-- Identify Duplicates 
-- Identify and remove duplicate rows to improve data quality
-- qs: Identify duplicates in OrdersArchive and return a clean result without any duplicates 
-- here we need to use the primary key in partition by 
SELECT *
FROM(
SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime) rn,
*
FROM Sales.OrdersArchive)t WHERE rn = 1

-- NTILE()..Divides the rows into a specified number of approx equal groups (buckets)

-- buckets	
SELECT 
	OrderID,
	OrderDate,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) bucket1,
	NTILE(2) OVER(ORDER BY Sales DESC) bucket2,
	NTILE(3) OVER(ORDER BY Sales DESC) bucket3,
	NTILE(4) OVER(ORDER BY Sales DESC) bucket4
	FROM Sales.Orders

	-- NTIlE()
	-- USE CASE ...Data Segmentation
	-- Segment all orders into 3 categories : high, medium and low sales
	SELECT *,
		CASE 
		WHEN categories=1 THEN 'HighSales'
		WHEN categories=2 THEN 'MediumSales'
		WHEN categories=3 THEN 'LowSales'
		END Categories
	FROM 
	(
	SELECT 
		OrderID,
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) categories
	FROM Sales.Orders )t

	-- UseCase -- equalizing loads 
	-- In order to export the data divide the orders into 2 groups 
	SELECT 
	NTILE(2) OVER(ORDER BY OrderID) buckets,
	*
	FROM Sales.Orders

	-- Percentile based ranking 
	-- CUME_DIST()
	-- PERCENT_RANK()

	-- Find the products that fall within the highest 40% of the prices 
	SELECT * ,
	CONCAT(Distrank*100,'%') AS Percentage_value
	FROM(
	SELECT 
		ProductID,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) Distrank 
	FROM Sales.Products)t
	WHERE Distrank  <= 0.4


