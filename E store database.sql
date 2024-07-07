-- Create CUSTOMERS Table
CREATE TABLE CUSTOMERS (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    First_name VARCHAR(100) NOT NULL,
    Last_name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone INT(10),
    Address VARCHAR(255)
);

-- Insert Data into CUSTOMERS Table
INSERT INTO CUSTOMERS (customer_id, First_name, Last_name, Email, Phone, Address) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', 1234567890, '123 Main St'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 9876543210, '456 Elm St');

-- Create ORDERS Table
CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY AUTO_INCREMENT,
    CUSTOMER_ID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TOTAL_AMOUNT DECIMAL(10, 2) NOT NULL,
    ITEM VARCHAR(255) NOT NULL,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(customer_id)
);

-- Insert Data into ORDERS Table
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, TOTAL_AMOUNT, ITEM) VALUES
(1, 1, 150.00, 'Laptop'),
(2, 1, 50.00, 'Mouse'),
(3, 2, 200.00, 'Smartphone');
--Performing join operation 
--Selecting data from ORDERS and CUSTOMERS tables, joined on CUSTOMER_ID
SELECT 
    ORDERS.ORDER_ID, 
    CUSTOMERS.First_name, 
    CUSTOMERS.Last_name, 
    ORDERS.OrderDate, 
    ORDERS.TOTAL_AMOUNT, 
    ORDERS.ITEM,
    CUSTOMERS.ADDRESS
FROM 
    ORDERS
INNER JOIN 
    CUSTOMERS 
ON 
    ORDERS.CUSTOMER_ID = CUSTOMERS.customer_id;
--Performing count to see the number of orders placed by each customer
SELECT 
    CUSTOMERS.customer_id,
    CUSTOMERS.First_name,
    CUSTOMERS.Last_name,
    CUSTOMERS.Address,
    COUNT(ORDERS.ORDER_ID) AS ORDER_COUNT
FROM 
    CUSTOMERS
LEFT JOIN 
    ORDERS 
ON 
    CUSTOMERS.customer_id = ORDERS.CUSTOMER_ID
GROUP BY 
    CUSTOMERS.customer_id,
    CUSTOMERS.First_name,
    CUSTOMERS.Last_name,
    CUSTOMERS.Address
ORDER BY 
    CUSTOMERS.customer_id ASC;
-- Create SHIPPING table
CREATE TABLE SHIPPING (
    Shipping_ID INT PRIMARY KEY,
    ORDER_ID INT,
    Shipping_Date DATETIME,
    Shipping_Address VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

-- Insert sample data into SHIPPING table
INSERT INTO SHIPPING (Shipping_ID, ORDER_ID, Shipping_Date, Shipping_Address, Status) VALUES
(1, 1, '2024-07-01 10:00:00', '123 Main St, City, Country', 'Shipped'),
(2, 2, '2024-07-02 11:30:00', '456 Elm St, City, Country', 'In Transit'),
(3, 3, '2024-07-03 09:45:00', '789 Oak St, City, Country', 'Delivered');
--Shows the shipping_id,order_is and status of orders that are in transit and delivered
SELECT
    SHIPPING_ID,
    ORDER_ID,
    STATUS
FROM
    SHIPPING
WHERE
    STATUS = 'In Transit' OR STATUS='Delivered';
--Counts the number of orders in transit
SELECT 
    COUNT(*) AS OrdersInTransit
FROM 
    SHIPPING
WHERE 
    STATUS = 'In Transit';
-- Create SUPPLIERS table
CREATE TABLE SUPPLIERS (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);
-- Insert into SUPPLIERS table with new SupplierID values
INSERT INTO SUPPLIERS (SupplierID, SupplierName, ContactName, Phone, Address) 
VALUES 
    (3, 'Supplier A', 'John Doe', '1234567890', '123 Main St'),
    (4, 'Supplier B', 'Jane Smith', '9876543210', '456 Elm St');

-- Create PRODUCTS table
CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES SUPPLIERS(SupplierID)
);
-- Insert into PRODUCTS table
INSERT INTO PRODUCTS (ProductID, ProductName, SupplierID, UnitPrice) 
VALUES 
    (1, 'LAPTOP', 1, 100.00),
    (2, 'MOUSE', 1, 50.00),
    (3, 'SMARTPHONE', 2, 120.00);

-- Create ORDER DETAILS table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Insert into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES
    (1, 1, 1, 2, 100.00), -- OrderDetailID 1 for OrderID 1, ProductID 1, 2 units at $100 each
    (2, 1, 2, 1, 50.00),  -- OrderDetailID 2 for OrderID 1, ProductID 2, 1 unit at $50 each
    (3, 2, 3, 3, 120.00); -- OrderDetailID 3 for OrderID 2, ProductID 3, 3 units at $120 each
--Retrieve Orders for a Specific Customer
SELECT o.ORDER_ID, o.OrderDate, p.ProductName, od.Quantity, od.Price
FROM ORDERS o
JOIN OrderDetails od ON o.ORDER_ID = od.OrderID
JOIN PRODUCTS p ON od.ProductID = p.ProductID
JOIN CUSTOMERS c ON o.CUSTOMER_ID = c.customer_id
WHERE c.First_name = 'John' AND c.Last_name = 'Doe';
--Calculate Total Sales Revenue
SELECT SUM(od.Quantity * od.Price) AS TotalRevenue
FROM OrderDetails od;
-- List Products with Suppliers
SELECT p.ProductID, p.ProductName, s.SupplierName
FROM PRODUCTS p
JOIN SUPPLIERS s ON p.SupplierID = s.SupplierID;
--Update Order Details
UPDATE OrderDetails
SET Quantity = 4, Price = 110.00
WHERE OrderDetailID = 1;
--Delete an Order
DELETE FROM ORDERS
WHERE ORDER_ID = 1;
--Insert New Customer
INSERT INTO CUSTOMERS (First_name, Last_name, Email, Phone, Address)
VALUES ('Emily', 'Johnson', 'emily.johnson@example.com', '5551234567', '789 Oak St');
--Calculate Total Amount Spent by Customers

