

----SQL-----

Build base sales table and export-style aggregates
-- Save this as day4_queries.sql

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT,
    region VARCHAR(80),
    amount INT,
    order_date DATE
);

INSERT INTO sales (order_id, customer_id, region, amount, order_date) VALUES
(1011,11,'Pune',25000,'2025-03-11'),
(1021,21,'Mumbai',15000,'2025-05-03'),
(1033,33,'Nagpur',28000,'2025-04-01'),
(1054,54,'Nashik',52000,'2025-08-12'),
(1066,11,'Pune',12000,'2025-09-10'),
(1077,21,'Mumbai',30000,'2025-09-15'),
(1088,33,'Nagpur',30000,'2025-09-20');

-- 1) Sales by region (export-ready)
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 2) Top customers by total spend
SELECT customer_id, SUM(amount) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 3) Monthly summary
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(amount) AS total_sales,
       AVG(amount) AS avg_order,
       COUNT(*) AS orders_count
FROM sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
