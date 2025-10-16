-- Day 8 — SQL Growth & Forecast Indicators
-- Author: Shailesh Pawar (Kalkiklyg)

CREATE TABLE monthly_sales (
  month_no INT,
  month VARCHAR(10),
  sales NUMERIC
);

INSERT INTO monthly_sales VALUES
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

-- 1) Compute monthly growth %
SELECT
  month,
  sales,
  ROUND((sales - LAG(sales) OVER (ORDER BY month_no)) * 100.0 / LAG(sales) OVER (ORDER BY month_no), 2) AS growth_percent
FROM monthly_sales;

-- 2) 3-month moving average (smoothing trend)
SELECT
  month,
  ROUND(AVG(sales) OVER (ORDER BY month_no ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg
FROM monthly_sales;


