-- ============================================================
-- CASE STUDY 7
-- Topic: Customer Value Analysis
-- ============================================================

-- Goal:
-- For each customer:
-- 1. Calculate total revenue
-- 2. Assign customer segment
-- 3. Rank customers by revenue
--
-- Skills practiced:
-- - LEFT JOIN
-- - GROUP BY
-- - COALESCE
-- - CASE WHEN
-- - RANK()
-- - Subquery
-- - CTE
--
-- Key insight:
-- The same business problem can be solved using either a subquery
-- or a CTE. Both approaches are valid. CTE is usually more readable
-- when the query becomes more complex.
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
(2, 1, 300),
(3, 2, 700),
(4, 2, 200),
(5, 2, 100);


-- ============================================================
-- 2. SOLUTION 1: SUBQUERY
-- ============================================================

SELECT
    customer_id,
    name,
    total_revenue,
    CASE
        WHEN total_revenue > 900 THEN 'top'
        WHEN total_revenue > 500 THEN 'medium'
        ELSE 'low'
    END AS segment,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS rnk
FROM (
    SELECT
        c.customer_id,
        c.name,
        COALESCE(SUM(o.amount), 0) AS total_revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.name
) t
ORDER BY
    rnk,
    customer_id;


-- ============================================================
-- 3. SOLUTION 2: CTE
-- ============================================================

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.name,
        COALESCE(SUM(o.amount), 0) AS total_revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.name
)

SELECT
    customer_id,
    name,
    total_revenue,
    CASE
        WHEN total_revenue > 900 THEN 'top'
        WHEN total_revenue > 500 THEN 'medium'
        ELSE 'low'
    END AS segment,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS rnk
FROM customer_revenue
ORDER BY
    rnk,
    customer_id;


-- ============================================================
-- 4. EXPECTED RESULT
-- ============================================================
--
-- customer_id | name | total_revenue | segment | rnk
-- ----------- | ---- | ------------- | ------- | ---
-- 2           | Petr | 1000          | top     | 1
-- 1           | Anna | 800           | medium  | 2
-- 3           | Eva  | 0             | low     | 3
-- 4           | Jan  | 0             | low     | 3
--
-- Notes:
-- - LEFT JOIN keeps customers without orders.
-- - COALESCE converts NULL revenue to 0.
-- - CASE assigns a business segment based on total revenue.
-- - RANK() preserves ties (Eva and Jan share rank 3).
-- ============================================================
