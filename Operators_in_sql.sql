-- Operator in sql 
-- Assignment Operators (=,<,>,<=,>=,<>)

-- Retrieve all the customers who are from USA
SELECT *
FROM customers
WHERE country = 'USA'

--Retrieve all the customers where country is not germany
SELECT * 
FROM customers 
WHERE country <> 'Germany'

--Score greater then 500 or more
SELECT *
FROM customers
WHERE score >= 500

--Score less than 500 or low
SELECT *
FROM customers 
WHERE score <=500

-- Logical Operators (AND, OR, NOT)

-- AND operator ...all conditions must be true
-- Retrieve customers who are from usa and have score more than 500
SELECT *
FROM customers 
WHERE country = 'USA' and score > 500


-- OR operator ..atleast one condition must be true
-- Retrieve customers who are either from usa or have score greater than 500
SELECT *
FROM customers 
WHERE country = 'USA' OR score > 500

--NOT operator
-- Score not less than 500
SELECT *
FROM customers 
WHERE NOT score < 500

-- Range Operator 
-- between 
-- lower boundary ..between...upper boundary..inclusive ub and lb 

-- score between 100 and 500
SELECT * 
FROM customers
WHERE score BETWEEN 100 and 500

-- Membership Operator
-- in ...not in 

-- Retrieve customers from either germany or usa
SELECT *
FROM customers 
WHERE country IN ('Germany','USA')

-- Search operator 
-- LIKE operator 

-- first name starts with M
SELECT *
FROM customers 
WHERE first_name LIKE 'M%'

-- first name ends with n
SELECT *
FROM customers 
WHERE first_name LIKE '%n'

-- first name contains r 
SELECT *
FROM customers 
WHERE first_name LIKE '%r'

-- third position is r 
SELECT *
FROM customers 
WHERE first_name LIKE '__r%'





