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
