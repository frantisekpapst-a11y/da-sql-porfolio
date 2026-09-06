# Case Study 03 — SQL Reporting & Relational Analysis

## Cíl projektu

Procvičit SQL dotazy nad více propojenými tabulkami na realistickém e-commerce scénáři.

Projekt simuluje jednoduchý reportingový systém, ve kterém analyzujeme:

- zákazníky
- objednávky
- produkty
- kategorie produktů
- M:N vztahy
- zákazníky bez objednávek
- revenue zákazníků

---

# Procvičené dovednosti

- INNER JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- COUNT
- SUM
- AVG
- MAX
- COALESCE
- EXISTS
- NOT EXISTS
- subquery
- CTE
- M:N vztahy
- vazební tabulky
- business reporting

---

# Business scénář

Firma provozuje malý e-shop s digitálními produkty a elektronikou.

Management chce zjistit:

1. kteří zákazníci objednávali
2. kteří zákazníci zatím nic neobjednali
3. kolik objednávek má každý zákazník
4. jaké revenue má každý zákazník
5. které objednávky jsou nadprůměrné
6. jak produkty patří do kategorií
7. které produkty jsou ve více kategoriích
8. kdo je zákazník s nejvyšším revenue

---

# Dataset

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(50),
    city NVARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    order_date DATE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name NVARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(50)
);

CREATE TABLE product_categories (
    product_id INT,
    category_id INT
);

INSERT INTO customers VALUES
(1, 'Jan', 'Praha'),
(2, 'Eva', 'Brno'),
(3, 'Petr', 'Ostrava'),
(4, 'Lucie', 'Praha'),
(5, 'Adam', 'Plzen');

INSERT INTO orders VALUES
(101, 1, 1200, '2024-01-10'),
(102, 1, 800, '2024-02-05'),
(103, 2, 2500, '2024-01-15'),
(104, 3, 900, '2024-03-01'),
(105, 3, 1400, '2024-03-12');

INSERT INTO categories VALUES
(1, 'Elektronika'),
(2, 'Kurzy'),
(3, 'Nábytek');

INSERT INTO products VALUES
(1, 'Notebook'),
(2, 'SQL kurz'),
(3, 'Kancelářská židle'),
(4, 'Power BI kurz');

INSERT INTO product_categories VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(1, 2);
```

---

# Zadání a řešení

## 1. Výpis zákazníků a jejich objednávek

Cílem je vypsat pouze zákazníky, kteří mají objednávku.

```sql
SELECT
    c.customer_name,
    o.amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY c.customer_name;
```

---

## 2. Výpis všech zákazníků včetně těch bez objednávky

Cílem je zachovat všechny zákazníky, i když nemají žádnou objednávku.

```sql
SELECT
    c.customer_name,
    o.amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_name;
```

---

## 3. Počet objednávek na zákazníka

Používáme `COUNT(o.order_id)`, protože u `LEFT JOIN` nechceme počítat NULL řádky jako objednávky.

```sql
SELECT
    c.customer_name,
    COUNT(o.order_id) AS number_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY number_orders DESC;
```

---

## 4. Zákazníci bez objednávky

Klasický analytický pattern:

```text
LEFT JOIN + IS NULL
```

```sql
SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

---

## 5. Revenue každého zákazníka

```sql
SELECT
    c.customer_name,
    SUM(o.amount) AS total_revenue
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;
```

---

## 6. Revenue každého zákazníka včetně nulových hodnot

U zákazníků bez objednávek vrací `SUM(o.amount)` hodnotu `NULL`, proto použijeme `COALESCE`.

```sql
SELECT
    c.customer_name,
    COALESCE(SUM(o.amount), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;
```

---

## 7. Produkty a jejich kategorie

Tento dotaz ukazuje M:N vztah:

```text
products → product_categories → categories
```

```sql
SELECT
    p.product_name,
    c.category_name
FROM products p
LEFT JOIN product_categories pc
    ON p.product_id = pc.product_id
LEFT JOIN categories c
    ON pc.category_id = c.category_id
ORDER BY p.product_name;
```

---

## 8. Počet kategorií každého produktu

