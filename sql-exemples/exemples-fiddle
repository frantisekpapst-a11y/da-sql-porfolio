# sql_fiddle_examples.sql

**Schema (MySQL v5.7)**

    CREATE TABLE orders (
        order_id INTEGER,
        customer_id INTEGER,
        amount INTEGER
    );
    
    CREATE TABLE customers (
        customer_id INTEGER,
        name TEXT
    );
    
    -- INSERT DATA
    INSERT INTO orders VALUES (1, 1, 500);
    INSERT INTO orders VALUES (2, 2, 300);
    INSERT INTO orders VALUES (3, 1, 700);
    
    INSERT INTO customers VALUES (1, 'Jan');
    INSERT INTO customers VALUES (2, 'Eva');

-- JOIN + AGGREGATION
SELECT customers.name, AVG(amount)
FROM orders
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customers.name
ORDER BY AVG(amount) DESC;

SELECT
   customers.name,
   COUNT(*) AS total_orders
FROM orders
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customers.name
HAVING COUNT(*) > 1;

SELECT
   customers.name,
   SUM(amount) AS total_revenue
FROM orders
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customers.name
HAVING total_revenue > 1000;

SELECT
   customers.name,
   AVG(amount) AS avg_revenue
FROM orders
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customers.name
HAVING AVG(amount) > 400;

SELECT
   customers.name,
   COUNT(*) AS total_orders,
   AVG(amount) AS avg_revenue
FROM orders
JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customers.name
HAVING COUNT(*) > 1 AND AVG(amount) > 400;

SELECT
   c.name,
   SUM(o.amount) AS total_revenue_over500
FROM orders o
JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.name
HAVING SUM(o.amount) > 500;

SELECT
   c.name,
   AVG(o.amount) AS avg_revenue
FROM orders o
JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.name
HAVING COUNT(*) > 1 AND AVG(o.amount) > 400;

SELECT
   c.name,
   COUNT(*) AS total_orders,
   SUM(o.amount) AS total_revenue
FROM orders o
JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.name
HAVING total_orders > 1 AND total_revenue > 800
ORDER BY total_revenue DESC;

SELECT
   c.name,
   COUNT(*) AS total_orders
FROM orders o
JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.name
HAVING total_orders >= 2;

---

**Query #1**

    SELECT
       c.name,
       SUM(o.amount) AS total_revenue
    FROM orders o
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.name
    ORDER BY SUM(o.amount) DESC
    LIMIT 1;

| name | total_revenue |
| ---- | ------------- |
| Jan  | 1200          |

---
**Query #2**

    SELECT
       c.name,
       COUNT(*) AS total_orders
    FROM orders o
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.name
    ORDER BY total_orders DESC;

| name | total_orders |
| ---- | ------------ |
| Jan  | 2            |
| Eva  | 1            |

---
**Query #3**

    SELECT
       c.name,
       ROUND(AVG(o.amount), 0) AS avg_order_value
    FROM orders o
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.name
    ORDER BY avg_order_value DESC;

| name | avg_order_value |
| ---- | --------------- |
| Jan  | 600             |
| Eva  | 300             |

---
**Query #4**

    SELECT
       c.name,
       COUNT(*) AS total_orders,
       ROUND(AVG(o.amount), 0) AS avg_order_value
    FROM orders o
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.name
    HAVING COUNT(*) > 1 AND ROUND(AVG(o.amount), 0) > 400;

| name | total_orders | avg_order_value |
| ---- | ------------ | --------------- |
| Jan  | 2            | 600             |

**Schema (MySQL v5.7)**

    CREATE TABLE orders (
            order_id INTEGER,
            customer_id INTEGER,
            amount INTEGER
        );
        
        CREATE TABLE customers (
            customer_id INTEGER,
            name TEXT
        );
        
        -- INSERT DATA
        INSERT INTO orders VALUES (1, 1, 500);
        INSERT INTO orders VALUES (2, 2, 300);
        INSERT INTO orders VALUES (3, 1, 700);
        
        INSERT INTO customers VALUES (1, 'Jan');
        INSERT INTO customers VALUES (2, 'Eva');
        INSERT INTO customers VALUES (3, 'Petr');

