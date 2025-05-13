-- Guide to Normalization (1NF to 2NF to 3NF)

-- STEP 0: Create the Database
CREATE DATABASE NormalizationDB;

USE NormalizationDB;

-- STEP 1: Achieve 1NF (First Normal Form)
-- Original table: ProductDetail (OrderID, CustomerName, Products)
-- Issue: Products column contains multiple values (violates 1NF)

-- Optional: Original structure (for context)
-- CREATE TABLE ProductDetail (
--     OrderID INT,
--     CustomerName VARCHAR(100),
--     Products VARCHAR(255)
-- );

-- Question 1: Achieving 1NF
-- In the table above, the Products column contains multiple values, which violates 1NF.
-- Write an SQL query to transform this table into 1NF, ensuring that each row represents a single product for an order.

-- Solution: Create a new table with atomic values for products:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert transformed data
-- Each product gets its own row
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Laptop');
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (103, 'Emily Clark', 'Phone');

-- STEP 2: Achieve 2NF (Second Normal Form)
-- From 1NF: ProductDetail_1NF (OrderID, CustomerName, Product)
-- Issue: CustomerName is dependent only on OrderID, not the whole primary key (OrderID + Product)

-- Question 2: Achieving 2NF
-- In the table above, the CustomerName column depends on OrderID (a partial dependency), which violates 2NF.
-- Write an SQL query to transform this table into 2NF by removing partial dependencies. Ensure that each non-key column fully depends on the entire primary key.

-- Solution: Decompose into two tables

-- Orders table (OrderID -> CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- OrderDetails table (OrderID, Product)
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- STEP 3: Achieve 3NF (Third Normal Form)
-- If any transitive dependency exists (e.g. Product -> ProductType -> something else), move them to separate tables
-- This sample doesn't show transitive dependencies directly, so if Product is atomic, no changes needed

-- Optional: If you want to separate Product information
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);

-- Final structure summary:
-- 1. Orders (OrderID, CustomerName)
-- 2. OrderDetails (OrderID, Product)
-- 3. Products (optional, for more product metadata)

-- You can now use JOINs to query related data efficiently
