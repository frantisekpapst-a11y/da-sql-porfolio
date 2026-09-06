-- ============================================================
-- CASE STUDY 6
-- Topic: Top Growing Customers (Revenue Change Analysis)
-- ============================================================

-- Goal:
-- Identify customers with the highest revenue growth between periods.

-- For each customer:
-- 1. Calculate previous revenue (LAG)
-- 2. Compute revenue change
-- 3. Filter only growth periods
-- 4. Rank growth across all customers
-- 5. Return top growth events (including ties)

-- Skills practiced:
-- - Window functions (LAG)
-- - CTE (Common Table Expressions)
-- - Filtering intermediate results
-- - RANK() vs ROW_NUMBER()
-- - Handling ties in ranking

-- ============================================================
-- SCHEMA
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

('C', '2024-01-01', 400),
('C', '2024-02-01', 350),
('C', '2024-03-01', 300);

-- ============================================================
-- 1. BASE DATA (previous revenue)
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

-- ============================================================
-- 2. REVENUE METRICS (absolute change)
-- ============================================================

revenue_metrics AS (
    SELECT
        customer,
        date,
        revenue,
        prev_revenue,
        revenue - prev_revenue AS revenue_change
    FROM base
),

-- ============================================================
-- 3. FILTER GROWTH (only positive changes)
-- ============================================================

growth_customers AS (
    SELECT
        customer,
        date,
        revenue,
        prev_revenue,
        revenue_change
    FROM revenue_metrics
    WHERE revenue_change > 0
),

-- ============================================================
-- 4. RANK GROWTH (global ranking)
-- ============================================================

rank_growth AS (
    SELECT
        customer,
        date,
        revenue,
        prev_revenue,
        revenue_change,
        RANK() OVER (
            ORDER BY revenue_change DESC
        ) AS rnk
    FROM growth_customers
)

-- ============================================================
-- 5. FINAL RESULT (top growth events)
-- ============================================================

SELECT
    customer,
    date,
    revenue,
    prev_revenue,
    revenue_change,
    rnk
FROM rank_growth
WHERE rnk = 1
ORDER BY customer, date;


-- ============================================================
-- EXPECTED RESULT
-- ============================================================
--
-- customer | date       | revenue | prev_revenue | revenue_change | rnk
-- -------- | ---------- | ------- | ------------ | -------------- | ---
-- A        | 2024-02-01 | 200     | 100          | 100            | 1
-- B        | 2024-03-01 | 200     | 100          | 100            | 1
--
-- Notes:
-- - Multiple customers can have the same top growth (ties).
-- - RANK() preserves ties, unlike ROW_NUMBER().
-- - First row per customer is excluded (no previous revenue).
-- ============================================================
