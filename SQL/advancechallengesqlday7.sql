-- Day 7 — End-to-End Case Study (SQL)
-- Script: day7_case_study.sql

-- 1) Create raw table (simulate ingestion)
CREATE TABLE raw_orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  region VARCHAR(50),
  amount_text VARCHAR(50),
  order_date_text VARCHAR(50),
  notes VARCHAR(255)
);

INSERT INTO raw_orders (order_id, customer_id, region, amount_text, order_date_text, notes) VALUES
(1001,11,'Pune','25,000','2025-03-11','ok'),
(1002,21,'Mumbai','15,000','2025/05/03',''),
(1003,11,NULL,'NaN','11-04-2025','refund'),
(1004,33,'Nagpur','28,000','2025-04-01','ok'),
(1005,21,'Mumbai','15,000','2025-05-03',''),
(1006,44,'Pune','52000','2025-08-12','late'),
(1007,11,'Pune','26000','2025-09-01','ok'),
(1008,33,'Nagpur','NaN','2025-04-30','ok'),
(1009,44,'Pune','18000','2025-07-01','discount'),
(1010,55,'Mumbai','23000','2025-06-15','');

-- 2) Clean and normalize amount: remove commas, NULL if not numeric
-- This uses standard SQL functions; syntax may vary by DB (use the appropriate function for your DB)
-- Example uses PostgreSQL style regexp_replace and to_number; adjust if needed.

-- Create cleaned table
CREATE TABLE cleaned_orders AS
SELECT
  order_id,
  customer_id,
  COALESCE(region, CASE WHEN customer_id=11 THEN 'Pune' WHEN customer_id=21 THEN 'Mumbai'
                        WHEN customer_id=33 THEN 'Nagpur' WHEN customer_id=44 THEN 'Pune'
                        WHEN customer_id=55 THEN 'Mumbai' END) AS region,
  NULLIF(regexp_replace(amount_text, ',', ''), 'NaN')::NUMERIC AS amount,
  to_date(regexp_replace(order_date_text, '/', '-'), 'YYYY-MM-DD') AS order_date,
  notes,
  CASE WHEN lower(notes) LIKE '%refund%' THEN TRUE ELSE FALSE END AS is_refund
FROM raw_orders
WHERE NULLIF(regexp_replace(amount_text, ',', ''), 'NaN') IS NOT NULL;

-- 3) Make refund amounts negative
UPDATE cleaned_orders
SET amount = -abs(amount)
WHERE is_refund = TRUE;

-- 4) KPIs using SQL
-- Total revenue (sum of positive amounts)
SELECT SUM(amount) FILTER (WHERE amount>0) AS total_revenue,
       SUM(amount) FILTER (WHERE amount<0) AS total_refunds,
       SUM(amount) AS net_revenue
FROM cleaned_orders;

-- 5) Revenue by region
SELECT region, SUM(amount) AS net_amount
FROM cleaned_orders
GROUP BY region
ORDER BY net_amount DESC;

-- 6) Top customers by net spend
SELECT customer_id, SUM(amount) AS net_amount
FROM cleaned_orders
GROUP BY customer_id
ORDER BY net_amount DESC
LIMIT 5;

-- 7) Monthly trend (extract YYYY-MM)
SELECT to_char(order_date, 'YYYY-MM') AS month, SUM(amount) AS net_amount
FROM cleaned_orders
GROUP BY to_char(order_date, 'YYYY-MM')
ORDER BY month;
