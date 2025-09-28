--Create a schema
CREATE SCHEMA learn;
GO


                    -- SQL DECEIMAL
CREATE TABLE learn.sql_server_decimal (
    decimal_value DECIMAL (4, 2),
    numeric_value NUMERIC (4, 2)
);



INSERT INTO learn.sql_server_decimal (decimal_value, numeric_value)
VALUES
(10.05, 20.05)

SELECT * FROM learn.sql_server_decimal;


                    --DROP a database table
--DROP TABLE learn.sql_server_decimal;





--INTEGERS

CREATE TABLE learn.sql_server_integer(
bigint_col bigint,
int_col INT,
smallint_col SMALLINT,
tinyint_col tinyint
)

INSERT INTO learn.sql_server_integer(
bigint_col, int_col, smallint_col, tinyint_col
) VALUES (
        9223372036854775807,
		2147483647,
		32767,
		255
);



                    --SQL BITS
CREATE TABLE learn.sql_server_bit(bit_value BIT);

INSERT INTO learn.sql_server_bit(bit_value)
OUTPUT inserted.bit_value
VALUES(1);

INSERT INTO learn.sql_server_bit(bit_value)
OUTPUT inserted.bit_value
VALUES(0);

INSERT INTO learn.sql_server_bit(bit_value)
OUTPUT inserted.bit_value
VALUES('True');

INSERT INTO learn.sql_server_bit(bit_value)
OUTPUT inserted.bit_value
VALUES('False');


                        --SQL CHAR
CREATE TABLE learn.sql_server_char(val CHAR(5));

INSERT INTO learn.sql_server_char (val) VALUES('ABCDE');
INSERT INTO learn.sql_server_char (val) VALUES('ABC');
INSERT INTO learn.sql_server_char (val) VALUES('AB');

--confirming the Length of the CHAR and the space it occupies
SELECT 
val,
LEN(val) len,
DATALENGTH(val) data_length
FROM
learn.sql_server_char;

-- NOTE: You cannot enter a character bigger than 5



                                --SQL NCHAR - To store fixed-length, Unicode character string data in the database
CREATE TABLE learn.sql_server_nchar(val NCHAR(1) NOT NULL);


INSERT INTO learn.sql_server_nchar (val)
VALUES
    (N'あ');


    SELECT
    val,
    len(val) length,
    DATALENGTH(val) data_length
FROM
    learn.sql_server_nchar;



                     --VARCHAR -used to store variable-length, non-Unicode string data.
--Ranges from 1-8000 or represent it as VARCHAR(max)
CREATE TABLE learn.sql_server_varchar(val VARCHAR NOT NULL); --THE DEFAULT STRING LENTH IS ONE

INSERT INTO learn.sql_server_varchar(val) VALUES ('S');


ALTER TABLE learn.sql_server_varchar
ALTER COLUMN val VARCHAR(10) NOT NULL;

INSERT INTO learn.sql_server_varchar(val) VALUES ('SQL Server');

SELECT
val,
LEN(val) len,
DATALENGTH(val) data_length
FROM
learn.sql_server_varchar;



--SQL NVARCHAR -  used to store variable-length, Unicode string data === NVARCHAR(n)
-- Ranges from 1 to 4,000


CREATE TABLE learn.sql_server_nvarchar (
    val NVARCHAR NOT NULL
);

ALTER TABLE learn.sql_server_Nvarchar 
ALTER COLUMN val NVARCHAR (10) NOT NULL;


INSERT INTO learn.sql_server_varchar (val)
VALUES
    (N'こんにちは');


    SELECT
    val,
    LEN(val) len,
    DATALENGTH(val) data_length
FROM
    learn.sql_server_nvarchar;



                    -- DATETIME2 -To store both date and time in the database

--DATETIME2(fractional seconds precision) - fsp is optional ranges from 0-7
CREATE TABLE learn.student_info(
student_id INT PRIMARY KEY IDENTITY,
student_name VARCHAR (50) NOT NULL,
created_at DATETIME2
);

