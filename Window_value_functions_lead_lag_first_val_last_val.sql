-- Window value functions
-- LEAD() access a value from next row 
-- LAG() access a value from previous row 
-- USE CASE Time Series Analysis 
-- The process of analyzing data to understand trends, patterns and behavious over time 

-- Qs Analyze the month-over month performance by finding the percentage change in sales 
-- between the current and previous months
SELECT *,
	Current_month_sales - Previous_month_sales AS MoM_change,
	ROUND(CAST((Current_month_sales - Previous_month_sales) AS FLOAT)/Previous_month_sales*100,2) AS percentage_ 
FROM (
SELECT 
	SUM(Sales) AS Current_month_sales,
	MONTH(OrderDate) as months,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) Previous_month_sales
FROM Sales.Orders 
GROUP BY MONTH(OrderDate)
)t	

-- Customer Retention Analysis 
-- Analyze customer loyalty by ranking customers based on the average number of days between the orders 
SELECT 
	CustomerID,
	AVG(Date_diff)  Avg_no_days_between_orders,
	RANK() OVER(ORDER BY COALESCE(AVG(Date_diff),9999)) rank_
FROM(
SELECT 
	OrderID,
	CustomerID,
	OrderDate CurrentOrder,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF(day,OrderDate , LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) Date_diff
FROM Sales.Orders)t
GROUP BY CustomerID 

-- FIRST_VALUE ...access the first row within a window
-- LAST_VALUE....access the last row within a window 
-- Find the lowest and highest sales for each product 
-- Find the difference between the current sales and the lowest sales
SELECT 
	ProductID,
	Sales,
	Sales - LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 
	Diff_sales_lowest_sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Highest_sale_by_each_product,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) 
	Lowest_sale_by_each_product
FROM Sales.Orders 
 

