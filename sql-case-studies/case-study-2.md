# Case Study 02 — E-commerce Product Analytics

## Cíl projektu

Procvičit SQL dotazy používané v základní datové analytice na realistickém e-commerce scénáři.

Projekt simuluje databázi produktů internetového obchodu a zaměřuje se na:

- filtrování dat
- agregace
- business reporting
- práci s kategoriemi
- analytické myšlení nad datasety

---

# Procvičené dovednosti

- SELECT
- WHERE
- AND / OR
- LIKE
- IN
- BETWEEN
- ORDER BY
- TOP
- COUNT
- SUM
- AVG
- MIN / MAX
- GROUP BY
- HAVING
- základní business reporting

---

# Business scénář

E-shop potřebuje analyzovat své produkty a skladová data.

Management chce:

1. identifikovat drahé produkty
2. analyzovat produktové kategorie
3. spočítat hodnotu skladu
4. zjistit průměrné ceny produktů
5. identifikovat nejdražší produkty
6. najít nejvýnosnější produktové kategorie

---

# Dataset

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(100),
    category NVARCHAR(50),
    price INT,
    stock INT
);

INSERT INTO products VALUES
(1, 'iPhone 15', 'Elektronika', 26000, 5),
(2, 'Samsung TV', 'Elektronika', 18000, 2),
(3, 'Herní židle', 'Nábytek', 6500, 8),
(4, 'Notebook Lenovo', 'Elektronika', 22000, 4),
(5, 'Psací stůl', 'Nábytek', 4500, 10),
(6, 'Power BI kurz', 'Kurzy', 3000, 50),
(7, 'SQL kurz', 'Kurzy', 2500, 40),
(8, 'Python kurz', 'Kurzy', 4000, 35),
(9, 'Monitor Dell', 'Elektronika', 7000, 7),
(10, 'Kancelářská židle', 'Nábytek', 3500, 12);
```

---

# Zadání a řešení

## 1. Výpis všech produktů

```sql
SELECT *
FROM products;
```

---

## 2. Výpis názvu produktu a ceny

```sql
SELECT
    product_name,
    price
FROM products;
```

---

## 3. Produkty dražší než 10 000

```sql
SELECT *
FROM products
WHERE price > 10000;
```

---

## 4. Elektronika se skladem menším než 5

```sql
SELECT *
FROM products
WHERE category = 'Elektronika'
AND stock < 5;
```

---

## 5. Produkty z kategorií Elektronika nebo Kurzy

```sql
SELECT *
FROM products
WHERE category IN ('Elektronika', 'Kurzy');
```

---

## 6. Produkty obsahující slovo „židle“

```sql
SELECT *
FROM products
WHERE product_name LIKE '%židle%';
```

---

## 7. Produkty v cenovém rozsahu

```sql
SELECT *
FROM products
WHERE price BETWEEN 3000 AND 10000;
```

---

## 8. Tři nejdražší produkty

```sql
SELECT TOP 3 *
FROM products
ORDER BY price DESC;
```

---

## 9. Počet všech produktů

```sql
SELECT COUNT(*) AS total_products
FROM products;
```

---

## 10. Průměrná cena produktů

```sql
SELECT
    AVG(price) AS average_price
FROM products;
```

---

## 11. Nejvyšší a nejnižší cena produktu

```sql
SELECT
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM products;
```

---

## 12. Celková hodnota skladu

Výpočet:

```text
price * stock
```

```sql
SELECT
    SUM(price * stock) AS stock_value
FROM products;
```

---

## 13. Počet produktů podle kategorií

```sql
SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category;
```

---

## 14. Průměrná cena podle kategorií

```sql
SELECT
    category,
    AVG(price) AS avg_price_category
FROM products
GROUP BY category;
```

---

## 15. Kategorie s více než 2 produkty

Používáme `HAVING`, protože filtrujeme agregovaný výsledek.

```sql
SELECT
    category,
    COUNT(category) AS product_numbers
FROM products
GROUP BY category
HAVING COUNT(category) > 2;
```

---

## 16. Kategorie s nejvyšší průměrnou cenou

```sql
SELECT TOP 1
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;
```

---

# Očekávané výstupy

## Kategorie s nejvyšší průměrnou cenou

| category | avg_price |
|---|---:|
| Elektronika | 18250 |

---

## Počet produktů podle kategorií

| category | total_products |
|---|---:|
| Elektronika | 4 |
| Nábytek | 3 |
| Kurzy | 3 |

---

## Tři nejdražší produkty

| product_name | price |
|---|---:|
| iPhone 15 | 26000 |
| Notebook Lenovo | 22000 |
| Samsung TV | 18000 |

---

# Co jsem se naučil

- `WHERE` filtruje jednotlivé řádky
- `GROUP BY` agreguje data do skupin
- `HAVING` filtruje agregované výsledky
- `ORDER BY` umožňuje ranking a prioritizaci
- agregační funkce jsou základ business reportingu
- SQL je velmi vhodné pro analytické úlohy
- `COUNT`, `SUM` a `AVG` patří mezi nejpoužívanější analytické funkce
- `LIKE` umožňuje textové filtrování
- `BETWEEN` slouží pro práci s rozsahy hodnot

---

# Využití v praxi

Tato case study simuluje běžné úkoly datového analytika v e-commerce:

- produktová analytika
- reporting skladů
- cenová analytika
- business intelligence
- retail reporting
- dashboarding v Power BI
- příprava dat pro management reporting.