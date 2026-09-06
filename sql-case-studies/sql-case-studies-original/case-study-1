-- ============================================================
-- CASE STUDY 1
-- Topic: Customer Analysis
-- ============================================================

-- Goal:
-- Analyze basic customer behavior using orders data.
--
-- Questions answered:
-- 1. Who is the top customer by total spending?
-- 2. How many orders does each customer have?
-- 3. What is the average order value per customer?
-- 4. Which customers have low average order value?
-- 5. Which customers have no orders?
--
-- Skills practiced:
-- - INNER JOIN
-- - LEFT JOIN
-- - GROUP BY
-- - COUNT()
-- - SUM()
-- - AVG()
-- - HAVING
-- - COALESCE()
--
-- Key insight:
-- INNER JOIN returns only customers with orders.
-- LEFT JOIN keeps all customers, including those without orders.
-- ============================================================


-- ============================================================
-- 1. SCHEMA
-- ============================================================

CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Anna'),
(2, 'Petr'),
(3, 'Eva'),
(4, 'Jan');

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(1, 1, 500),
(2, 1, 700),
(3, 2, 300),
(4, 2, 200),
(5, 3, 100);


-- ============================================================
-- 2. TOP CUSTOMER (highest total spending)
-- ============================================================

SELECT
    c.name,
    SUM(o.amount) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 1;


-- Expected result:
--
-- name | total_revenue
-- ---- | -------------
-- Anna | 1200


-- ============================================================
-- 3. CUSTOMER ACTIVITY (number of orders per customer)
-- ============================================================

SELECT
    c.name,
    COUNT(*) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;


-- Expected result:
--
-- name | total_orders
-- ---- | ------------
-- Anna | 2
-- Petr | 2
-- Eva  | 1


-- ============================================================
-- 4. AVERAGE ORDER VALUE PER CUSTOMER
-- ============================================================

SELECT
    c.name,
    ROUND(AVG(o.amount), 0) AS avg_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY avg_order_value DESC;


-- Expected result:
--
-- name | avg_order_value
-- ---- | ---------------
-- Anna | 600
-- Petr | 250
-- Eva  | 100


-- ============================================================
-- 5. LOW VALUE CUSTOMERS (avg order value < 500)
-- ============================================================

SELECT
    c.name,
    ROUND(AVG(o.amount), 0) AS avg_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.name
HAVING AVG(o.amount) < 500
ORDER BY avg_order_value ASC;


-- Expected result:
--
-- name | avg_order_value
-- ---- | ---------------
-- Eva  | 100
-- Petr | 250


-- ============================================================
-- 6. LOW VALUE CUSTOMERS WITH ORDER COUNT
-- ============================================================

SELECT
    c.name,
    COUNT(*) AS total_orders,
    ROUND(AVG(o.amount), 0) AS avg_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.name
HAVING AVG(o.amount) < 500
ORDER BY avg_order_value ASC;


-- Expected result:
--
-- name | total_orders | avg_order_value
-- ---- | ------------ | ---------------
-- Eva  | 1            | 100
-- Petr | 2            | 250


-- ============================================================
-- 7. EXTENDED CUSTOMER REPORT (LEFT JOIN)
-- ============================================================

SELECT
    c.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_revenue,
    ROUND(COALESCE(AVG(o.amount), 0), 0) AS avg_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders ASC;


-- Expected result:
--
-- name | total_orders | total_revenue | avg_order_value
-- ---- | ------------ | ------------- | ---------------
-- Jan  | 0            | 0             | 0
-- Eva  | 1            | 100           | 100
-- Anna | 2            | 1200          | 600
-- Petr | 2            | 500           | 250


-- ============================================================
-- 8. VIP CUSTOMERS (high-value segment)
-- ============================================================

SELECT
    c.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_revenue,
    ROUND(COALESCE(AVG(o.amount), 0), 0) AS avg_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) > 1
   AND AVG(o.amount) > 400
ORDER BY total_orders ASC;


-- Expected result:
--
-- name | total_orders | total_revenue | avg_order_value
-- ---- | ------------ | ------------- | ---------------
-- Anna | 2            | 1200          | 600


-- ============================================================
-- 9. CUSTOMERS WITHOUT ORDERS
-- ============================================================

SELECT
    c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Expected result:
--
-- name
-- ----
-- Jan


-- ============================================================
-- NOTES
-- ============================================================
--
-- - INNER JOIN excludes customers without orders.
-- - LEFT JOIN keeps all customers.
-- - COUNT(o.order_id) is better than COUNT(*) when using LEFT JOIN.
-- - COALESCE() converts NULL values to 0.
-- - HAVING is used for filtering after aggregation.
-- ============================================================
