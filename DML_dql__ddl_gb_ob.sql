USE MyDatabase

SELECT *
FROM customers

SELECT *
FROM customers
WHERE country = 'Germany'

SELECT *
FROM customers 
WHERE score != 0


SELECT *
FROM customers
ORDER BY country ASC, score DESC

-- Find the total score for each country 
SELECT 
	country,
	SUM(score) AS total_score,
	first_name
FROM customers 
GROUP BY country, first_name 

-- Find the total number of customers and total score for the country
SELECT  
	SUM(score) AS total_score,
	COUNT(id) AS total_customers,
	country
FROM customers 
GROUP BY country
 
/* Find the average score for each country considering only customers with a score not equal to 0 
   and return only those countries with an average score greater than 430
*/
SELECT 
	country, 
	AVG(score) AS avg_score
FROM customers
WHERE score != 0 
GROUP BY country
HAVING AVG(score)> 430

-- Return all the unique countries
SELECT DISTINCT
	country 
FROM customers

-- Retrieve only 3 customers
SELECT TOP 3 *
FROM customers

-- Retrieve top 2 customers with highest scores
SELECT TOP 3 *
FROM customers 
ORDER BY score DESC

-- Retrieve the lowest 2 customers based on score
SELECT TOP 2 *
FROM customers 
ORDER BY score ASC

-- GEt the 2 most recent orders 
SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC

-- Adding static values 
SELECT	
	first_name,
	country,
	'Darji' AS last_name
FROM customers

-- DDL Operations
-- Create 
/* Make a table persons with columns id, person_name, birth_date and phone
*/
CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(45) NOT NULL,
	birth_date DATE, 
	phone VARCHAR(20) NOT NULL 
	CONSTRAINT pk_persons PRIMARY KEY(id)
)

-- Alter ...DDL operation
-- Add a new column email to the table 

ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL 

-- Remove the column phone from persons table 
ALTER TABLE persons 
DROP COLUMN phone 

SELECT * 
FROM customers 

-- DROP ...DDL operation
DROP TABLE persons

--DML operations
-- Insert values into customers table
INSERT INTO customers ( id, first_name, country, score)
VALUES (6, 'Smit', 'Dhansura' , null),
	   (7, 'Pranita','Mumbai',160)

INSERT INTO customers ( id, first_name, country, score)
VALUES (8, 'Andrea', 'Germany' , null)
	
CREATE TABLE persons(
	id INT not null, first_name VARCHAR(50), birth_date DATE, phone VARCHAR(20) not null
)

-- Copy data from the table customers to persons 
INSERT INTO persons (id, first_name, birth_date, phone)
SELECT 
	id, 
	first_name,
	null,
	'Unknown'
FROM customers 
	
SELECT * 
FROM customers

-- Update command
-- Change the score to 0 where id is 6
UPDATE customers
SET score = 0
WHERE id = 6

-- set score to 0 and country to uk for id 10
UPDATE customers 
SET score = 0, country = 'UK'
WHERE id = 8

-- Delete from table where id is greater than 5
DELETE FROM customers
WHERE id>5

SELECT *
FROM customers





