CREATE VIEW V_Monthly_Summary AS 
(
	SELECT 
		DATETRUNC(month,OrderDate) AS OrderDate,
		SUM(Sales) AS Total_Sales,
		COUNT(OrderID) AS TotalOrder,
		SUM(Quantity) AS TotalQuantity 
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
)

SELECT
	OrderDate, 
	Total_Sales,
	SUM(Total_Sales) OVER(ORDER BY OrderDate) AS Running_total
FROM V_Monthly_Summary;


-- Provide view that contains details from orders, products, customers and employees

;CREATE VIEW v1 AS 
(
SELECT 
	o.OrderID,
	o.OrderDate,
	o.Sales,
	o.Quantity,
	p.Product,
	p.Category,
	p.Price,
	o.CustomerID,
	o.SalesPersonID,
	COALESCE(c.FirstName,' ') + ' ' + COALESCE(c.LastName,' ') AS CustomerName,
	c.Country,
	c.Score,
	COALESCE(e.FirstName,' ') + ' ' + COALESCE(e.LastName,' ') AS EmployeeName,
	e.Gender,
	e.Department,
	e.Salary
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN  Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
)


SELECT *
FROM v2

-- Combine all tables for EUSales Team Except the data where country is usa

;CREATE VIEW v2 AS 
(
SELECT 
	o.OrderID,
	o.OrderDate,
	o.Sales,
	o.Quantity,
	p.Product,
	p.Category,
	p.Price,
	o.CustomerID,
	o.SalesPersonID,
	COALESCE(c.FirstName,' ') + ' ' + COALESCE(c.LastName,' ') AS CustomerName,
	c.Country,
	c.Score,
	COALESCE(e.FirstName,' ') + ' ' + COALESCE(e.LastName,' ') AS EmployeeName,
	e.Gender,
	e.Department,
	e.Salary
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN  Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
WHERE c.Country != 'USA'
)
