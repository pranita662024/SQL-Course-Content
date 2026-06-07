-- Numeric Function

-- Round 

SELECT
	3.516 AS num,
	ROUND(3.516,2) AS round_2,
	ROUND(3.516,1) AS round_1,
	ROUND(3.516,0) AS round_0

SELECT -10,
	ABS(-10) AS absolute_value,
	ABS(10) AS absolute_value

-- DateTime Functions 

use SalesDB

SELECT 
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime 
FROM Sales.Orders

-- hardcoded date and current datetime
SELECT 
	OrderID,
	'2026-04-30' Hardcoded,
	GetDate() Today
FROM Sales.Orders 

-- Exraction Funtions 

-- Extract day, month and year from creationtime 
SELECT 
	OrderID,
	CreationTime,
	YEAR(CreationTIme) Year_,
	MONTH(CreationTime) Month_,
	DAY(CreationTime) Day_
FROM Sales.Orders 

-- Datepart(part,date)

SELECT 
	OrderID,
	CreationTime,
	DatePart(month,CreationTime) AS Month_,
	DatePart(day,CreationTime) AS Day_,
	DatePart(year, CreationTime) AS Year_,
	DatePart(hour,CreationTime) AS Hour_,
	DatePart(quarter,CreationTime) AS quarter_,
	DatePart(week,CreationTime) AS week_
FROM Sales.Orders


-- DateName 

SELECT 
	OrderID,
	CreationTime,
	DateName(month,CreationTime) AS Month_name,
	DateName(weekday,CreationTime) AS Day_of_the_date,
	DateName(day,CreationTime) AS use_day
FROM Sales.Orders 
ORDER BY OrderID

--DateTrunc

SELECT 
	OrderID,
	CreationTime,
	DATETRUNC(MONTH,CreationTime) AS month_,
	DATETRUNC(YEAR,CreationTime) AS year_,
	DATETRUNC(DAY,CreationTime) AS day_,
	DATETRUNC(HOUR,CreationTime) AS hour_
FROM Sales.Orders 

-- using groupby 
SELECT 
	COUNT(*),
	DATETRUNC(month,CreationTime)
FROM Sales.Orders
GROUP BY DATETRUNC(month,CreationTime)

-- End of Month 
SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) AS End_of_the_month,
	CAST(DATETRUNC(month,CreationTime) AS DATE )Start_of_the_month
FROM Sales.Orders

-- How many orders were placed each year
SELECT 
	YEAR(CreationTime),
	COUNT(*)
FROM Sales.Orders
GROUP BY Year(CreationTime)

-- How many orders are placed in a month 
SELECT 
	DATENAME(month,CreationTime) AS month_of_sale,
	COUNT(*) AS NO_of_sales
FROM Sales.Orders 
GROUP BY DATENAME(month,CreationTime)

-- Show all orders that were placed in the month of february
SELECT 
	DATENAME(month,CreationTime) AS month_of_the_date,
	COUNT(*) AS sale_in_february
FROM Sales.Orders 
GROUP BY DATENAME(month,CreationTime)
HAVING DATENAME(month,CreationTime) = 'February'







