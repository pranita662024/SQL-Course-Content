-- Window aggregate functions 

-- Find the total number of orders 
-- add additional rows 
SELECT 
	OrderID,
	OrderDate,
	COUNT(OrderID) OVER() AS total_orders
FROM Sales.Orders 

-- Find the total number of orders for each customer
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER(PARTITION BY CustomerID) AS total_orders_per_customer
FROM Sales.Orders

-- Find the total number of customers 
-- add all details 
SELECT *,
	COUNT(*) OVER() TotalCustomers
FROM Sales.Customers

-- Find the total number of scores 
SELECT *,
	COUNT(Score) OVER() TotalNumberofScores
FROM Sales.Customers

-- usecase COUNT()
-- Overall Analysis 
-- Category Analysis 
-- Quality checks : null values 
-- Data Quality issues
-- Duplicates leads to inaccuracies in data analysis COUNT() can be used to identify duplicates 

-- Check whether the table order contains any duplicates
use SalesDB

SELECT *
FROM (
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) CheckDuplicates
FROM Sales.OrdersArchive) t WHERE CheckDuplicates > 1

-- SUM() 
-- Returns the sum of all values in each window

-- Find the total sales across all orders and the total sales for each product 
-- add orderid and orderdate
SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() Total_sales,
	SUM(Sales) OVER(PARTITION BY ProductID)  Sales_By_each_product
FROM Sales.Orders

-- Comparison use cases 
-- Compare the current value and aggregated value of window functions
-- Part-To-Whole Analysis ...shows the contribution of each data point to the total sales

-- Find the percentage contribution of each product's sales to the total sales 
SELECT 
	OrderID,
	OrderDate,
	Sales,
	SUM(Sales) OVER() Total_sales,
	ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER() * 100,2) AS Contribution_percent_by_each_product
FROM Sales.Orders 

-- AVG()
-- Find the avg sales across all orders as well as for each product 
-- add additional columns 
SELECT 
		OrderID,
		OrderDate,
		AVG(Sales) OVER() Avg_sales,
		AVG(Sales) OVER(PARTITION BY ProductID) Avg_by_each_product
FROM Sales.Orders 

-- Find the avg scores of customer 
-- add additional columns
SELECT 
	CustomerID,
	FirstName,
	LastName,
	Score,
	AVG(COALESCE(Score,0)) OVER() avg_sales
FROM Sales.Customers

-- Find all orders where the sales are higher than the average sales across all orders 
SELECT *
FROM(
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	Sales,
	AVG(Sales) OVER() Avg_sales
FROM Sales.Orders)t WHERE Sales > Avg_sales
 
 -- MIN() 
 -- Returns lowest value within a window
 -- MAX()
 -- Returns highest value within a window

 -- Find highest and lowest sales
 -- then find highest and lowest sales for each product 
 -- add additional info 
 SELECT 
	OrderID,
	OrderDate,
	Sales,
	MIN(Sales) OVER() lowest_sale,
	MAX(Sales) OVER() highest_sale,
	MIN(Sales) OVER(PARTITION BY ProductID) lowest_sale_by_product,
	MAX(Sales) OVER(PARTITION BY ProductID) highest_sale_by_product
 FROM Sales.Orders

 -- Show the employees who have highest salary
 SELECT *
 FROM(
 SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	MAX(Salary) OVER() highest_salary
 FROM Sales.Employees)t  WHERE salary = highest_salary

 -- Find the deviation of each sales from the minimum and maximum sales amounts
 SELECT 
	OrderID,
	OrderDate,
	Sales,
	MIN(Sales) OVER() lowest_sale,
	MAX(Sales) OVER() highest_sale,
	Sales - MIN(Sales) OVER() AS min_deviated_sale,
	MAX(Sales) OVER() - Sales AS max_deviated_sale
 FROM Sales.Orders 

 -- Running total and Rolling total 
 -- Usecase is to track current sales with target sales 
 -- They aggregate sequence of members and the aggregation is updated each time a new member is added
 -- called as analysis over time 

 -- Running total
 -- Aggregate all values from the beginning up to the current point without dropping off older data 

 --  Rolling total 
 -- Aggregate all values within a fixed window (e.g. 30 days). As new data is added, the oldest data point will be dropped 

 -- Calculate moving average of sales for each product over time
 SELECT 
	OrderID,
	OrderDate,
	Sales,
	AVG(Sales) OVER() total_avg,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) moving_avg,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) rolling_avg_sales
 FROM Sales.Orders 




