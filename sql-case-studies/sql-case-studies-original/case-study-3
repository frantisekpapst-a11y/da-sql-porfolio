-- =========================================================
-- CASE STUDY 3
-- Topic: Top category per customer + customer segmentation
-- =========================================================
--
-- Goal:
-- For each customer find:
-- 1. Top product category (highest revenue)
-- 2. Revenue in that category
-- 3. Total customer revenue
-- 4. Customer segment (top / medium / low)
--
-- Skills practiced:
-- - JOIN vs LEFT JOIN
-- - GROUP BY
-- - SUM()
-- - COALESCE()
-- - CASE WHEN
-- - ROW_NUMBER()
-- - Subqueries
--
-- Key insight:
-- Top category and total customer revenue are two different calculations,
-- so they should be prepared in separate intermediate steps.
-- =========================================================


-- =========================================================
-- 1. SCHEMA
-- =========================================================

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
    customer_id INT
);

INSERT INTO orders VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 1),
(3, 3, 3),
(4, 2, 2);

CREATE TABLE products (
    product_id INT,
    category VARCHAR(50),
    price INT
);

INSERT INTO products VALUES
(1, 'Shoes', 100),
(2, 'Hats', 200),
(3, 'Bags', 300);


-- =========================================================
-- 2. STEP 1: REVENUE PER CUSTOMER AND CATEGORY
-- =========================================================
--
-- We first calculate revenue for each customer in each category.
-- Revenue = quantity * price
--

SELECT
    c.customer_id,
    c.name,
    p.category,
    SUM(oi.quantity * p.price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.name,
    p.category;


-- =========================================================
-- 3. STEP 2: TOP CATEGORY PER CUSTOMER
-- =========================================================
--
-- We rank categories inside each customer by revenue
-- and keep only the first one.
--

SELECT
    customer_id,
    name,
    category,
    total_revenue
FROM (
    SELECT
        customer_id,
        name,
        category,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY total_revenue DESC
        ) AS rn
    FROM (
        SELECT
            c.customer_id,
            c.name,
            p.category,
            SUM(oi.quantity * p.price) AS total_revenue
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        JOIN order_items oi
            ON o.order_id = oi.order_id
        JOIN products p
            ON oi.product_id = p.product_id
        GROUP BY
            c.customer_id,
            c.name,
            p.category
    ) x
) t
WHERE rn = 1;


-- =========================================================
-- 4. STEP 3: TOTAL CUSTOMER REVENUE + SEGMENT
-- =========================================================
--
-- Here we calculate total revenue per customer.
-- We use LEFT JOIN because we want to keep customers
-- even if they have no orders.
--

SELECT
    c.customer_id,
    c.name,
    COALESCE(SUM(oi.quantity * p.price), 0) AS total_revenue_customer,
    CASE
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 1000 THEN 'top'
        WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 500 THEN 'medium'
        ELSE 'low'
    END AS segment
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.name;


-- =========================================================
-- 5. FINAL SOLUTION
-- =========================================================
--
-- We combine:
-- - top category per customer
-- - total revenue per customer
-- - customer segment
--

SELECT
    seg.customer_id,
    seg.name,
    top.category AS top_category,
    top.total_revenue AS top_category_revenue,
    seg.total_revenue_customer,
    seg.segment
FROM
(
    SELECT
        c.customer_id,
        c.name,
        COALESCE(SUM(oi.quantity * p.price), 0) AS total_revenue_customer,
        CASE
            WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 1000 THEN 'top'
            WHEN COALESCE(SUM(oi.quantity * p.price), 0) > 500 THEN 'medium'
            ELSE 'low'
        END AS segment
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.name
) seg
LEFT JOIN
(
    SELECT
        customer_id,
        name,
        category,
        total_revenue
    FROM (
        SELECT
            customer_id,
            name,
            category,
            total_revenue,
            ROW_NUMBER() OVER (
                PARTITION BY customer_id
                ORDER BY total_revenue DESC
            ) AS rn
        FROM (
            SELECT
                c.customer_id,
                c.name,
                p.category,
                COALESCE(SUM(oi.quantity * p.price), 0) AS total_revenue
            FROM customers c
            JOIN orders o
                ON c.customer_id = o.customer_id
            JOIN order_items oi
                ON o.order_id = oi.order_id
            JOIN products p
                ON oi.product_id = p.product_id
            GROUP BY
                c.customer_id,
                c.name,
                p.category
        ) x
    ) t
    WHERE rn = 1
) top
    ON seg.customer_id = top.customer_id
ORDER BY seg.total_revenue_customer DESC;


-- =========================================================
-- 6. EXPECTED RESULT
-- =========================================================
--
-- customer_id | name | top_category | top_category_revenue | total_revenue_customer | segment
-- ----------- | ---- | ------------ | -------------------- | ---------------------- | -------
-- 2           | Petr | Bags         | 900                  | 900                    | medium
-- 1           | Anna | Shoes        | 300                  | 500                    | low
-- 3           | Eva  | Hats         | 400                  | 400                    | low
-- 4           | Jan  | NULL         | NULL                 | 0                      | low
--
-- Notes:
-- - Jan has no orders, so total revenue is 0.
-- - Jan has no top category, therefore top_category is NULL.
-- - top_category_revenue is also NULL because there is no matching row
--   in the top-category subquery.
-- =========================================================

