-- ============================================================
-- CASE STUDY 5
-- Topic: Customer Revenue Trends & Growth Analysis
-- ============================================================
--
-- Goal:
-- Analyze customer revenue over time and identify:
-- 1. Revenue per period
-- 2. Previous revenue
-- 3. Absolute change
-- 4. Percentage change
-- 5. Customer status (new / growth / decline)
--
-- Skills practiced:
-- - Window functions (LAG)
-- - PARTITION BY + ORDER BY
-- - Calculations in SQL
-- - CASE WHEN
-- - CTE (Common Table Expression)
--
-- Key insight:
-- LAG() helps compare the current row with the previous period,
-- which is useful for trend analysis and growth tracking.
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
('A', '2024-03-01', 150),

('B', '2024-01-01', 300),
('B', '2024-02-01', 100),
('B', '2024-03-01', 200),

('C', '2024-02-01', 500);


-- ============================================================
-- 2. STEP 1: PREVIOUS REVENUE
-- ============================================================
--
-- Use LAG() to get the previous revenue value
-- for each customer ordered by date.
--

WITH prev_revenue AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(revenue) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_revenue
    FROM sales
)

SELECT *
FROM prev_revenue;


-- ============================================================
-- 3. STEP 2: REVENUE METRICS
-- ============================================================
--
-- Based on previous revenue, calculate:
-- - absolute change
-- - percentage change
-- - status (new / growth / decline)
--

WITH prev_revenue AS (
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
        revenue - prev_revenue AS revenue_change,
        ROUND((revenue - prev_revenue) * 100.0 / prev_revenue, 2) AS pct_change,
        CASE
            WHEN prev_revenue IS NULL THEN 'new'
            WHEN revenue > prev_revenue THEN 'growth'
            ELSE 'decline'
        END AS status
    FROM prev_revenue
)

SELECT *
FROM revenue_metrics;


-- ============================================================
-- 4. FINAL SOLUTION
-- ============================================================
--
-- Final clean version.
--

WITH prev_revenue AS (
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
        revenue - prev_revenue AS revenue_change,
        ROUND((revenue - prev_revenue) * 100.0 / prev_revenue, 2) AS pct_change,
        CASE
            WHEN prev_revenue IS NULL THEN 'new'
            WHEN revenue > prev_revenue THEN 'growth'
            ELSE 'decline'
        END AS status
    FROM prev_revenue
)

SELECT
    customer,
    date,
    revenue,
    prev_revenue,
    revenue_change,
    pct_change,
    status
FROM revenue_metrics
ORDER BY customer, date;


-- ============================================================
-- 5. EXPECTED RESULT
-- ============================================================
--
-- customer | date       | revenue | prev_revenue | revenue_change | pct_change | status
-- -------- | ---------- | ------- | ------------ | -------------- | ---------- | -------
-- A        | 2024-01-01 | 100     | NULL         | NULL           | NULL       | new
-- A        | 2024-02-01 | 200     | 100          | 100            | 100.00     | growth
-- A        | 2024-03-01 | 150     | 200          | -50            | -25.00     | decline
-- B        | 2024-01-01 | 300     | NULL         | NULL           | NULL       | new
-- B        | 2024-02-01 | 100     | 300          | -200           | -66.67     | decline
-- B        | 2024-03-01 | 200     | 100          | 100            | 100.00     | growth
-- C        | 2024-02-01 | 500     | NULL         | NULL           | NULL       | new
--
-- Notes:
-- - First row per customer has no previous period, so LAG() returns NULL.
-- - Customer C is marked as 'new' because there is no previous record.
-- ============================================================

