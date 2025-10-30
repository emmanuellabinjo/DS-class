-- DDL: Drop tables to ensure a clean slate before recreating them.
DROP TABLE IF EXISTS orders; 
DROP TABLE IF EXISTS products; 
DROP TABLE IF EXISTS customers; 
DROP TABLE IF EXISTS employees;

-- DDL: Create the 'products' table with a primary key and product details.
CREATE TABLE products (
    productid   INT PRIMARY KEY,
    product     TEXT,
    category    TEXT,
    price       NUMERIC
);

-- DDL: Creates the 'employees' table. Note the managerID column is designed to reference employeeID (self-join relationship).
CREATE TABLE employees ( 
employeeID		INT PRIMARY KEY, 
firstName		TEXT, 
lastName		TEXT, 
department		TEXT, 
birthDate		DATE, 
gender			TEXT, 
salary 			INT, 
managerID 		INT
); 

-- DDL: Creates the 'customers' table. Defines basic customer information and a 'score' column.
CREATE TABLE customers ( 
customerID		INT PRIMARY KEY, 
firstName 		TEXT, 
lastName 		TEXT, 
country 		TEXT, 
score 			INT 
); 

-- DDL: Creates the central 'orders' fact table.
-- It defines multiple columns and formalizes three Foreign Key constraints to link to Products, Customers, and Employees.
CREATE TABLE orders (
CREATE TABLE orders (
    orderID        INT PRIMARY KEY,
    productID      INT,
    customerID     INT,
    salesPersonID  INT,
    orderDate      DATE,
    shipDate       DATE,
    orderStatus    TEXT,
    shipAddress    TEXT,
    billAddress    TEXT,
    quantity       INT,
    sales          NUMERIC,
    creationTime   TIMESTAMP WITHOUT TIME ZONE,

-- Constraints are correctly defined inside the CREATE TABLE parentheses.
CONSTRAINT fk_product FOREIGN KEY (productID) REFERENCES 
products(productID), 
CONSTRAINT fk_customer FOREIGN KEY (customerID) REFERENCES 
customers(customerID), 
CONSTRAINT fk_salesperson FOREIGN KEY (salesPersonID) REFERENCES 
employees(employeeID) 
);


-- DQL: Count the total number of records in each of the four main tables.
-- Uses subqueries in the SELECT list to return all counts in a single row.
SELECT  
(SELECT COUNT(*) FROM employees) AS employees_count, 
(SELECT COUNT(*) FROM customers) AS customers_count, 
(SELECT COUNT(*) FROM products) AS products_count, 
(SELECT COUNT(*) FROM orders) AS orders_count;

-- DQL: Retrieve all order details where the sales amount is greater than 10.
 SELECT * 
FROM orders 
WHERE sales > 10;

-- DQL: Retrieve orders where only a single item was ordered AND the order status is 'Delivered'.
SELECT *
FROM orders
WHERE quantity = 1
  AND orderstatus = 'Delivered';

-- DQL: Retrieve all orders where the quantity is NOT less than 10.
SELECT * 
FROM orders  
WHERE NOT quantity < 10;

-- DQL: Retrieve all order details where the sales amount is between 10 and 50 (inclusive).
 SELECT * 
FROM orders  
WHERE sales BETWEEN 10 and 50;

-- DQL: Retrieve all orders where the order status is 'Shipped'.
SELECT *
FROM orders
WHERE orderstatus IN ('Shipped');

-- DQL: Retrieve all employee records where the first name starts with the letter 'F'.
SELECT *
FROM employees
WHERE firstname LIKE 'F%';

-- DQL: Multi-table JOIN (Orders, Products, Customers).
-- Retrieves key details, concatenates customer names, and sorts the result chronologically.
SELECT  
o.orderID, 
o.orderDate, 
p.product, 
CONCAT(c.firstName, ' ', c.lastName) AS CustomerName, 
o.Quantity, 
o.Sales 
FROM orders o 
INNER JOIN products p ON o.ProductID = p.ProductID 
INNER JOIN customers c ON o.CustomerID = c.CustomerID 
ORDER BY o.orderDate, o.orderID;

-- Total sales by product (descending)
 SELECT 
p.productID, 
SUM(o.sales) AS totalsales 
FROM orders o 
INNER JOIN products p ON O.productID = p.productID 
GROUP BY p.productID 
ORDER BY totalsales DESC;

--Top 5 customers by sum of sales
SELECT 
c.customerID, 
c.firstname, 
SUM(o.sales) as totalsales 
FROM customers c 
INNER JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.firstname 
ORDER by TotalSales DESC 
Limit 5; 

-- DDL: Create a VIEW for simplified access to comprehensive order data.
-- The view joins Orders, Products, Customers, and Employees to pull all key details.
CREATE VIEW vw_orders_basic AS
CREATE VIEW vw_orders_basic AS 
SELECT  
o.orderID,  
o.orderDate,  
o.quantity,  
o.sales,  
p.product,  
p.category, 
c.FirstName AS CustomerFirstName,  
c.LastName AS CustomerLastName,  
e.FirstName AS SalespersonFirstName, 
e.LastName AS SalespersonLastName  
FROM orders o 
INNER JOIN  products p ON o.productID = p.productID 
INNER JOIN customers c ON o.customerID = c.customerID 
INNER JOIN employees e on O.salespersonID = e.employeeID; 
SELECT * FROM vw_orders_basic 

-- DML: Insert a new product record into the 'products' table.
INSERT INTO products(productID, product, category, price)
VALUES
(2, 'Shoes', 'Clothing', 60); 

-- DML: Update the 'shipdate' for all orders where it is currently missing (NULL).
-- Sets the ship date to 5 days after the original order date.
UPDATE orders
SET shipdate = orderdate + INTERVAL '5 days' 
WHERE shipdate IS NULL; 

-- DML: Delete the product record with ProductID = 2 from the 'products' table.
DELETE FROM products
WHERE productID = 2;

--DDL: Create an index on the 'orderdate' column of the 'orders' table.
CREATE INDEX index_order_date ON orders (orderdate); 
--By indexing a frequently filtered colun it reduces the need for full table scans and speeding up query executions

