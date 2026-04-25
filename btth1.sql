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
('Le Van C', '0900000003', 'Da Nang', 'VIP'),
('Pham Thi D', '0900000004', 'HCM', 'Normal'),
('Hoang Van E', '0900000005', 'Hue', 'Normal'),
('Do Thi F', '0900000006', 'Can Tho', 'Normal'),
('Vu Van G', '0900000007', 'Quang Ninh', 'Normal');

INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop', 'Electronics', 15000000, 10),
('Mouse', 'Electronics', 200000, 50),
('Keyboard', 'Electronics', 500000, 30),
('T-Shirt', 'Fashion', 150000, 100),
('Jeans', 'Fashion', 400000, 60),
('Jacket', 'Fashion', 800000, 0),
('Sofa', 'Home', 7000000, 5),
('Table', 'Home', 2000000, 15),
('Chair', 'Home', 500000, 40),
('Lamp', 'Home', 300000, 25);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-04-01', 'completed'),
(2, '2026-04-02', 'completed'),
(3, '2026-04-03', 'cancelled'),
(4, '2026-04-04', 'completed'),
(5, '2026-04-05', 'completed');

INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES
(1, 1, 1, 15000000),
(1, 2, 2, 400000),
(1, 3, 1, 500000),
(2, 4, 2, 300000),
(2, 5, 1, 400000),
(3, 6, 1, 800000),
(3, 7, 1, 7000000),
(4, 8, 1, 2000000),
(4, 9, 2, 1000000),
(5, 10, 2, 600000),
(5, 2, 1, 200000),
(5, 3, 1, 500000);

UPDATE products 
SET stock = stock - 5 
WHERE id = 1;

SELECT * FROM products;