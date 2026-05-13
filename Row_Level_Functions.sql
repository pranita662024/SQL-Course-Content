-- Row level functions 

/* SOL Funtions 
    /      \
   /        \
Single    Multi Row 
Row func    func
*/

-- String Functions ...Manipulation
-- CONCAT

-- Show the list of first_name and country in one column combined 
use MyDatabase

SELECT 
    first_name,
    country,
    CONCAT(first_name,' ',country) AS First_name_country
FROM customers

--Lower Case and Upper Case
-- Convert the first_name to lower case
SELECT 
   LOWER (first_name) AS Lower_first_name,
   UPPER (country) AS Upper_country
FROM customers 

-- trim ..removes leading and trailing spaces

-- Find customers whose first_name contains any leading or trailing spaces 
SELECT 
    first_name,
    LEN(first_name) AS len_name,
    TRIM(first_name) len_trim,
    LEN(first_name) - LEN(TRIM(first_name)) AS Flags 
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name))

-- Replace function

-- Remove '-' from phone number 
SELECT 
    '123-456-7890' AS Phone_No,
    REPLACE('123-456-7890','-','') AS clean_phone

-- Replace .txt to .csv
SELECT 
    'file.txt' AS file_name,
    REPLACE('file.txt','.txt','.csv') AS formatted_file_name

-- LEN() ...finds the length of string
-- Find the len of customers first_name
SELECT 
    first_name,
    LEN(first_name) AS len_first_name
FROM customers

-- LEFT () ..specific no of char from the start 
-- RIGHT () ..specific no of char from the end
-- Syntax LEFT(value,no of char)

-- Retrieve first 2 characters of each first_name
SELECT 
    first_name,
    LEFT(TRIM(first_name),2) AS first_two_char
FROM customers

-- Retrieve last 2 characters of first_name
SELECT 
    first_name,
    RIGHT(first_name,2) AS last_char_first_name
FROM customers

-- Substring 
-- SUBSTRING(Value,Start,Length)

--After the 2nd chars extract 2 chars
SELECT 
    first_name,
   SUBSTRING(TRIM(first_name),3,2)
FROM customers

-- Remove only first char of first_names 

SELECT 
    first_name,
    SUBSTRING(first_name,2,LEN(first_name)) AS sub_name
FROM customers

