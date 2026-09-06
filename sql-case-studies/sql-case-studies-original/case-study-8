-- ============================================================
-- CASE STUDY 8
-- Topic: Customer Activity Gaps
-- ============================================================

-- Goal:
-- Identify customers with inactivity gaps between transactions.
--
-- Steps:
-- 1. Find previous activity date per customer
-- 2. Calculate number of days since previous activity
-- 3. Classify rows as:
--    - new
--    - active
--    - inactive_gap
-- 4. Rank the largest inactivity gaps
-- 5. Return the biggest inactivity gap overall (including ties)
--
-- Skills practiced:
-- - LAG()
-- - DATEDIFF()
-- - CASE WHEN
-- - CTE
-- - RANK()
--
-- Key insight:
-- Window functions can be used not only for revenue analysis,
-- but also for customer activity and inactivity tracking.
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
('A', '2024-04-01', 150),

('B', '2024-01-01', 300),
('B', '2024-03-01', 100),
('B', '2024-04-01', 200),

('C', '2024-02-01', 500);


-- ============================================================
-- 2. BASE STEP: PREVIOUS ACTIVITY DATE
-- ============================================================

WITH base AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(date) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_date
    FROM sales
)

SELECT *
FROM base;


-- ============================================================
-- 3. DAYS SINCE PREVIOUS ACTIVITY
-- ============================================================

WITH base AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(date) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_date
    FROM sales
),
days_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        DATEDIFF(date, prev_date) AS days_since_prev
    FROM base
)

SELECT *
FROM days_metrics;


-- ============================================================
-- 4. STATUS CLASSIFICATION
-- ============================================================

WITH base AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(date) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_date
    FROM sales
),
days_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        DATEDIFF(date, prev_date) AS days_since_prev
    FROM base
),
status_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        days_since_prev,
        CASE
            WHEN prev_date IS NULL THEN 'new'
            WHEN days_since_prev > 45 THEN 'inactive_gap'
            ELSE 'active'
        END AS status
    FROM days_metrics
)

SELECT *
FROM status_metrics;


-- ============================================================
-- 5. FINAL SOLUTION: BIGGEST INACTIVE GAP
-- ============================================================

WITH base AS (
    SELECT
        customer,
        date,
        revenue,
        LAG(date) OVER (
            PARTITION BY customer
            ORDER BY date
        ) AS prev_date
    FROM sales
),
days_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        DATEDIFF(date, prev_date) AS days_since_prev
    FROM base
),
status_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        days_since_prev,
        CASE
            WHEN prev_date IS NULL THEN 'new'
            WHEN days_since_prev > 45 THEN 'inactive_gap'
            ELSE 'active'
        END AS status
    FROM days_metrics
),
ranked_gaps AS (
    SELECT
        customer,
        date,
        revenue,
        prev_date,
        days_since_prev,
        status,
        RANK() OVER (
            ORDER BY days_since_prev DESC
        ) AS rnk
    FROM status_metrics
    WHERE status = 'inactive_gap'
)

SELECT
    customer,
    date,
    revenue,
    prev_date,
    days_since_prev,
    status,
    rnk
FROM ranked_gaps
WHERE rnk = 1
ORDER BY customer, date;


-- ============================================================
-- 6. EXPECTED RESULT
-- ============================================================
--
-- customer | date       | revenue | prev_date  | days_since_prev | status       | rnk
-- -------- | ---------- | ------- | ---------- | --------------- | ------------ | ---
-- A        | 2024-04-01 | 150     | 2024-02-01 | 60              | inactive_gap | 1
-- B        | 2024-03-01 | 100     | 2024-01-01 | 60              | inactive_gap | 1
--
-- Notes:
-- - Customer C has only one record, so it is classified as 'new'.
-- - RANK() preserves ties, so both A and B are returned.
-- - CASE uses multiple columns in conditions:
--   prev_date and days_since_prev.
-- ============================================================
