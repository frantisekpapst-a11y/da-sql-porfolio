USE sales_analysis_practice;
GO

/* ============================================================
   1. ZÁKLADNÍ NÁHLED NA DATA

   Cíl:
   Prohlédnout sloupce a ukázku načtených záznamů.

   Granularita:
   orders_raw    – jeden řádek = jedna celá objednávka.
   customers_raw – jeden řádek = jeden zákazník.
   ============================================================ */

SELECT TOP 10 *
FROM orders_raw
ORDER BY order_id;

SELECT TOP 10 *
FROM customers_raw
ORDER BY customer_id;


/* ============================================================
   2. DUPLICITY

   2.1 Kontrola obchodních identifikátorů

   Cíl:
   Ověřit, zda se order_id nebo customer_id opakuje.

   Opakované ID může znamenat přesnou duplicitu,
   ale také záznamy se stejným ID a rozdílnými údaji.
   ============================================================ */

SELECT
    order_id,
    COUNT(*) AS duplicita_order_id
FROM orders_raw
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    customer_id,
    COUNT(*) AS duplicita_customer_id
FROM customers_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;


/* ============================================================
   2.2 Kontrola shody všech obchodních sloupců

   Cíl:
   Najít přesné kopie původních obchodních záznamů.

   raw_row_id se u objednávek nekontroluje:
   je to technické ID importovaného řádku, nikoli objednávky.
   ============================================================ */

SELECT
    order_id,
    COUNT(*) AS duplicita_objednavka
FROM orders_raw
GROUP BY
    order_id,
    order_date,
    customer_id,
    order_amount
HAVING COUNT(*) > 1;

SELECT
    customer_id,
    COUNT(*) AS duplicita_zakaznik
FROM customers_raw
GROUP BY
    customer_id,
    customer_name,
    customer_type,
    region
HAVING COUNT(*) > 1;


/* ============================================================
   3. CHYBĚJÍCÍ HODNOTY

   Cíl:
   Spočítat NULL hodnoty v jednotlivých sloupcích.
   ============================================================ */

/* ============================================================
   3.1 Tabulka: orders_raw

   Očekávané hodnoty:
   order_id, order_date, customer_id, order_amount.

   raw_row_id je primární klíč a NULL nepovoluje.
   ============================================================ */

SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)
        AS chybejici_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END)
        AS chybejici_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
        AS chybejici_customer_id,
    SUM(CASE WHEN order_amount IS NULL THEN 1 ELSE 0 END)
        AS chybejici_order_amount
FROM orders_raw;


/* ============================================================
   3.2 Tabulka: customers_raw

   Pro identifikaci a segmentaci zákazníka:
   customer_id, customer_name, customer_type.

   Region:
   Chybějící region není důvodem k vyřazení zákazníka
   z analýz podle měsíců, segmentů a zákazníků.
   ============================================================ */

SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
        AS chybejici_customer_id,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END)
        AS chybejici_customer_name,
    SUM(CASE WHEN customer_type IS NULL THEN 1 ELSE 0 END)
        AS chybejici_customer_type,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END)
        AS chybejici_region
FROM customers_raw;


/* ============================================================
   4. DATOVÉ TYPY

   Cíl:
   Ověřit definované datové typy sloupců v aktuální databázi.
   ============================================================ */

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY
    TABLE_NAME,
    ORDINAL_POSITION;


/* ============================================================
   5. KATEGORIE A ZÁPIS TEXTOVÝCH HODNOT

   Cíl:
   Prohlédnout různé hodnoty typu zákazníka a regionu.
   ============================================================ */

SELECT DISTINCT
    customer_type
FROM customers_raw
ORDER BY customer_type;

SELECT DISTINCT
    region
FROM customers_raw
ORDER BY region;


/* ============================================================
   6. REFERENČNÍ INTEGRITA

   Cíl:
   Najít objednávky bez odpovídajícího zákazníka.

   Vazba:
   orders_raw.customer_id → customers_raw.customer_id.

   Unikátnost a vyplnění zákaznického ID byly ověřeny výše.
   Ve vstupních tabulkách není omezení FOREIGN KEY.
   ============================================================ */

SELECT
    o.order_id,
    o.customer_id
FROM orders_raw o
LEFT JOIN customers_raw c
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;


/* ============================================================
   7. ROZSAH DATUMŮ

   Cíl:
   Ověřit nejstarší a nejnovější datum objednávky.

   Očekávané období:
   01.01.2025 až 31.12.2025.
   ============================================================ */

SELECT
    MIN(order_date),
    MAX(order_date)
FROM orders_raw;


/* ============================================================
   8. VĚCNÁ VALIDACE ČÁSTEK

   Cíl:
   Najít nulové a záporné částky objednávek.

   Obchodní pravidlo pro tento dataset:
   Dokončená objednávka má kladnou částku.
   Vratky ani storna nejsou součástí zadání.
   ============================================================ */

SELECT
    order_id,
    order_amount
FROM orders_raw
WHERE order_amount <= 0;


/* ============================================================
   9. VÝCHOZÍ POČTY PRO REKONCILIACI

   Cíl:
   Zaznamenat stav před čištěním a později jej porovnat
   s počtem řádků v očištěných tabulkách.
   ============================================================ */

SELECT COUNT(*)
FROM orders_raw;

SELECT COUNT(*)
FROM customers_raw;
GO