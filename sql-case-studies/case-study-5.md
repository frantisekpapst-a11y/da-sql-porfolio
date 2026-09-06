# Case Study 05 — HAVING & Trigger Logic

## Cíl projektu

Procvičit práci s agregovanými daty pomocí klauzule `HAVING` a pochopit základní princip DML triggerů v MS-SQL.

Projekt se zaměřuje na:
- filtrování agregovaných výsledků
- rozdíl mezi `WHERE` a `HAVING`
- práci s `GROUP BY`
- základní princip triggerů
- audit změn v databázi
- rozdíl mezi `inserted` a `deleted`

---

# Procvičené dovednosti

- GROUP BY
- HAVING
- COUNT
- SUM
- WHERE
- AFTER UPDATE trigger
- CREATE TRIGGER
- inserted / deleted pseudotabulky
- CURRENT_TIMESTAMP
- auditní tabulka
- základní databázová automatizace

---

# Business scénář

Firma chce analyzovat objednávky a zároveň evidovat historii změn platů zaměstnanců.

Management potřebuje:

1. najít objednávky s vyšší celkovou hodnotou
2. filtrovat objednávky podle celkového počtu kusů
3. analyzovat počet zákazníků podle měst
4. rozlišit filtrování řádků a filtrování skupin
5. pochopit princip automatického logování změn pomocí triggeru

---

# Dataset — Order Details

```sql
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price INT
);

INSERT INTO order_details VALUES
(1, 1, 15, 159),
(1, 8, 2, 199),
(2, 5, 3, 1959),
(2, 1, 4, 2499),
(3, 24, 1, 99);
```

---

# Část 1 — HAVING

## 1. Celkový počet kusů a cena objednávky

```sql
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_revenue
FROM order_details
GROUP BY order_id;
```

---

## 2. Objednávky s celkovou cenou vyšší než 1000

```sql
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_revenue
FROM order_details
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 1000;
```

---

## 3. Objednávky s cenou vyšší než 1000 a více než 5 kusy

```sql
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_revenue
FROM order_details
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 1000
AND SUM(quantity) > 5;
```

---

# Dataset — Customers

```sql
CREATE TABLE customers_having (
    customer_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    age INT,
    city NVARCHAR(50)
);

INSERT INTO customers_having VALUES
(1, 'Matěj', 'Eliáš', 20, 'Ostrava'),
(2, 'Karel', 'Svoboda', 21, 'Ostrava'),
(3, 'Jiří', 'Novák', 17, 'Ostrava'),
(4, 'Petr', 'Novotný', 45, 'Praha'),
(5, 'Jan', 'Horák', 14, 'Praha'),
(6, 'Prokop', 'Buben', 34, 'Brno');
```

---

## 4. Počet zákazníků podle města

```sql
SELECT
    city,
    COUNT(*) AS city_numbers
FROM customers_having
GROUP BY city;
```

---

## 5. Města s více než jedním zákazníkem

```sql
SELECT
    city,
    COUNT(*) AS city_numbers
FROM customers_having
GROUP BY city
HAVING COUNT(*) > 1;
```

---

## 6. Města s více než jedním dospělým zákazníkem

```sql
SELECT
    city,
    COUNT(*) AS city_numbers
FROM customers_having
WHERE age > 17
GROUP BY city
HAVING COUNT(*) > 1;
```

---

# Část 2 — Trigger Logic

## Dataset — Employees

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name NVARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Jan', 40000),
(2, 'Eva', 50000);
```

---

## 7. Auditní tabulka pro historii platů

```sql
CREATE TABLE salary_history (
    history_id INT PRIMARY KEY IDENTITY,
    employee_id INT,
    employee_name NVARCHAR(50),
    old_salary INT,
    changed_at DATETIME
);
```

---

## 8. AFTER UPDATE trigger pro uložení původního platu

```sql
CREATE TRIGGER salary_after_change
ON employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO salary_history (
        employee_id,
        employee_name,
        old_salary,
        changed_at
    )
    SELECT
        employee_id,
        employee_name,
        salary,
        CURRENT_TIMESTAMP
    FROM deleted;
END;
```

---

## 9. Test triggeru

```sql
UPDATE employees
SET salary = 60000
WHERE employee_id = 1;

SELECT *
FROM salary_history;
```

---

# Poznámka k triggerům

V některých online SQL sandboxech nemusí být `CREATE TRIGGER` plně podporovaný nebo může vyžadovat samostatné spuštění jako vlastní batch.

Proto je možné princip triggeru ověřit ruční simulací:

```sql
INSERT INTO salary_history (
    employee_id,
    employee_name,
    old_salary,
    changed_at
)
SELECT
    employee_id,
    employee_name,
    salary,
    CURRENT_TIMESTAMP
FROM employees
WHERE employee_id = 1;

UPDATE employees
SET salary = 60000
WHERE employee_id = 1;

SELECT *
FROM salary_history;
```

Tato simulace ukazuje stejnou logiku:

- nejdřív uložíme původní stav
- potom provedeme změnu
- historie zůstane uložená v auditní tabulce

---

# Očekávané výstupy

## Objednávky s cenou vyšší než 1000 a více než 5 kusy

| order_id | total_quantity | total_revenue |
|---|---:|---:|
| 1 | 17 | 2783 |
| 2 | 7 | 15873 |

---

## Počet zákazníků podle města

| city | city_numbers |
|---|---:|
| Brno | 1 |
| Ostrava | 3 |
| Praha | 2 |

---

## Města s více než jedním zákazníkem

| city | city_numbers |
|---|---:|
| Ostrava | 3 |
| Praha | 2 |

---

## Města s více než jedním dospělým zákazníkem

| city | city_numbers |
|---|---:|
| Ostrava | 2 |

---

## Očekávaný výstup salary_history

| employee_id | employee_name | old_salary |
|---|---|---:|
| 1 | Jan | 40000 |

---

# Co jsem se naučil

- `WHERE` filtruje jednotlivé řádky před agregací
- `HAVING` filtruje skupiny po agregaci
- agregační funkce jako `COUNT()` nebo `SUM()` nepatří do `WHERE`
- `HAVING` se používá společně s `GROUP BY`
- alias ze `SELECT` většinou nelze použít v `HAVING`
- `ORDER BY` naopak alias použít může
- trigger je automatická reakce databáze na událost
- `AFTER UPDATE` trigger se spouští po změně dat
- `deleted` obsahuje původní hodnoty při `UPDATE`
- `inserted` obsahuje nové hodnoty při `UPDATE`
- auditní tabulky slouží k uchování historie změn

---

# Využití v praxi

Tato case study simuluje běžné databázové a analytické scénáře:

- reporting objednávek
- filtrování agregovaných výsledků
- analýza zákazníků podle měst
- audit změn v databázi
- sledování historie platů
- základní databázová automatizace
- pochopení rozdílu mezi analytickým SQL a databázovou logikou.