INSERT INTO learn.student_info(student_name, created_at)
VALUES
('Kemboi', GETDATE());

INSERT INTO learn.student_info(student_name, created_at)
VALUES
('Kemboi', '2025-07-23 07:30:20');

--alter to take current time-stamp
ALTER TABLE learn.student_info
ADD CONSTRAINT df_current_time
DEFAULT CURRENT_TIMESTAMP FOR created_at;

--we can now insert into the table without using GETDATE()
INSERT INTO learn.student_info(student_name) VALUES ('Vincent');

--view all the record
SELECT * FROM learn.student_info;



                             -- SQL DATE- To store the date data in the database - YYYY-MM-DD
CREATE TABLE learn.product_prices(
product_id INT PRIMARY KEY IDENTITY,
valid_from DATE NOT NULL,
valid_to DATE NOT NULL,
amount DEC (10, 2) NOT NULL
);


INSERT INTO learn.product_prices(valid_from, valid_to, amount)
VALUES('2025-09-28', '2025-12-24', 400.24);

INSERT INTO learn.product_prices(valid_from, valid_to, amount)
VALUES('2025-08-28', '2025-09-24', 300.24);

INSERT INTO learn.product_prices(valid_from, valid_to, amount)
VALUES('2025-07-28', '2025-07-24', 350.24);

INSERT INTO learn.product_prices(valid_from, valid_to, amount)
VALUES('2025-03-28', '2025-04-24', 278.24);



--selecting by date
SELECT
product_id, valid_from, valid_to, amount

FROM learn.product_prices

WHERE valid_to >=  '2025-07-24'

ORDER BY valid_from ASC;


                    --GUID -A globally unique identifier or GUID is a broader version of this type of ID numbers.
--A GUID is guaranteed to be unique across tables, databases, and even servers.
SELECT 
    NEWID() AS GUID; --creates a unique id


    --GUID as a Primary Key
CREATE TABLE learn.customers(
customer_id UNIQUEIDENTIFIER DEFAULT NEWID(),
first_name NVARCHAR(100) NOT NULL,
last_name NVARCHAR(100) NOT NULL,
email VARCHAR(200) NOT NULL
);

--insert data
INSERT INTO 
    learn.customers(first_name, last_name, email)
VALUES
    ('Brian','Kemboi','kemboi@gmail.com'),
    ('Vincent','Ndungu','vincentgmail.com');


--query the data
SELECT 
customer_id, first_name, last_name, email
FROM learn.customers;


                    --SQL JSON
                --Validate JSON
SELECT ISJSON('{"name": "Joe"}') is_valid_json; --valid json

SELECT ISJSON('[1,2,3,]') is_valid_json; --not valid json

--SQL Server does not offer a built-in JSON type like PostgreSQL and other database systems. 
-- Instead, it uses the NVARCHAR type to store JSON data. 

CREATE TABLE learn.employees(
   id INT IDENTITY PRIMARY KEY,
   info NVARCHAR(MAX) NOT NULL
);



INSERT INTO learn.employees (info)
VALUES 
    ('{"name": "John", "age": 35, "dateOfBirth": "1989-05-15", "skills": ["JavaScript", "SQL", "Python"], "address": {"street": "123 Main St", "city": "New York", "state": "NY", "country": "USA"}}'),
    ('{"name": "Alice", "age": 28, "dateOfBirth": "1996-10-22", "skills": ["Java", "C#", "HTML/CSS"], "address": {"street": "456 Elm St", "city": "Los Angeles", "state": "CA", "country": "USA"}}');

--extract a scalar value from a JSON string
    SELECT 
    JSON_VALUE(info, '$.name') AS Name,
    JSON_VALUE(info, '$.age') AS Age,
    JSON_VALUE(info, '$.dateOfBirth') AS DateOfBirth
FROM 
    learn.employees;

--To extract a JSON object or array from a JSON document, you can use the JSON_QUERY() function:
SELECT 
  JSON_QUERY(info, '$.skills') skills 
FROM 
  learn.employees;
