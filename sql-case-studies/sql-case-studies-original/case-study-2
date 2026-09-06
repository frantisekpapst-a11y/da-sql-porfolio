-- ============================================================
-- CASE STUDY 2
-- Topic: Product & Customer Analysis
-- ============================================================

-- Goal:
-- Analyze product sales and customer revenue across multiple tables.
--
-- Questions answered:
-- 1. How many units were sold per product?
-- 2. What is the total revenue per product?
-- 3. What is the total revenue per customer?
-- 4. How much revenue did each customer generate by category?
-- 5. What is the top category per customer?
--
-- Skills practiced:
-- - JOIN
-- - LEFT JOIN
-- - GROUP BY
-- - SUM()
-- - COALESCE()
-- - CTE
-- - MAX + JOIN pattern
--
-- Key insight:
-- Product revenue is calculated from quantity * price.
-- LEFT JOIN keeps customers without orders.
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

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

INSERT INTO products VALUES
(1, 'Running Shoes', 'Shoes', 100),
(2, 'Winter Hat', 'Hats', 200),
(3, 'Travel Bag', 'Bags', 300);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO orders VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 3),
(4, 3, 2, 2);


-- ============================================================
-- 2. TOTAL QUANTITY SOLD PER PRODUCT
-- ============================================================

SELECT
   p.product_name,
   SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p
   ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;


-- Expected result:
--
-- product_name  | total_quantity
-- ------------- | --------------
-- Travel Bag    | 3
-- Winter Hat    | 3
-- Running Shoes | 2


-- ============================================================
-- 3. TOTAL REVENUE PER PRODUCT
-- ============================================================

SELECT
   p.product_name,
   SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
   ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- Expected result:
--
-- product_name  | total_revenue
-- ------------- | -------------
-- Travel Bag    | 900
-- Winter Hat    | 600
-- Running Shoes | 200


-- ============================================================
-- 4. TOTAL REVENUE PER CUSTOMER
-- ============================================================

SELECT
   c.name,
   COALESCE(SUM(o.quantity * p.price), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
   ON c.customer_id = o.customer_id
LEFT JOIN products p
   ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;


-- Expected result:
--
-- name | total_revenue
-- ---- | -------------
-- Petr | 900
-- Eva  | 400
-- Anna | 400
-- Jan  | 0


-- ============================================================
-- 5. REVENUE BY CATEGORY PER CUSTOMER
-- ============================================================

SELECT
   c.name,
   COALESCE(p.category, 'none') AS category,
   COALESCE(SUM(o.quantity * p.price), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
   ON c.customer_id = o.customer_id
LEFT JOIN products p
   ON o.product_id = p.product_id
GROUP BY
   c.name,
   COALESCE(p.category, 'none')
ORDER BY
   c.name,
   category;


-- Expected result:
--
-- name | category | total_revenue
-- ---- | -------- | -------------
-- Anna | Hats     | 200
-- Anna | Shoes    | 200
-- Eva  | Hats     | 400
-- Jan  | none     | 0
-- Petr | Bags     | 900


-- ============================================================
-- 6. TOP CATEGORY PER CUSTOMER
-- ============================================================
--
-- This version uses MAX + JOIN.
-- It returns all top categories in case of a tie.
--

WITH revenue_by_category AS (
    SELECT
       c.name,
       COALESCE(p.category, 'none') AS category,
       COALESCE(SUM(o.quantity * p.price), 0) AS total_revenue
    FROM customers c
    LEFT JOIN orders o
       ON c.customer_id = o.customer_id
    LEFT JOIN products p
       ON o.product_id = p.product_id
    GROUP BY
       c.name,
       COALESCE(p.category, 'none')
)

SELECT
   r.name,
   r.category AS top_category,
   r.total_revenue
FROM revenue_by_category r
JOIN (
    SELECT
       name,
       MAX(total_revenue) AS max_revenue
    FROM revenue_by_category
    GROUP BY name
) m
   ON r.name = m.name
  AND r.total_revenue = m.max_revenue
ORDER BY
   r.total_revenue DESC,
   r.name;


-- Expected result:
--
-- name | top_category | total_revenue
-- ---- | ------------ | -------------
-- Petr | Bags         | 900
-- Eva  | Hats         | 400
-- Anna | Hats         | 200
-- Anna | Shoes        | 200
-- Jan  | none         | 0
--
-- Notes:
-- - Anna has a tie between Hats and Shoes.
-- - MAX + JOIN returns all top categories in case of a tie.
-- - Jan has no orders, so category is set to 'none' and revenue is 0.
-- ============================================================

