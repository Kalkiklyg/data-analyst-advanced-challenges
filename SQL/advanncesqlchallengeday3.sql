-- Day 3 SQL: sales + customers example with window functions--

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  order_id INT PRIMARY KEY,
  customer_id INT,
  amount INT,
  order_date DATE
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  region VARCHAR(50)
);

-- Insert sample data
INSERT INTO sales (order_id, customer_id, amount, order_date) VALUES
(1011, 11, 25000, '2025-03-11'),
(1021, 21, 15000, '2025-05-03'),
(1033, 33, 28000, '2025-04-01'),
(1054, 54, 52000, '2025-08-12'),
(1066, 11, 12000, '2025-09-10'),
(1077, 21, 30000, '2025-09-15');

-- 1) Total sales by region (join)
SELECT c.region, SUM(s.amount) AS total_sales
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- 2) Top 3 customers by total spending (aggregate)
SELECT s.customer_id, SUM(s.amount) AS total_spent
FROM sales s
GROUP BY s.customer_id
ORDER BY total_spent DESC
LIMIT 3;

-- 3) Rank customers by spending using window functions (showing tie-handling)
SELECT
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_by_spend,
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS dense_rank_by_spend
FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM sales
    GROUP BY customer_id
) t
ORDER BY total_spent DESC;

-- 4) For each region, find the customer with maximum total spend (using window)
SELECT region, customer_id, total_spent
FROM (
    SELECT
        c.region,
        s.customer_id,
        SUM(s.amount) AS total_spent,
        ROW_NUMBER() OVER (PARTITION BY c.region ORDER BY SUM(s.amount) DESC) AS rn
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.region, s.customer_id
) t
WHERE rn = 1
ORDER BY region;

-- 5) Company-wide 2nd highest single order amount (example without LIMIT)
SELECT MAX(amount) AS second_highest_order
FROM sales
WHERE amount < (SELECT MAX(amount) FROM sales);