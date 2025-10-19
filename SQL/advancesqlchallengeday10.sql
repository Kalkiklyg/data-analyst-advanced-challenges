-- Day 10 — SQL Anomaly Detection using Mean and StdDev

CREATE TABLE monthly_transactions (
  month VARCHAR(10),
  transactions INT
);

INSERT INTO monthly_transactions VALUES
('Jan',420),('Feb',450),('Mar',460),('Apr',490),('May',505),
('Jun',495),('Jul',1000),('Aug',520),('Sep',510),('Oct',530),
('Nov',545),('Dec',555);

-- Calculate mean and std deviation
WITH stats AS (
  SELECT 
    AVG(transactions) AS avg_val,
    STDDEV_POP(transactions) AS std_val
  FROM monthly_transactions
)
SELECT 
  m.month,
  m.transactions,
  ROUND((m.transactions - s.avg_val)/s.std_val, 2) AS z_score,
  CASE WHEN ABS((m.transactions - s.avg_val)/s.std_val) > 2 THEN 'Anomaly' ELSE 'Normal' END AS status
FROM monthly_transactions m
CROSS JOIN stats s;
