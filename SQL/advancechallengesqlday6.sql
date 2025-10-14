-- Day 6 — Visualizing Insights in SQL

CREATE TABLE monthly_performance (
    month VARCHAR(20),
    revenue INT,
    expenses INT
);

INSERT INTO monthly_performance VALUES
('Jan',12000,8000),
('Feb',18000,12000),
('Mar',17000,11000),
('Apr',24000,15000),
('May',26000,14000),
('Jun',23000,16000);

-- 1️⃣ Calculate profit for each month
SELECT month, revenue, expenses, (revenue - expenses) AS profit
FROM monthly_performance;

-- 2️⃣ Find the best-performing month by profit
SELECT month, (revenue - expenses) AS profit
FROM monthly_performance
ORDER BY profit DESC
LIMIT 1;

-- 3️⃣ Compute average revenue and expense trend
SELECT 
  ROUND(AVG(revenue)) AS avg_revenue, 
  ROUND(AVG(expenses)) AS avg_expense
FROM monthly_performance;
