CREATE DATABASE shop_management;
USE shop_management;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    customer_type ENUM('Normal', 'VIP') DEFAULT 'Normal'
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('completed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE SET NULL
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO customers (full_name, phone, address, customer_type) VALUES
('Nguyen Van A', '0900000001', 'Ha Noi', 'VIP'),
('Tran Thi B', '0900000002', 'Hai Phong', 'Normal'),
('Nguyen Van C', '0900000003', 'Da Nang', 'VIP'),
('Pham Thi D', '0900000004', 'Ha Noi', 'Normal'),
('Hoang Van E', '0900000005', 'Hue', 'Normal'),
('Le Thi F', '0900000006', 'Can Tho', 'Normal'),
('Vu Van G', '0900000007', 'Quang Ninh', 'Normal'),
('Do Van H', '0900000008', 'Hai Duong', 'Normal');

INSERT INTO products (product_name, category, price, stock) VALUES
('Coca Cola', 'Nước giải khát', 10000, 100),
('Pepsi', 'Nước giải khát', 12000, 80),
('Trà xanh', 'Nước giải khát', 15000, 50),
('Nước cam', 'Nước giải khát', 30000, 20),
('Red Bull', 'Nước giải khát', 20000, 0),
('Laptop', 'Electronics', 15000000, 10),
('Mouse', 'Electronics', 200000, 50),
('T-Shirt', 'Fashion', 150000, 100),
('Sofa', 'Home', 7000000, 5);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-04-01', 'completed'),
(2, '2026-04-02', 'completed'),
(3, '2026-04-03', 'cancelled'),
(4, '2026-04-04', 'completed'),
(5, '2026-04-05', 'completed');

INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES
(1, 1, 2, 20000),
(1, 2, 1, 12000),
(2, 3, 3, 45000),
(3, 4, 1, 30000),
(4, 6, 1, 15000000),
(5, 7, 2, 400000);

UPDATE products
SET stock = stock - 5
WHERE id = 1;

SELECT * FROM products;

SELECT *
FROM products
WHERE category = 'Nước giải khát' AND price BETWEEN 10000 AND 50000 AND stock > 0;

SELECT *
FROM customers
WHERE full_name LIKE 'Nguyen%' OR address = 'Ha Noi';

SELECT o.id AS order_id,o.order_date,o.status,c.full_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

SELECT c.full_name,o.order_date,p.product_name,od.quantity,p.price AS unit_price
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN customers c ON o.customer_id = c.id
JOIN products p ON od.product_id = p.id;

SELECT *
FROM customers
WHERE id NOT IN (
    SELECT customer_id FROM orders WHERE customer_id IS NOT NULL
);
