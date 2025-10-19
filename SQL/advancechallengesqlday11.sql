-- Day 11 — Correlation and Root-Cause Analysis in SQL

CREATE TABLE business_metrics (
  id INT,
  marketing_spend INT,
  revenue INT,
  customer_satisfaction FLOAT
);

INSERT INTO business_metrics VALUES
(1,100,180,4.1),(2,90,160,3.8),(3,110,190,4.5),(4,80,150,3.7),
(5,120,200,4.6),(6,70,140,3.4),(7,130,210,4.8),(8,85,155,3.9),
(9,115,195,4.4),(10,95,170,4.0),(11,125,205,4.7),(12,105,185,4.2);

-- Correlation approximation using covariance/variance
SELECT 
  (AVG(marketing_spend * revenue) - AVG(marketing_spend) * AVG(revenue)) /
  (STDDEV_POP(marketing_spend) * STDDEV_POP(revenue)) AS corr_mkt_rev,
  (AVG(customer_satisfaction * revenue) - AVG(customer_satisfaction) * AVG(revenue)) /
  (STDDEV_POP(customer_satisfaction) * STDDEV_POP(revenue)) AS corr_cs_rev
FROM business_metrics;
