									
									--CREATE DATABASE
CREATE DATABASE TestDb;

--list all dbs
SELECT
name
FROM master.sys.databases
ORDER BY
name;

--using stored procdures
EXEC sp_databases;



									-- DROP DB
DROP DATABASE IF EXISTS TestDb; --Cannot drop database "TestDb" because it is currently in use.



--CREATE SCHEMA
CREATE SCHEMA customer;

GO

--DROP SCHEMA
DROP SCHEMA IF EXISTS customer;

CREATE TABLE customer.visits(
visit_id INT PRIMARY KEY IDENTITY(1,1),
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
visited_at DATETIME,
phone VARCHAR(20),
store_id INT NOT NULL
)


									--IDENTITY
CREATE SCHEMA hr;

--create table
CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('John','Doe', 'M'),('Jane','Doe','F');

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jane','Doe','F');

SELECT * FROM hr.person;

--Resetting the identity column value
DELETE FROM hr.person;

DBCC CHECKIDENT ('hr.Person', RESEED, 0);

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jhoan','Smith','F');





--DROPPING A TABLE
DROP TABLE IF EXISTS hr.person




--TRUNCATING A TABLE

CREATE TABLE customer_groups (
    group_id INT PRIMARY KEY IDENTITY,
    group_name VARCHAR (50) NOT NULL
);

INSERT INTO customer_groups (group_name)
VALUES
    ('Intercompany'),
    ('Third Party'),
    ('One time');


--To delete all rows from the customer_groups table, you use the DELETE statement as follows:
DELETE FROM customer_groups;

-- Show data
SELECT * FROM customer_groups;


--Using TRUNCATE
INSERT INTO customer_groups (group_name)
VALUES
    ('Intercompany'),
    ('Third Party'),
    ('One time');   

TRUNCATE TABLE customer_groups;

-- Show data
SELECT * FROM customer_groups;



                                --ALTER Table ADD Column
CREATE TABLE quotations (
    quotation_no INT IDENTITY PRIMARY KEY,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL
);

--Alter table, Add single column
ALTER TABLE quotations
ADD description VARCHAR(255) NOT NULL;

--Alter table - Add more columns
ALTER TABLE quotations
ADD 
amount DECIMAL (10,2) NOT NULL,
customer_name VARCHAR(50) NOT NULL;




                                            --SQL Server ALTER TABLE ALTER COLUMN
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Age INT NULL,
    Email VARCHAR(50) NULL,
    Salary DECIMAL(10,2) NULL
);


-- Make Age mandatory
ALTER TABLE Employees
ALTER COLUMN Age INT NOT NULL;

--change salary precision
ALTER TABLE Employees
ALTER COLUMN Salary DECIMAL(12,2);

--Rename a column(FullName-> EmployeeName)
EXEC sp_rename 'Employees.FullName', 'EmployeeName', 'COLUMN';


--Add a new column:
ALTER TABLE Employees
ADD PhoneNumber VARCHAR(20) NULL;

--Drop a column
ALTER TABLE Employees
DROP COLUMN PhoneNumber;


                                    -- Creating temporary tables
CREATE TABLE #TempEmployees (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Age INT NULL
);


INSERT INTO #TempEmployees (EmployeeID, FullName, Age)
VALUES (1, 'Alice Johnson', 30),
       (2, 'Bob Smith', 28);


ALTER TABLE #TempEmployees
ADD Email VARCHAR(100) NULL;

ALTER TABLE #TempEmployees
ALTER COLUMN Age SMALLINT NULL;


DROP TABLE #TempEmployees;


