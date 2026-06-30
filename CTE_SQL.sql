-- CTE 
use SalesDB

WITH CTE_Total_Sales AS (
SELECT CustomerID, SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY CustomerID
) 
-- Segment Customers Based on their total sales 
, CTE_Customer_Segment AS 
(
SELECT 
	CustomerID, 
	CASE 
		WHEN Total_Sales > 100 THEN 'High'
		WHEN Total_Sales BETWEEN 50 AND 100 THEN 'Medium'
		ELSE 'Low'
	END AS Customer_segments
FROM CTE_Total_Sales
)
-- Rank the customers based on Total Sales Per Customers 
,CTE_Rank_Customers AS (
SELECT
	CustomerID,
	Total_Sales,
	RANK() OVER(ORDER BY Total_Sales DESC ) AS Customer_ranks
FROM CTE_Total_Sales
)
-- Find the last order date for each customer (Standalone cte)
,CTE_Last_Order_Date AS 
(
 SELECT CustomerID , MAX(OrderDate) AS Last_order
 FROM Sales.Orders
 GROUP BY CustomerID
)

-- Main Query
SELECT o.CustomerID, o.FirstName, o.LastName, cts.Total_Sales, lod.Last_order, rc.Customer_ranks, cs.Customer_segments
FROM Sales.Customers o
LEFT JOIN CTE_Total_Sales cts
ON o.CustomerID = cts.CustomerID
LEFT JOIN CTE_Last_Order_Date lod
ON lod.CustomerID = cts.CustomerID
LEFT JOIN CTE_Rank_Customers rc
ON lod.CustomerID = rc.CustomerID
LEFT JOIN CTE_Customer_Segment cs
ON rc.CustomerID = cs.CustomerID



-- Recursive CTE
WITH CTE_Sequence AS 
(
	SELECT 1 AS Sequence_no
	UNION ALL 
	SELECT Sequence_no + 1
	FROM CTE_Sequence 
	WHERE Sequence_no < 20
)
-- Main Query
SELECT *
FROM CTE_Sequence

-- Manager and employees
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + COALESCE(e.LastName,' ') AS EmployeeName,
    m.FirstName + ' ' + COALESCE(m.LastName,' ') AS ManagerName
FROM Sales.Employees e
LEFT JOIN Sales.Employees m
    ON e.ManagerID = m.EmployeeID;

SELECT *
FROM Sales.Employees

-- Show employee hierarchy by displaying each employee's level within the organization


;WITH CTE_Running_Total AS 
(
SELECT DATETRUNC(month,OrderDate) AS month_, SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)
SELECT 
	month_,
	Total_Sales,
	SUM(Total_Sales) OVER(ORDER BY month_) AS Running_total
FROM CTE_Running_Total;


