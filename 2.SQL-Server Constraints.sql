

					--Primary Key - 
-- A primary key is a column or a group of columns that uniquely identifies each row in a table.

CREATE TABLE events(
event_id INT PRIMARY KEY IDENTITY,
event_name VARCHAR(255) NOT NULL,
event_date DATE NOT NULL);


					--FOREIGN KEY
-- A foreign key is a column or a group of columns in one table that uniquely identifies a row of another table 
CREATE TABLE vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);


CREATE TABLE vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY(group_id)
        REFERENCES vendor_groups(group_id)        
);


INSERT INTO vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');

      SELECT * FROM vendor_groups;


      INSERT INTO vendors(vendor_name, group_id)
      VALUES('ABC Corp', 1);

      --inserting into a group that does not exist will throw an error
      --The INSERT statement conflicted with the FOREIGN KEY constraint "fk_group". The conflict occurred in database "LearnDB", table "dbo.vendor_groups", column 'group_id'.
      INSERT INTO vendors(vendor_name, group_id)
      VALUES('XYZ Corp',4);

      --Referential actions

    --  FOREIGN KEY (foreign_key_columns)
    --REFERENCES parent_table(parent_key_columns)
    --ON UPDATE action 
    --ON DELETE action;


--    Delete actions of rows in the parent table
--If you delete one or more rows in the parent table, you can set one of the following actions:

--ON DELETE NO ACTION: SQL Server raises an error and rolls back the delete action on the row in the parent table.
--ON DELETE CASCADE: SQL Server deletes the rows in the child table that is corresponding to the row deleted from the parent table.
--ON DELETE SET NULL: SQL Server sets the rows in the child table to NULL if the corresponding rows in the parent table are deleted. To execute this action, the foreign key columns must be nullable.
--ON DELETE SET DEFAULT SQL Server sets the rows in the child table to their default values if the corresponding rows in the parent table are deleted. To execute this action, the foreign key columns must have default definitions. Note that a nullable column has a default value of NULL if no default value specified.




                                        --UNIQUE Constraint
--SQL Server UNIQUE constraints allow you to ensure that the data stored in a column, or a group of columns, is unique among the rows in a table.

CREATE TABLE persons(
person_id INT IDENTITY PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(150) UNIQUE
);

INSERT INTO persons(first_name, last_name, email)
VALUES('Brian','Kemboi','kemboi@gmail.com');

--SQL SERVER cannot insert the second time
--Violation of UNIQUE KEY constraint 'UQ__persons__AB6E61648E28A98C'. Cannot insert duplicate key in object 'dbo.persons'. The duplicate key value is (kemboi@gmail.com).
INSERT INTO persons(first_name, last_name, email)
VALUES('Brian','Kemboi','kemboi@gmail.com');


--Different from PRIMARY KEY constraints, UNIQUE constraints allow NULL.
--Moreover, UNIQUE constraints treat the NULL as a regular value, therefore, it only allows one NULL per column.

INSERT INTO persons(first_name, last_name)
VALUES('John','Smith');

--Null is accepeted only once
--Violation of UNIQUE KEY constraint 'UQ__persons__AB6E61648E28A98C'. Cannot insert duplicate key in object 'dbo.persons'. The duplicate key value is (<NULL>).
INSERT INTO persons(first_name, last_name)
VALUES('Lily','Bush');


-- The following example creates a UNIQUE constraint that consists of two columns person_id and skill_id:
CREATE TABLE person_skills (
    id INT IDENTITY PRIMARY KEY,
    person_id int,
    skill_id int,
    updated_at DATETIME,
    UNIQUE (person_id, skill_id)
);


--Add UNIQUE constraints to existing columns using ALTER
DROP TABLE persons;

CREATE TABLE persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
);  


--Alter command
ALTER TABLE persons
ADD CONSTRAINT unique_email UNIQUE(email)

--you can also do this way
ALTER TABLE persons
ADD CONSTRAINT unique_phone UNIQUE(phone)

--insert the data
INSERT INTO persons VALUES('brian', 'kemboi', 'bk@gamil.com', '0700000000');
--doing a repeat
INSERT INTO persons VALUES('brian', 'kemboi', 'bk1@gamil.com', '0700000000');


                            --Delete UNIQUE constraints
ALTER TABLE persons
DROP CONSTRAINT unique_phone;

--No this will  not have an error
INSERT INTO persons VALUES('brian', 'kemboi', 'bk2@gamil.com', '0700000000');



                            --NOT NULL Contraint
--The SQL Server NOT NULL constraints simply specify that a column must not assume the NULL.

DROP TABLE persons;

CREATE TABLE persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);

            --Add NOT NULL constraint to an existing column
ALTER TABLE persons
ALTER COLUMN phone VARCHAR(20) NOT NULL;

--now tray add without the phon number
--insert the data
INSERT INTO persons(first_name, last_name, email, phone) VALUES('brian', 'kemboi', 'bk@gamil.com', '0700000000');


            --Removing NOT NULL constraint

ALTER TABLE persons
ALTER COLUMN phone VARCHAR(20) NULL;