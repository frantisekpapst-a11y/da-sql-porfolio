# Case Study 04 — Database Maintenance & Performance Optimization

## Cíl projektu

Procvičit správu databáze a základní optimalizaci výkonu v MS-SQL.

Projekt se zaměřuje na:

- změnu struktury databáze
- práci s transakcemi
- databázové pohledy (VIEW)
- databázové indexy
- optimalizaci výkonu
- základní databázový maintenance

---

# Procvičené dovednosti

- ALTER TABLE
- ADD COLUMN
- ALTER COLUMN
- CREATE VIEW
- BEGIN TRANSACTION
- COMMIT TRANSACTION
- UPDATE
- CREATE INDEX
- composite index
- optimalizace SELECT dotazů
- databázové indexy
- analytické přemýšlení nad výkonem databáze

---

# Business scénář

E-commerce firma začíná mít:

- více zákazníků
- více objednávek
- pomalejší databázové dotazy

Management chce:

1. rozšířit databázovou strukturu
2. ukládat zákaznické zůstatky
3. vytvořit pohled pro důležité objednávky
4. simulovat převod peněz mezi zákazníky
5. optimalizovat časté dotazy pomocí indexů

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

INSERT INTO customers VALUES
(1, 'Jan', 'Praha'),
(2, 'Eva', 'Brno'),
(3, 'Petr', 'Ostrava');

INSERT INTO orders VALUES
(101, 1, 1200, '2024-01-10'),
(102, 1, 800, '2024-02-05'),
(103, 2, 2500, '2024-01-15');
Zadání a řešení
1. Přidání nového sloupce

Do tabulky customers přidáme sloupec email.

ALTER TABLE customers
ADD email NVARCHAR(50);
2. Změna datového typu sloupce

Zvětšíme velikost sloupce city.

ALTER TABLE customers
ALTER COLUMN city NVARCHAR(100);
3. Vytvoření VIEW

Vytvoříme pohled pro objednávky vyšší než 1000.

CREATE VIEW high_value_orders AS
SELECT *
FROM orders
WHERE amount > 1000;

Použití VIEW:

SELECT *
FROM high_value_orders;
4. Přidání balance a simulace transakce

Přidáme zákaznický zůstatek:

ALTER TABLE customers
ADD balance DECIMAL(10,2);

Inicializace hodnot:

UPDATE customers
SET balance = CASE
    WHEN customer_id = 1 THEN 500
    WHEN customer_id = 2 THEN 500
    WHEN customer_id = 3 THEN 500
END;

Simulace převodu:

BEGIN TRANSACTION;

UPDATE customers
SET balance = balance - 200
WHERE customer_id = 1;

UPDATE customers
SET balance = balance + 200
WHERE customer_id = 2;

COMMIT TRANSACTION;

Kontrola výsledku:

SELECT *
FROM customers;
5. Index na customer_id

Optimalizace častého JOINu mezi:

orders
customers
CREATE INDEX idx_orders_customer
ON orders (customer_id);
6. Composite index

Index přes více sloupců:

CREATE INDEX idx_customer_name_city
ON customers (customer_name, city);

Použití:

SELECT *
FROM customers
WHERE customer_name = 'Jan'
AND city = 'Praha';
Očekávané výstupy
High value orders
order_id	customer_id	amount
101	1	1200
103	2	2500
Stav zákaznických zůstatků po transakci
customer_name	balance
Jan	300
Eva	700
Petr	500
Co jsem se naučil
ALTER TABLE umožňuje měnit strukturu existující databáze
VIEW funguje jako virtuální tabulka nad uloženým SELECT dotazem
transakce zajišťují konzistenci databáze
COMMIT potvrdí transakci
databázové indexy výrazně zrychlují čtení dat
indexy pomáhají hlavně při:
JOIN
WHERE
ORDER BY
indexy zároveň zpomalují:
INSERT
UPDATE
DELETE
composite index umožňuje optimalizovat hledání přes více sloupců
optimalizace by se měla dělat až podle reálného výkonu databáze
Využití v praxi

Tato case study simuluje běžné databázové úlohy:

maintenance databáze
optimalizace SQL dotazů
návrh databázové struktury
práce s databázovým výkonem
tvorba reportingových pohledů
práce s transakcemi
příprava databází pro analytické systémy a Power BI.