USE sales_analysis_practice;
GO


/* ============================================================
   1. VYTVOŘENÍ ANALYTICKÉ VRSTVY

   Cíl:
   Propojit čisté objednávky s údaji o zákaznících
   pro analýzu v SQL a následné načtení do Excelu.

   Granularita:
   Jeden řádek = jedna objednávka.
   ============================================================ */

CREATE OR ALTER VIEW v_orders_analysis AS
SELECT
    o.order_id,
    o.order_date,
    o.order_amount,
    o.customer_id,
    c.customer_name,
    c.customer_type,
    c.region
FROM orders_clean o
JOIN customers_clean c
    ON o.customer_id = c.customer_id;
GO


/* ============================================================
   2. MĚSÍČNÍ VÝVOJ OBJEDNÁVEK A TRŽEB

   Analytická otázka:
   Jak se během roku 2025 vyvíjely objednávky a tržby?
   ============================================================ */

WITH trzby_mesicni AS (
    SELECT
        MONTH(order_date) AS mesic,
        COUNT(*) AS objednavky_pocet,
        SUM(order_amount) AS trzby_celkem
    FROM v_orders_analysis
    GROUP BY MONTH(order_date)
),
srovnani_mesicu AS (
    SELECT
        mesic,
        objednavky_pocet,
        trzby_celkem,
        LAG(trzby_celkem) OVER (
            ORDER BY mesic
        ) AS trzby_predchozi_mesic
    FROM trzby_mesicni
)
SELECT
    mesic,
    objednavky_pocet,
    trzby_celkem,
    trzby_predchozi_mesic,
    trzby_celkem - trzby_predchozi_mesic AS trzby_zmena,
    (trzby_celkem - trzby_predchozi_mesic) * 100.0
        / NULLIF(trzby_predchozi_mesic, 0) AS trzby_zmena_pct
FROM srovnani_mesicu
ORDER BY mesic;


/* ============================================================
   3. POROVNÁNÍ SEGMENTŮ B2B A B2C

   Analytická otázka:
   Jak se liší segmenty B2B a B2C?
   ============================================================ */

SELECT
    customer_type,
    COUNT(*) AS objednavky_pocet,
    SUM(order_amount) AS trzby_celkem,
    AVG(order_amount) AS trzby_objednavka_prumer
FROM v_orders_analysis
GROUP BY customer_type
ORDER BY trzby_celkem DESC;


/* ============================================================
   4. ZÁKAZNÍCI S NEJVYŠŠÍMI TRŽBAMI V SEGMENTU

   Analytická otázka:
   Kteří zákazníci přinesli nejvyšší tržby
   zvlášť v B2B a B2C?
   ============================================================ */

WITH zakaznici_trzby AS (
    SELECT
        customer_id,
        customer_type,
        customer_name,
        SUM(order_amount) AS trzby_celkem
    FROM v_orders_analysis
    GROUP BY
        customer_id,
        customer_type,
        customer_name
),
zakaznici_poradi AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY customer_type
            ORDER BY trzby_celkem DESC
        ) AS poradi
    FROM zakaznici_trzby
)
SELECT
    customer_id,
    customer_type,
    poradi,
    customer_name,
    trzby_celkem
FROM zakaznici_poradi
WHERE poradi <= 3
ORDER BY
    customer_type,
    poradi,
    customer_id;
GO