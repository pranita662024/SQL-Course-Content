-- Date Calculation
-- DateAdd and DateDiff

-- DATEADD(part,interval,date)

-- Add 2 years for OrderDate
SELECT
	OrderID,
	OrderDate,
	DATEADD(year,2,OrderDate) AS [ Two Year Later],
	DATEADD(month,-2,OrderDate) AS [ Two months back],
	DATEADD(day, -10, OrderDate) AS [ 10 Days back]
FROM Sales.Orders 

-- DATEDIFF(part,start_date_end_date)

-- Calculate the age of employees
SELECT 
	EmployeeID,
	BirthDate,
	DATEDIFF(year,BirthDate,GETDATE()) AS Age
FROM Sales.Employees

-- Find the average shipping duration in days for each month
SELECT 
	MONTH(OrderDate) AS OrderDate,
	AVG(DATEDIFF(day,OrderDate,ShipDate)) AVGShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- Time Gap Analysis 
-- Find the number of days between each order and the previous order 
SELECT 
	OrderID,
	OrderDate AS Current_order_date,
	LAG(OrderDate) OVER (ORDER BY OrderDate)  Previous_order,
	DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS Days_inbetween_previous_and_current_OrderDate
FROM Sales.Orders 

-- ISDATE() ...checks whether a value is a date or not
SELECT 
	ISDATE(2022-09-07)

-- NULL Functions 
-- ISNULL(Value,replace_value_with)