```sql
SELECT
    p.product_name,
    COUNT(pc.category_id) AS number_categories
FROM products p
LEFT JOIN product_categories pc
    ON p.product_id = pc.product_id
GROUP BY p.product_name
ORDER BY number_categories DESC;
```

---

## 9. Produkty bez kategorie

Opět pattern:

```text
LEFT JOIN + IS NULL
```

```sql
SELECT
    p.product_name
FROM products p
LEFT JOIN product_categories pc
    ON p.product_id = pc.product_id
WHERE pc.category_id IS NULL;
```

---

## 10. Objednávky vyšší než průměrná objednávka

Používáme poddotaz ve `WHERE`.

```sql
SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
);
```

---

## 11. Zákazníci s alespoň jednou objednávkou

Používáme `EXISTS`, který testuje existenci souvisejícího řádku.

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT *
    FROM orders o
    WHERE c.customer_id = o.customer_id
);
```

---

## 12. Zákazníci bez objednávky přes NOT EXISTS

```sql
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT *
    FROM orders o
    WHERE c.customer_id = o.customer_id
);
```

---

## 13. Zákazník s nejvyšším revenue

Používáme CTE:

1. `customer_revenue` spočítá revenue za zákazníka
2. `max_revenue` najde nejvyšší revenue
3. finální SELECT vrátí zákazníka s tímto revenue

```sql
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM orders
    GROUP BY customer_id
),

max_revenue AS (
    SELECT
        MAX(total_revenue) AS max_total_revenue
    FROM customer_revenue
)

SELECT
    c.customer_name,
    cr.total_revenue
FROM customer_revenue cr
JOIN customers c
    ON cr.customer_id = c.customer_id
JOIN max_revenue mr
    ON cr.total_revenue = mr.max_total_revenue;
```

---

## 14. CTE customer_revenue

Cílem je vytvořit pojmenovaný mezivýsledek `customer_revenue` a následně ho propojit s tabulkou zákazníků.

```sql
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name,
    cr.total_revenue
FROM customer_revenue cr
JOIN customers c
    ON cr.customer_id = c.customer_id
ORDER BY cr.total_revenue DESC;
```

---

# Očekávané výstupy

## Revenue zákazníků

| customer_name | total_revenue |
|---|---:|
| Eva | 2500 |
| Petr | 2300 |
| Jan | 2000 |
| Lucie | 0 |
| Adam | 0 |

---

## Zákazníci bez objednávek

| customer_name |
|---|
| Lucie |
| Adam |

---

## Produkty a kategorie

| product_name | category_name |
|---|---|
| Kancelářská židle | Nábytek |
| Notebook | Elektronika |
| Notebook | Kurzy |
| Power BI kurz | Kurzy |
| SQL kurz | Kurzy |

---

## Produkty s více kategoriemi

| product_name | number_categories |
|---|---:|
| Notebook | 2 |

---

## Objednávky nad průměrnou hodnotou

| order_id | customer_id | amount | order_date |
|---|---:|---:|---|
| 103 | 2 | 2500 | 2024-01-15 |
| 105 | 3 | 1400 | 2024-03-12 |

---

# Co jsem se naučil

- `INNER JOIN` vrací pouze shody mezi tabulkami
- `LEFT JOIN` zachová všechny řádky z levé tabulky
- `COUNT(o.order_id)` je bezpečnější než `COUNT(*)` u `LEFT JOIN`
- `LEFT JOIN + IS NULL` slouží k hledání chybějících vazeb
- `COALESCE` nahrazuje `NULL` hodnoty
- M:N vztahy se řeší pomocí vazební tabulky
- poddotaz ve `WHERE` umožňuje filtrovat podle vypočítané hodnoty
- `EXISTS` kontroluje existenci souvisejícího řádku
- `NOT EXISTS` hledá záznamy bez souvisejících dat
- CTE pomáhá rozdělit složitější SQL logiku na čitelné kroky

---

# Využití v praxi

Tato case study simuluje běžné úkoly junior datového analytika:

- customer reporting
- revenue analýza
- e-commerce reporting
- hledání neaktivních zákazníků
- kontrola produktových kategorií
- práce s relačními daty
- business intelligence reporting
- příprava dat pro Power BI dashboardy,