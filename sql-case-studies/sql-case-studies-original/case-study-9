-- ============================================================
-- CASE STUDY 9
-- Topic: Latest Customer Revenue Status
-- ============================================================

-- Goal:
-- For each customer, identify the latest known revenue record and compare it
-- with the previous record.
--
-- For each customer return:
-- 1. latest date
-- 2. current revenue
-- 3. previous revenue
-- 4. revenue change
-- 5. customer status
--
-- Skills practiced:
-- - LAG()
-- - ROW_NUMBER()
-- - CASE WHEN
-- - CTE pipeline
-- - latest row per customer
-- - business status classification
--
-- Key insight:
-- First calculate previous values and revenue changes,
-- then rank rows by date to keep only the latest record per customer.
-- ============================================================


-- ============================================================
-- 1. SCHEMA
-- ============================================================

CREATE TABLE sales (
    customer VARCHAR(50),
    date DATE,
    revenue INT
);

INSERT INTO sales VALUES
('A', '2024-01-01', 100),
('A', '2024-02-01', 200),
('A', '2024-03-01', 300),

('B', '2024-01-01', 500),
('B', '2024-03-01', 100),
('B', '2024-04-01', 200),

('C', '2024-02-01', 50),
('C', '2024-03-01', 70);


-- ============================================================
-- 2. FINAL SOLUTION
-- ============================================================

WITH base AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(revenue) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_revenue
    FROM sales
),

revenue_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_revenue,
        revenue - prev_revenue AS revenue_change
    FROM base
),

status_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_revenue,
        revenue_change,
        CASE
            WHEN prev_revenue IS NULL THEN 'new'
            WHEN revenue_change > 0 THEN 'growth'
            WHEN revenue_change = 0 THEN 'no_change'
            ELSE 'decline'
        END AS status,
        ROW_NUMBER() OVER (
            PARTITION BY customer
            ORDER BY date DESC
        ) AS rn
    FROM revenue_metrics
)

SELECT
    customer,
    date,
    revenue,
    prev_revenue,
    revenue_change,
    status
FROM status_metrics
WHERE rn = 1
ORDER BY
    status,
    revenue_change DESC,
    customer;


-- ============================================================
-- 3. EXPECTED RESULT
-- ============================================================
--
-- customer | date       | revenue | prev_revenue | revenue_change | status
-- -------- | ---------- | ------- | ------------ | -------------- | -------
-- A        | 2024-03-01 | 300     | 200          | 100            | growth
-- B        | 2024-04-01 | 200     | 100          | 100            | growth
-- C        | 2024-03-01 | 70      | 50           | 20             | growth
--
-- Notes:
-- - LAG() gets the previous revenue per customer.
-- - ROW_NUMBER() keeps only the latest record per customer.
-- - CASE classifies customer status based on revenue change.
-- - In a real dataset, customer_id should be used for stable ordering
--   and to avoid issues with duplicate customer names.
-- ============================================================
