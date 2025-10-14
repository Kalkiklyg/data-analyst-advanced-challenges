-- Day 5 — Data Transformation & Insight Extraction

CREATE TABLE sales_performance (
  region VARCHAR(50),
  salesperson VARCHAR(50),
  revenue INT,
  target INT
);

INSERT INTO sales_performance VALUES
('North','A',12000,10000),
('South','B',18000,17000),
('East','C',15000,16000),
('West','D',21000,19000),
('North','E',16000,15000),
('South','F',22000,20000),
('East','G',20000,19000),
('West','H',25000,24000);

-- 1️⃣ Add Performance Calculation
SELECT *, ROUND((revenue / target)*100, 2) AS performance_percent,
  CASE WHEN (revenue >= target) THEN 'Achieved' ELSE 'Pending' END AS status
FROM sales_performance;

-- 2️⃣ Regional Average Performance
SELECT region, AVG((revenue / target)*100) AS avg_performance
FROM sales_performance
GROUP BY region
ORDER BY avg_performance DESC;
