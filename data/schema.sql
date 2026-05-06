-- =========================
-- CREATE DATABASE
-- =========================
CREATE DATABASE customer_revenue_db;
USE customer_revenue_db;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price INT
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================
-- INSERT DATA
-- =========================

-- Customers
INSERT INTO customers VALUES
(1, 'Amit', '2024-01-01'),
(2, 'Sara', '2024-01-02'),
(3, 'John', '2024-01-03'),
(4, 'Priya', '2024-01-04');

-- Orders
INSERT INTO orders VALUES
(201, 1, '2024-01-05'),
(202, 1, '2024-01-06'),
(203, 2, '2024-01-05'),
(204, 3, '2024-01-07'),
(205, 3, '2024-01-08'),
(206, 4, '2024-01-09'),
(207, 1, '2024-02-02'),
(208, 1, '2024-03-05');

-- Products
INSERT INTO products VALUES
(101, 'Electronics', 500),
(102, 'Electronics', 700),
(103, 'Clothing', 300),
(104, 'Clothing', 400);

-- Order Items
INSERT INTO order_items VALUES
(201, 101, 1),
(201, 103, 2),
(202, 102, 1),
(203, 104, 3),
(204, 101, 1),
(205, 102, 2),
(206, 103, 1);



-- =========================
-- ADDITIONAL CUSTOMERS
-- =========================
INSERT INTO customers VALUES
(5, 'Rahul', '2024-01-10'),
(6, 'Neha', '2024-01-12'),
(7, 'Arjun', '2024-01-15'),
(8, 'Meera', '2024-01-18'),
(9, 'Karan', '2024-01-20'),
(10, 'Anjali', '2024-01-25');

-- =========================
-- ADDITIONAL PRODUCTS
-- =========================
INSERT INTO products VALUES
(105, 'Electronics', 900),
(106, 'Clothing', 250),
(107, 'Electronics', 1200),
(108, 'Clothing', 150);

-- =========================
-- ADDITIONAL ORDERS
-- =========================
INSERT INTO orders VALUES
(209, 5, '2024-01-11'),
(210, 5, '2024-02-01'),
(211, 6, '2024-02-05'),
(212, 6, '2024-02-10'),
(213, 7, '2024-02-15'),
(214, 7, '2024-03-01'),
(215, 8, '2024-03-03'),
(216, 9, '2024-03-10'),
(217, 9, '2024-03-15'),
(218, 10, '2024-03-20'),
(219, 10, '2024-03-25'),
(220, 3, '2024-02-12'),
(221, 2, '2024-02-18'),
(222, 4, '2024-03-22');

-- =========================
-- ADDITIONAL ORDER ITEMS
-- =========================
INSERT INTO order_items VALUES
(209, 105, 1),
(209, 106, 2),

(210, 107, 1),

(211, 101, 1),
(211, 103, 1),

(212, 102, 2),

(213, 104, 1),
(213, 108, 3),

(214, 105, 2),

(215, 106, 4),

(216, 101, 1),
(216, 102, 1),

(217, 107, 1),

(218, 103, 2),

(219, 104, 2),
(219, 108, 1),

(220, 105, 1),

(221, 106, 2),

(222, 102, 1),
(222, 103, 1);




SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;