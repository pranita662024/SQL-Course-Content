 -- CASE STATEMENT 
-- The main purpose is data transformation
-- Derive new information
-- Creating new columns based on existing data 

-- Categorizing data 
-- group data into different categories based on certain conditions 

-- Create report by showing total sales for each of the foll categories
-- sales over 50 high, 21 to 50 medium and less than 20 low 
-- sort the categories from highest to lowest 

use SalesDB

SELECT *
FROM Sales.Orders 

SELECT 
	Category,
	SUM(Sales) AS Total_sales
	FROM (
SELECT 
	OrderID,
	Sales,
	CASE 
		WHEN Sales > 50 THEN 'High'
		WHEN Sales BETWEEN 21 AND 50 THEN 'Medium'
	ELSE
		'Low'
	END Category
FROM Sales.Orders
)t
GROUP BY Category
Order BY Total_sales DESC

-- Mapping ...transform the values from one form to another 
-- for example showing 1 and 0 in categories like active and inactive 

-- Convert the gender from m to male and f to female 
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	CASE 
		WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
	END Gender
FROM Sales.Employees

-- Customer details with abbreviated country code
SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE 
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE
			'N/A'
	END Country_code
	FROM Sales.Customers

-- You can use
-- CASE Country 
	--	WHEN 'USA'THEN 'US'
-- Handling nulls 
-- Replace nulls with a specific value 
-- Nulls can lead to inaccurate results which can lead to wrong decision-making 

-- Find the average scores of customers and treat nulls as 0
-- add details such as customerid and LastName 

use SalesDB

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Score,
	CASE 
		WHEN Score IS NULL THEN 0
		ELSE Score 
	END Score_clean,
	AVG(CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END) OVER() AverageScore
	FROM Sales.Customers 

-- Conditional Aggregation
-- Apply aggregation functions to only on subsets of data that fulfill certain conditions 

-- Count how many times each customer has made an order with sales greater than 30
SELECT 
	CustomerID,
	SUM(Sales) AS Sales_above_30,
	COUNT(*)
FROM Sales.Orders 
WHERE Sales > 30
GROUP BY CustomerID
ORDER BY CustomerID

SELECT 
	CustomerID,
	SUM(CASE 
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) TotalOrderHighSale,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID



