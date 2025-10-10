-- 1) Total income and total expenses (company/customer level)
SELECT
    SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) AS total_income,
    SUM(CASE WHEN amount < 0 THEN -amount ELSE 0 END) AS total_expenses,
    SUM(amount) AS net_balance
FROM transactions;

-- 2) Category-wise total (net)
SELECT category, SUM(amount) AS net_amount
FROM transactions
GROUP BY category
ORDER BY net_amount;

-- 3) Top 3 expense categories (largest negative sums)
SELECT category, SUM(-amount) AS expense_total
FROM transactions
WHERE amount < 0
GROUP BY category
ORDER BY expense_total DESC
LIMIT 3;

-- 4) Net balance per customer (if multiple customers)
SELECT customer_id,
       SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) AS income,
       SUM(CASE WHEN amount < 0 THEN -amount ELSE 0 END) AS expenses,
       SUM(amount) AS net_balance
FROM transactions
GROUP BY customer_id;