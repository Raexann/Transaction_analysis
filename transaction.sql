USE transactions_db;

--- Basic analysis
--- Total Transactions
SELECT COUNT(*) AS total_transactions
FROM transactions_cleaned;

--- Date range for transactions
SELECT 
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM transactions_cleaned;

--- Data range for age
SELECT 
    MIN(age) AS start_age,
    MAX(age) AS end_age
FROM transactions_cleaned;

--- Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM transactions_cleaned;

--- Unique merchants
SELECT COUNT(DISTINCT merchant_id) AS unique_merchants
FROM transactions_cleaned;

--- Unique State
SELECT COUNT(DISTINCT merchant_state) AS unique_states
FROM transactions_cleaned;

--- Unknown merchant values
SELECT COUNT(*) AS missing_merchants
FROM transactions_cleaned
WHERE merchant_id = 'Unknown';

--- Unique movement
SELECT DISTINCT movement
FROM transactions_cleaned;

--- Transaction analysis
--- total transaction value
SELECT SUM(amount) AS total_transaction_value
FROM transactions_cleaned;

--- Average transaction value
SELECT AVG(amount) AS avg_transaction_value
FROM transactions_cleaned;

--- Transaction range 
SELECT MIN(amount) AS highest, MAX(amount) AS lowest
FROM transactions_cleaned;

--- Average Transaction per customer
SELECT COUNT(*)/COUNT(DISTINCT customer_id)AS avg_txn_per_customer
FROM transactions_cleaned;

--- Time based analysis
--- Transaction per month
SELECT year, month,
COUNT(*) AS transactions,
SUM(amount) AS total_spending FROM transactions_cleaned
GROUP BY year, month
ORDER BY year, month;

--- Transaction per weekday
SELECT weekday,
COUNT(*) AS transactions,
SUM(amount) AS spending FROM transactions_cleaned
GROUP BY weekday
ORDER BY spending DESC;

--- Highest month by transactions
SELECT month,
COUNT(*) AS transactions
FROM transactions_cleaned
GROUP BY month
ORDER BY transactions DESC
LIMIT 1;

--- Highest month by spending
SELECT month,
SUM(amount) AS total_spending
FROM transactions_cleaned
GROUP BY month
ORDER BY total_spending DESC
LIMIT 1;

--- Credit vs Debit
SELECT movement,
COUNT(*) AS transactions,
SUM(amount) AS total_amount,
AVG(amount) AS avg_amount
FROM transactions_cleaned
GROUP BY movement;

--- Customer Analysis
--- Top 10 customers by spending
SELECT customer_id, 
SUM(amount) AS total_spent FROM transactions_cleaned
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

--- Top 10 Frequent customers by transaction amount
SELECT customer_id,
COUNT(*) AS transaction_count
FROM transactions_cleaned
GROUP BY customer_id
ORDER BY transaction_count DESC
LIMIT 10;

--- Average spend per customer
SELECT SUM(amount)/COUNT(DISTINCT customer_id)
AS avg_spend_per_customer
FROM transactions_cleaned;

--- Merchant analysis
--- Top 10 merchants by revenue
SELECT merchant_id,
SUM(amount) AS revenue FROM transactions_cleaned
GROUP BY merchant_id
ORDER BY revenue DESC
LIMIT 10;

--- Average revenue per merchant
SELECT 
SUM(amount)/COUNT(DISTINCT merchant_id)
AS avg_revenue_per_merchant
FROM transactions_cleaned;

--- Transactions by State
SELECT merchant_state,
SUM(amount) AS total_spending FROM transactions_cleaned
GROUP BY merchant_state
ORDER BY total_spending DESC;

--- Demographic analysis
SELECT gender,
SUM(amount) AS total_spent,
AVG(amount) AS avg_spent
FROM transactions_cleaned
GROUP BY gender;

--- Age group spending
SELECT 
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    SUM(amount) AS spending
FROM transactions_cleaned
GROUP BY age_group
ORDER BY spending DESC;

--- Card presence Analysis
SELECT card_present_flag,
COUNT(*) AS transactions,
SUM(amount) AS total_spent
FROM transactions_cleaned
GROUP BY card_present_flag;

--- Balance Analysis
SELECT AVG(balance) AS avg_balance
FROM transactions_cleaned;

--- Highest balance
SELECT MAX(balance) AS highest_balance
FROM transactions_cleaned;

--- Customers with high balance
SELECT customer_id,
MAX(balance) AS max_balance FROM transactions_cleaned
GROUP BY customer_id
ORDER BY max_balance DESC
LIMIT 10;











