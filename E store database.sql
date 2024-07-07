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
