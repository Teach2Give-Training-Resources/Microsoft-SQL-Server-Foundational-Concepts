DROP TABLE Customers;




--create a table customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    street NVARCHAR(100),
    city NVARCHAR(50),
    zip_code VARCHAR(10)
);


--insert some sampl data
INSERT INTO Customers (customer_id, first_name, last_name, phone, email, street, city, zip_code)
VALUES
(1, 'Brian', 'Kemboi', '0712345678', 'brian.kemboi@example.com', 'Moi Avenue', 'Nairobi', '00100'),
(2, 'Daisy', 'Munga', '0723456789', 'daisy.munga@example.com', 'Kenyatta Street', 'Eldoret', '30100'),
(3, 'Kevin', 'Omondi', '0734567890', 'kevin.omondi@example.com', 'Mama Ngina Drive', 'Mombasa', '80100'),
(4, 'Grace', 'Wanjiku', '0745678901', 'grace.wanjiku@example.com', 'Tom Mboya Street', 'Kisumu', '40100'),
(5, 'John', 'Mwangi', '0756789012', 'john.mwangi@example.com', 'Kimathi Street', 'Nakuru', '20100'),
(6, 'Sarah', 'Njeri', '0767890123', 'sarah.njeri@example.com', 'Uhuru Highway', 'Thika', '01000'),
(7, 'David', 'Otieno', '0778901234', 'david.otieno@example.com', 'Westlands Road', 'Nairobi', '00606'),
(8, 'Mary', 'Achieng', '0789012345', 'mary.achieng@example.com', 'Moi Avenue', 'Kisii', '40200'),
(9, 'Peter', 'Mutua', '0790123456', 'peter.mutua@example.com', 'Ronald Ngala Street', 'Machakos', '90100'),
(10, 'Lucy', 'Chebet', '0711122334', 'lucy.chebet@example.com', 'Kericho Highway', 'Kericho', '20200'),
(11, 'Samuel', 'Kiptoo', '0722233445', 'samuel.kiptoo@example.com', 'Kapkatet Road', 'Bomet', '20400'),
(12, 'Alice', 'Nyambura', '0733344556', 'alice.nyambura@example.com', 'Kahawa Sukari Ave', 'Ruiru', '00232'),
(13, 'Michael', 'Kariuki', '0744455667', 'michael.kariuki@example.com', 'Westlands Road', 'Nairobi', '00606'),
(14, 'Janet', 'Wairimu', '0755566778', 'janet.wairimu@example.com', 'Westlands Road', 'Nairobi', '00606'),
(15, 'Patrick', 'Maina', '0766677889', 'patrick.maina@example.com', 'Westlands Road', 'Nairobi', '00606'),
(16, 'Ruth', 'Cherono', '0777788990', 'ruth.cherono@example.com', 'Kenyatta Street', 'Eldoret', '30100'),
(17, 'George', 'Otieno', '0788899001', 'george.otieno@example.com', 'Kenyatta Street', 'Eldoret', '30100'),
(18, 'Irene', 'Naliaka', '0799900112', 'irene.naliaka@example.com', 'Westlands Road', 'Nairobi', '00606'),
(19, 'Collins', 'Barasa', '0711223344', 'collins.barasa@example.com', 'Kenyatta Street', 'Eldoret', '30100'),
(20, 'Esther', 'Wambui', '0722334455', 'esther.wambui@example.com', 'Moi Avenue', 'Nairobi', '00100');


--Updating single row
UPDATE Customers
SET phone = '0799999999'
WHERE customer_id = 5;


--Updating multiple rows
UPDATE Customers
SET email = 'lucy.chebet@newmail.com',
    city = 'Nairobi'
WHERE customer_id = 10;

--Update Many Rows at Once
UPDATE Customers
SET city = 'Uasin Gishu'
WHERE city = 'Eldoret';


--Deleting Rows from a Table
DELETE FROM Customers
WHERE customer_id = 20;

--Delete Multiple Rows
DELETE FROM Customers
WHERE street = 'Kenyatta Street';

--Delete All Rows (but keep table structure)
DELETE FROM Customers;
--TRUNCATE DOES THE SAME ALSO:
TRUNCATE TABLE Customers;


                    --select all the customers
SELECT * FROM Customers;


                        --where clause
--To filter rows based on one or more conditions, you use a WHERE clause.   
--Order of execution -> FROM->WHERE->SELECT
SELECT  *  FROM Customers  WHERE street = 'Kenyatta Street'; 

                           --Sorting rows using the ORDER BY clause
--To sort rows in a result set based, you use the ORDER BY clause
--Order of execution -> FROM -> WHERE ->  SELECT -> ORDER BY
SELECT * FROM Customers 
WHERE street = 'Westlands Road' 
ORDER BY first_name;


                            --ORDER BY ASC
