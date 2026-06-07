-- Set Theory 
-- Union...no duplicates

use SalesDB

SELECT 
	FirstName AS First_Name,
	LastName AS Last_Name
FROM Sales.Customers
UNION
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- Union All...with duplicates..faster than union

-- Combine all the data from employees and customers into one table including duplicates 
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL 
SELECT 
	FirstName,
	LastName 
FROM Sales.Employees

-- EXCEPT Operator ...returns unique values from 1st table that are not in the second table and also excludes duplicate values

-- Find employees who are not customers at the same time 
SELECT 
	FirstName,
	LastName 
FROM Sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- Intersect ...common rows or values between two tables

-- Find employes who are also customers
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
INTERSECT 
SELECT 
	FirstName,
	LastName
FROM Sales.Employees


-- Queries
-- Orders data are stored in separate orders table (Orders, OrdersArchive)
-- Combine all orders data into one table without duplicates

SELECT TOP (1000)
       'Orders' AS SourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
  FROM [SalesDB].[Sales].[Orders]
  UNION
  SELECT TOP (1000)
       'OrdersArchive' AS SourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
  FROM [SalesDB].[Sales].[OrdersArchive]
  ORDER BY OrderID ASC

	