---

**Query #1**

    SELECT
       c.name,
       COUNT(o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o on c.customer_id = o.customer_id
    GROUP BY c.name
    HAVING COUNT(o.order_id) <= 1
    ORDER BY total_orders ASC;

| name | total_orders |
| ---- | ------------ |
| Petr | 0            |
| Eva  | 1            |

---
**Query #2**

    SELECT
       c.name,
       COUNT(o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o on c.customer_id = o.customer_id AND o.amount > 400
    GROUP BY c.name
    HAVING COUNT(o.order_id) <= 1
    ORDER BY total_orders ASC;

| name | total_orders |
| ---- | ------------ |
| Eva  | 0            |
| Petr | 0            |

---
**Query #2**

    SELECT
       c.name
    FROM customers c
    LEFT JOIN orders o on c.customer_id = o.customer_id
    WHERE o.order_id IS NULL;

| name |
| ---- |
| Petr |

---

**Query #3**

    SELECT
       c.name,
       COUNT(*) AS total_orders
    FROM orders o
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.name
    HAVING MAX(o.amount) <= 500
    ORDER BY c.name ASC;

| name | total_orders |
| ---- | ------------ |
| Eva  | 1            |

---
    
**Schema (MySQL v8)**

    CREATE TABLE sales (
        customer VARCHAR(50),
        category VARCHAR(50),
        revenue INT
    );
    
    INSERT INTO sales (customer, category, revenue) VALUES
    ('A', 'Shoes', 100),
    ('A', 'Hats', 200),
    ('A', 'Bags', 150),
    ('B', 'Shoes', 300),
    ('B', 'Hats', 50),
    ('C', 'Bags', 400),
    ('C', 'Shoes', 400);

---

    SELECT
    	customer,
        category,
        revenue
    FROM (
    	SELECT
        	customer,
        	category,
        	revenue,
        	ROW_NUMBER() OVER (
            	PARTITION BY customer
            	ORDER BY revenue DESC
        	) AS rn
    	FROM sales
    ) t
    WHERE rn = 1;

| customer | category | revenue |
| -------- | -------- | ------- |
| A        | Hats     | 200     |
| B        | Shoes    | 300     |
| C        | Bags     | 400     |

---

    SELECT
    	customer,
        category,
        revenue
    FROM (
    	SELECT
        	customer,
        	category,
        	revenue,
        	RANK() OVER (
            	PARTITION BY customer
            	ORDER BY revenue DESC
        	) AS rn
    	FROM sales
    ) t
    WHERE rn = 1;

| customer | category | revenue |
| -------- | -------- | ------- |
| A        | Hats     | 200     |
| B        | Shoes    | 300     |
| C        | Bags     | 400     |
| C        | Shoes    | 400     |

---

**Schema (MySQL v8)**

    CREATE TABLE customers (
        customer_id INT,
        name VARCHAR(50)
    );
    
    INSERT INTO customers VALUES
    (1, 'Anna'),
    (2, 'Petr'),
    (3, 'Eva');
    
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
    (1, 1, 2),  -- Anna
    (1, 2, 1),
    (2, 1, 1),
    (3, 3, 3),  -- Petr
    (4, 2, 2);  -- Eva
    
    
    CREATE TABLE products (
        product_id INT,
        category VARCHAR(50),
        price INT
    );
    
    INSERT INTO products VALUES
    (1, 'Shoes', 100),
    (2, 'Hats', 200),
    (3, 'Bags', 300);

---

    SELECT
    	name,
        category,
        total_revenue
    FROM (
    	SELECT
    		name,
        	category,
        	total_revenue,
        	ROW_NUMBER() OVER (
          		PARTITION BY name
          		ORDER BY total_revenue DESC
    		) AS rn
    	FROM (
    		SELECT
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
    			c.name,
        		p.category
      	) x
      ) t
      WHERE rn = 1;

| name | category | total_revenue |
| ---- | -------- | ------------- |
| Anna | Shoes    | 300           |
| Eva  | Hats     | 400           |
| Petr | Bags     | 900           |

---

**Schema (MySQL v8)**

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

---

    SELECT
        c.customer_id,
        c.name,
        SUM(oi.quantity * p.price) AS total_revenue,
        CASE
            WHEN SUM(oi.quantity * p.price) > 1000 THEN 'VIP'
            WHEN SUM(oi.quantity * p.price) > 500 THEN 'medium'
            ELSE 'low'
        END AS segment
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON p.product_id = oi.product_id
    GROUP BY
    	c.customer_id,
        c.name
    ORDER BY total_revenue DESC;

| customer_id | name | total_revenue | segment |
| ----------- | ---- | ------------- | ------- |
| 2           | Petr | 900           | medium  |
| 1           | Anna | 500           | low     |
| 3           | Eva  | 400           | low     |

---

**Schema (MySQL v8)**

    CREATE TABLE sales (
        customer VARCHAR(50),
        category VARCHAR(50),
        revenue INT
    );
    
    INSERT INTO sales VALUES
    ('A', 'Shoes', 100),
    ('A', 'Hats', 200),
    ('A', 'Bags', 150),
    ('B', 'Shoes', 300),
    ('B', 'Hats', 50),
    ('C', 'Bags', 400),
    ('C', 'Shoes', 400);

---

    SELECT
    	customer,
        category,
        revenue,
        SUM(revenue) OVER (
          	PARTITION BY customer
      	) AS total_revenue_customer
    FROM sales;

| customer | category | revenue | total_revenue_customer |
| -------- | -------- | ------- | ---------------------- |
| A        | Shoes    | 100     | 450                    |
| A        | Hats     | 200     | 450                    |
| A        | Bags     | 150     | 450                    |
| B        | Shoes    | 300     | 350                    |
| B        | Hats     | 50      | 350                    |
| C        | Bags     | 400     | 800                    |
| C        | Shoes    | 400     | 800                    |

---

    SELECT
    	customer,
        category,
        revenue,
        SUM(revenue) OVER (
          	PARTITION BY customer
      	) AS total_revenue_customer,
        CONCAT(
        	ROUND(
             	revenue * 100.0 / SUM(revenue) OVER (
          			PARTITION BY customer),
          			2
      		),
          	'%'
      	) AS share_percent
    FROM sales;

| customer | category | revenue | total_revenue_customer | share_percent |
| -------- | -------- | ------- | ---------------------- | ------------- |
| A        | Shoes    | 100     | 450                    | 22.22%        |
| A        | Hats     | 200     | 450                    | 44.44%        |
| A        | Bags     | 150     | 450                    | 33.33%        |
| B        | Shoes    | 300     | 350                    | 85.71%        |
| B        | Hats     | 50      | 350                    | 14.29%        |
| C        | Bags     | 400     | 800                    | 50.00%        |
| C        | Shoes    | 400     | 800                    | 50.00%        |

---

**Schema (MySQL v8)**

    CREATE TABLE sales (
        customer VARCHAR(50),
        category VARCHAR(50),
        revenue INT
    );
    
    INSERT INTO sales VALUES
    ('A', 'Shoes', 100),
    ('A', 'Hats', 200),
    ('A', 'Bags', 150),
    ('B', 'Shoes', 300),
    ('B', 'Hats', 50),
    ('C', 'Bags', 400),
    ('C', 'Shoes', 400);

---

    SELECT
    	customer,
        category,
        revenue,
        SUM(revenue) OVER (
          	PARTITION BY customer
      	) AS total_revenue_customer,
        CONCAT(
        	ROUND(
             	revenue * 100.0 / SUM(revenue) OVER (
          			),
          			2
      		),
          	'%'
      	) AS share_percent
    FROM sales;

| customer | category | revenue | total_revenue_customer | share_percent |
| -------- | -------- | ------- | ---------------------- | ------------- |
| A        | Shoes    | 100     | 450                    | 6.25%         |
| A        | Hats     | 200     | 450                    | 12.50%        |
| A        | Bags     | 150     | 450                    | 9.38%         |
| B        | Shoes    | 300     | 350                    | 18.75%        |
| B        | Hats     | 50      | 350                    | 3.13%         |
| C        | Bags     | 400     | 800                    | 25.00%        |
| C        | Shoes    | 400     | 800                    | 25.00%        |

---

**Schema (MySQL v8)**

    CREATE TABLE sales (
        id INT,
        customer VARCHAR(50),
        revenue INT
    );
    
    INSERT INTO sales VALUES
    (1, 'A', 100),
    (2, 'A', 200),
    (3, 'A', 150),
    (4, 'B', 300),
    (5, 'B', 50);

---

    SELECT
    	customer,
        revenue,
        SUM(revenue) OVER (
          PARTITION BY customer
          ORDER BY id
          ) AS running_total
    FROM sales;

| customer | revenue | running_total |
| -------- | ------- | ------------- |
| A        | 100     | 100           |
| A        | 200     | 300           |
| A        | 150     | 450           |
| B        | 300     | 300           |
| B        | 50      | 350           |

---

**Schema (MySQL v8)**

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
    ('B', '2024-02-01', 100);

---

**Query #1**

    SELECT
    	customer,
        date,
        revenue,
        LAG(revenue) OVER (
          	PARTITION BY customer
          	ORDER BY date
     	) AS prev_revenue
    FROM sales;

| customer | date       | revenue | prev_revenue |
| -------- | ---------- | ------- | ------------ |
| A        | 2024-01-01 | 100     |              |
| A        | 2024-02-01 | 200     | 100          |
| A        | 2024-03-01 | 150     | 200          |
| B        | 2024-01-01 | 300     |              |
| B        | 2024-02-01 | 100     | 300          |

---
**Query #2**

    SELECT
    	customer,
        date,
        revenue,
        LAG(revenue) OVER (
          	PARTITION BY customer
          	ORDER BY date
     	) AS prev_revenue
    FROM sales;

| customer | date       | revenue | prev_revenue |
| -------- | ---------- | ------- | ------------ |
| A        | 2024-01-01 | 100     |              |
| A        | 2024-02-01 | 200     | 100          |
| A        | 2024-03-01 | 150     | 200          |
| B        | 2024-01-01 | 300     |              |
| B        | 2024-02-01 | 100     | 300          |

---
**Query #3**

    SELECT
    	customer,
        date,
        revenue,
       	CASE
        	WHEN LAG(revenue) OVER (
            	PARTITION BY customer
            	ORDER BY date
        	) IS NULL THEN NULL
        	ELSE CONCAT(
            	ROUND(
                	(revenue - LAG(revenue) OVER (
                    	PARTITION BY customer
                    	ORDER BY date
                	)) * 100.0
                	/
                	LAG(revenue) OVER (
                    	PARTITION BY customer
                    	ORDER BY date
                	),
                	2
            	),
            	'%'
        	)
    	END AS pct_change
    FROM sales;

| customer | date       | revenue | pct_change |
| -------- | ---------- | ------- | ---------- |
| A        | 2024-01-01 | 100     |            |
| A        | 2024-02-01 | 200     | 100.00%    |
| A        | 2024-03-01 | 150     | -25.00%    |
| B        | 2024-01-01 | 300     |            |
| B        | 2024-02-01 | 100     | -66.67%    |

---