SELECT * FROM Customers 
WHERE street = 'Westlands Road' 
ORDER BY first_name DESC;


                --Sort a result set by multiple columns
SELECT city, first_name, last_name
FROM Customers 
ORDER BY 
city, first_name;

                -- Sort a result set by multiple columns in different orders
SELECT city, first_name, last_name
FROM Customers 
ORDER BY 
city DESC,
first_name ASC;

--Grouping rows into groups
--Order of execution -> FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY
SELECT city,COUNT(*)
FROM customers
WHERE street = 'Westlands Road'
GROUP BY city
ORDER BY city;

-- Filtering groups using the HAVING clause
SELECT
    city,COUNT (*)
FROM
    customers
WHERE
    street = 'Westlands Road'
GROUP BY
    city
HAVING
    COUNT (*) > 3
ORDER BY
    city;





                                    -- OFFSET FETCH
 --   It’s important to note that you must use the OFFSET and FETCH clauses with the ORDER BY clause. Otherwise, you encounter an error.
 SELECT city, first_name, last_name
FROM customers
ORDER BY city;

--to skip the first 6 rows and return the rest:
 SELECT city, first_name, last_name
 FROM Customers
 ORDER BY city
 OFFSET 6 ROWS;

 --TO SKIP THE FIRST 7 AND SELECT 5 customers you use both OFFSET and FETCH clauses as follows:

  SELECT city, first_name, last_name
 FROM Customers
 ORDER BY city
  OFFSET 7 ROWS
  FETCH NEXT 5 ROWS ONLY;

                            --SELECT TOP
--The SELECT TOP clause allows you to limit the rows or percentage of rows returned by a query. 
--It is useful when you want to retrieve a specific number of rows from a large table.

  SELECT TOP 10
  first_name, last_name, city
  FROM Customers
  ORDER BY first_name DESC;


                            --Using SELECT TOP to return a percentage of rows
SELECT TOP 80 PERCENT
  first_name, last_name
  FROM Customers
  ORDER BY customer_id ASC;



                                --SELECT DISTINCT clause
--The following statement uses the SELECT statement to retrieve all cities of all customers from the customers tables:
SELECT 
  city , street
FROM 
  customers 
ORDER BY 
  city;


 -- To retrieve only distinct cities, you can use the SELECT DISTINCT keyword as follows:
 SELECT 
  DISTINCT city 
FROM 
  customers 
ORDER BY 
  city;


                                        --Using SELECT DISTINCT with multiple columns
SELECT 
  DISTINCT city, street 
FROM 
  Customers;



                                    --SQL Server AND operator
--This will return the Eldoret customers we inserted on Kenyatta Street.
SELECT customer_id, first_name, last_name, city, street
FROM Customers
WHERE city = 'Eldoret'
  AND street = 'Kenyatta Street';


                        --Using OR
--Get customers who are either in Nairobi OR in Mombasa. If either condition is true, the row is included.
SELECT customer_id, first_name, last_name, city
FROM Customers
WHERE city = 'Nairobi'
   OR city = 'Mombasa';


--Using IN

-- Get customers from a list of cities (Nairobi, Eldoret, Kisumu).
--WHERE city = 'Nairobi' OR city = 'Eldoret' OR city = 'Kisumu'

   SELECT customer_id, first_name, last_name, city
FROM Customers
WHERE city IN ('Nairobi', 'Eldoret', 'Kisumu');



                            --BETWEEN
-- Get customers with IDs between 5 and 12 (inclusive).
-- Eqiovalent to: WHERE customer_id >= 5 AND customer_id <= 12;

SELECT customer_id, first_name, last_name, city
FROM Customers
WHERE customer_id BETWEEN 5 AND 12;


                    --LIKE
--Names starting with J
--Finds all customers whose first name begins with J
SELECT customer_id, first_name, last_name, city
FROM Customers
WHERE first_name LIKE 'J%';

--The % means “any characters before or after.”
SELECT customer_id, first_name, email
FROM Customers
WHERE email LIKE '%mutua%';

--Last names ending with i
SELECT customer_id, first_name, last_name
FROM Customers
WHERE last_name LIKE '%i';

--Two-character match
SELECT customer_id, first_name, last_name
FROM Customers
WHERE first_name LIKE '_a%';

--CUSTOMER WITH LASTNAME starting with k and ends with i
SELECT
customer_id, first_name, last_name
FROM 
Customers
WHERE
last_name LIKE 'K%i'



--SQL Server Alias
--To assign a column or an expression a temporary name during the query execution, you use a column alias.


SELECT
    first_name,
    last_name
FROM
    customers
ORDER BY
    first_name;

    --The folllowing can be written as:
    SELECT first_name + ' ' + last_name AS FullName, 
       city AS CustomerCity
FROM Customers;

--You can give a table a short alias name for easier reference.
SELECT c.first_name, c.last_name, c.city
FROM Customers AS c
WHERE c.city = 'Nairobi';

