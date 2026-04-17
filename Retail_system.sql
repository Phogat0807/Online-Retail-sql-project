CREATE DATABASE retail_system;
USE retail_system;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN','CUSTOMER') DEFAULT 'CUSTOMER',
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_id) 
    REFERENCES categories(category_id)
    ON DELETE SET NULL
);
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
    ON DELETE CASCADE
);
CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
    total_amount DECIMAL(10,2),
    
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    method ENUM('UPI','CARD','COD'),
    status ENUM('SUCCESS','FAILED','PENDING') DEFAULT 'PENDING',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
INSERT INTO users (name, email, password, role)
VALUES 
('Nikhil', 'nikhil@gmail.com', '12345', 'CUSTOMER'),
('Ashish', 'ashish@gmail.com', 'ashish123', 'ADMIN');

INSERT INTO categories (category_name)
VALUES ('Electronics'), ('Clothing');

INSERT INTO products (product_name, category_id, price, stock)
VALUES 
('Laptop', 1, 50000, 10),
('Smartphone', 1, 20000, 20),
('T-Shirt', 2, 500, 50);


INSERT INTO cart (user_id) VALUES (1);

INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES (1, 1, 1), (1, 2, 2);

INSERT INTO orders (user_id, total_amount)
VALUES (1, 90000);

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 50000),
(1, 2, 2, 20000);

UPDATE products SET stock = stock - 1 WHERE product_id = 1;
UPDATE products SET stock = stock - 2 WHERE product_id = 2;
INSERT INTO payments (order_id, amount, method, status)
VALUES (1, 90000, 'UPI', 'SUCCESS');

SELECT u.name, o.order_id, p.product_name, oi.quantity
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT u.name, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.name;


CREATE VIEW sales_report AS
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

SELECT * FROM sales_report;
