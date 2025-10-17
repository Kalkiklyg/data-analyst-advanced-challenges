-- Day 8 — SQL Growth Forecast
CREATE TABLE sales_trends (
  month_no INT,
  month VARCHAR(10),
  revenue INT
);

INSERT INTO sales_trends VALUES
(1,'Jan',12000),
(2,'Feb',13500),
(3,'Mar',12800),
(4,'Apr',15000),
(5,'May',16500),
(6,'Jun',15500),
(7,'Jul',17200),
(8,'Aug',18000),
(9,'Sep',17500),
(10,'Oct',18500),
(11,'Nov',19800),
(12,'Dec',21000);

-- 1️⃣ Month-over-Month Growth %
SELECT 
  month,
  revenue,
  ROUND((revenue - LAG(revenue) OVER (ORDER BY month_no)) * 100.0 / LAG(revenue) OVER (ORDER BY month_no), 2) AS growth_percent
FROM sales_trends;

-- 2️⃣ 3-Month Moving Average (Smooth Trend)
SELECT 
  month,
  ROUND(AVG(revenue) OVER (ORDER BY month_no ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg
FROM sales_trends;


