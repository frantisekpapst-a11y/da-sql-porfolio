USE sales_analysis_practice;
GO


/* ============================================================
   1. ČIŠTĚNÍ ZÁKAZNÍKŮ

   Cíl:
   Odstranit krajní mezery v textových sloupcích
   a chybějící region označit jako neznámý.

   Původní tabulka customers_raw zůstává zachována.
   ============================================================ */

DROP TABLE IF EXISTS dbo.customers_clean;

SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    TRIM(customer_type) AS customer_type,
    COALESCE(TRIM(region), N'neznámý') AS region
INTO customers_clean
FROM customers_raw;


/* ============================================================
   2. ODSTRANĚNÍ DUPLICITNÍCH OBJEDNÁVEK

   Cíl:
   Vytvořit orders_clean s jedním řádkem na objednávku.

   Při validaci jsme ověřili, že opakovaná order_id
   představují shodné kopie objednávek.

   Původní tabulka orders_raw zůstává zachována.
   ============================================================ */

DROP TABLE IF EXISTS dbo.orders_clean;

WITH duplicity_objednavky AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY raw_row_id
        ) AS rn
    FROM orders_raw
)
SELECT
    *
INTO orders_clean
FROM duplicity_objednavky
WHERE rn = 1;


/* ============================================================
   3. ULOŽENÍ OBJEDNÁVEK K PROVĚŘENÍ

   Cíl:
   Uchovat problémové objednávky před jejich odstraněním
   z analytických dat.

   Důvody pro vyřazení:
   - chybějící částka,
   - nulová nebo záporná částka,
   - zákazník nenalezený v customers_clean.
   ============================================================ */

DROP TABLE IF EXISTS orders_review;

WITH objednavky_k_provereni AS (
    SELECT o.*
    FROM orders_clean o
    LEFT JOIN customers_clean c
        ON o.customer_id = c.customer_id
    WHERE o.order_amount IS NULL
       OR o.order_amount <= 0
       OR c.customer_id IS NULL
)
SELECT *
INTO orders_review
FROM objednavky_k_provereni;


/* ============================================================
   4. VYŘAZENÍ PROBLÉMOVÝCH OBJEDNÁVEK Z CLEAN

   Cíl:
   Odstranit z orders_clean objednávky uložené k prověření.

   Tabulky orders_review a orders_raw zůstávají zachovány.
   ============================================================ */

WITH objednavky_k_odstraneni AS (
    SELECT order_id
    FROM orders_review
)
DELETE FROM orders_clean
WHERE order_id IN (
    SELECT order_id
    FROM objednavky_k_odstraneni
);


/* ============================================================
   5. KONTROLA VYČIŠTĚNÝCH ZÁKAZNÍKŮ

   Cíl:
   Ověřit počet zákazníků, hodnoty customer_type
   a nahrazení chybějících regionů.
   ============================================================ */

SELECT COUNT(*) AS pocet_zakazniku
FROM customers_clean;

SELECT DISTINCT customer_type
FROM customers_clean;

SELECT *
FROM customers_clean
WHERE region = N'neznámý';


/* ============================================================
   6. KONTROLA DUPLICIT V ČISTÝCH OBJEDNÁVKÁCH

   Cíl:
   Ověřit jedinečnost order_id a nepřítomnost
   shodných kopií objednávek.

   První dotaz kontroluje opakování order_id.
   Druhý kontroluje shodu všech zdrojových hodnot objednávky.
   ============================================================ */

SELECT
    order_id,
    COUNT(*) AS duplicita_order_id
FROM orders_clean
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    order_id,
    COUNT(*) AS duplicita_objednavka
FROM orders_clean
GROUP BY
    order_id,
    order_date,
    customer_id,
    order_amount
HAVING COUNT(*) > 1;


/* ============================================================
   7. REKONCILIACE OBJEDNÁVEK A KONTROLA REVIEW

   Cíl:
   Ověřit konečný počet objednávek a prohlédnout
   záznamy uložené k prověření.

   Rekonciliace:
   1 005 původních řádků
   - 5 duplicitních kopií
   - 5 problémových objednávek
   = 995 čistých objednávek.
   ============================================================ */

SELECT COUNT(*) AS pocet_objednavek_clean
FROM orders_clean;

SELECT *
FROM orders_review
ORDER BY order_id;


/* ============================================================
   8. ZÁVĚREČNÁ KONTROLA KVALITY OBJEDNÁVEK

   Cíl:
   Ověřit, že v orders_clean nezůstaly:
   - chybějící částky,
   - nulové nebo záporné částky,
   - odkazy na neexistující zákazníky.
   ============================================================ */

SELECT
    o.order_id,
    o.customer_id,
    o.order_amount
FROM orders_clean o
LEFT JOIN customers_clean c
    ON o.customer_id = c.customer_id
WHERE o.order_amount IS NULL
   OR o.order_amount <= 0
   OR c.customer_id IS NULL;
GO