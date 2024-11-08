CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(50)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(100),
    price NUMERIC(10, 2),
    stock_quantity INTEGER
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date TIMESTAMP,
    status VARCHAR(20) 
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER
);

INSERT INTO customers (city, state) VALUES 
('Almaty', 'Almaty Region'),
('Shymkent', 'South Kazakhstan Region'), 
('Astana', 'Akmola Region');

INSERT INTO products (category, price, stock_quantity) VALUES
    ('Cosmetics', 100.00, 25),
    ('Clothing', 300.00, 20),
    ('Furniture', 500.00, 10);

INSERT INTO orders (customer_id, order_date, status) VALUES
    (1, '2024-01-31', 'completed'),
    (2, '2024-05-11', 'completed'),
    (1, '2024-02-03', 'pending');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 2), 
    (1, 2, 3), 
    (2, 1, 1), 
    (2, 3, 5); 

SELECT 
    p.category,
    c.state,
    SUM(p.price * oi.quantity) AS total_revenue
FROM 
    order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    o.status = 'completed'
GROUP BY 
    p.category, c.state;
