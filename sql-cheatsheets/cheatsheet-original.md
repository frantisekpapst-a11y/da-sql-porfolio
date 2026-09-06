# 📘 SQL Basics – Data Analyst Cheat Sheet (v11)

---

## 🧠 1. Struktura SQL dotazu

```sql
SELECT co_chci_videt
FROM odkud_beru_data
WHERE podminka
GROUP BY seskupeni
HAVING podminka_na_skupiny
ORDER BY razeni;

👉 „Vyber → odkud → filtruj → seskup → filtruj skupiny → seřaď“

⚡ 2. Logické pořadí SQL
FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY

👉 SELECT běží téměř na konci
👉 aliasy nefungují ve WHERE

✍️ 3. Syntaxe
, → odděluje sloupce
; → konec dotazu
poslední sloupec → bez čárky

📊 4. Datové typy
customer_id INT
name VARCHAR(50)
date DATE
price DECIMAL(10,2)
typ	význam
INT	celé číslo
VARCHAR(n)	text
DATE	datum
DECIMAL	desetinné číslo

📊 5. SELECT
SELECT * FROM orders;

🎯 6. WHERE
WHERE amount > 400

👉 filtruje řádky před agregací

🔢 7. Agregace
COUNT(*)        -- všechny řádky
COUNT(col)      -- bez NULL
SUM(amount)
AVG(amount)
MAX(amount)
MIN(amount)

📊 8. GROUP BY
SELECT customer_id, SUM(amount)
FROM orders
GROUP BY customer_id;

👉 každý sloupec v SELECT musí být:

v GROUP BY
nebo agregace

🔎 9. HAVING
HAVING SUM(amount) > 1000

👉 filtruje skupiny po agregaci

🧠 10. WHERE vs HAVING
WHERE	HAVING
filtruje řádky	filtruje skupiny
před GROUP BY	po GROUP BY

🔗 11. JOIN
JOIN customers c
    ON o.customer_id = c.customer_id

👉 jen shody

⬅️ 12. LEFT JOIN
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id

👉 vše zleva + shody zprava + NULL

🧠 13. LEFT JOIN – WHERE vs ON

❌ může zrušit LEFT JOIN:

WHERE o.amount > 400

✅ zachová LEFT JOIN:

ON c.customer_id = o.customer_id
AND o.amount > 400

🧠 14. Zákazníci bez objednávky
SELECT c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

🧠 15. COUNT u LEFT JOIN
výraz	význam
COUNT(*)	všechny řádky
COUNT(o.order_id)	jen existující objednávky

🧠 16. Alias pravidla
část	funguje
SELECT	✅
WHERE	❌
HAVING	⚠️ v MySQL často ano
ORDER BY	✅

🧠 17. Alias + WHERE problém

❌ nefunguje:

SELECT
    revenue * 2 AS doubled
FROM sales
WHERE doubled > 100;

✅ řešení přes CTE:

WITH base AS (
    SELECT
        revenue,
        revenue * 2 AS doubled
    FROM sales
)
SELECT *
FROM base
WHERE doubled > 100;

🧱 18. Subquery
SELECT *
FROM (
    SELECT ..., ROW_NUMBER() AS rn
) t
WHERE rn = 1;

🔥 19. CTE / WITH
WITH base AS (
    SELECT ...
)
SELECT *
FROM base;

👉 pojmenovaný mezivýsledek
👉 čitelnější než složité subquery

Více kroků:

WITH base AS (...),
metrics AS (...),
final AS (...)
SELECT *
FROM final;

📦 20. Výpočty
SUM(quantity * price)

👉 nejdřív výpočet na řádku, potom agregace

🧠 21. COALESCE
COALESCE(SUM(amount), 0)

👉 NULL → 0

🔥 22. CASE WHEN
CASE
    WHEN condition THEN 'value'
    ELSE 'value'
END AS segment

👉 může používat více sloupců
👉 vrací jeden nový sloupec

🧠 23. DISTINCT
SELECT DISTINCT customer
FROM sales;

👉 vrátí unikátní hodnoty

situace	použij
chci unikátní hodnoty	DISTINCT
chci počítat / agregovat	GROUP BY

🧠 24. JOIN logika
customers → orders → order_items → products

👉 zákazník má objednávky
👉 objednávka má položky
👉 položka má produkt

🔥 25. TOP per group
ROW_NUMBER() OVER (
    PARTITION BY customer
    ORDER BY revenue DESC
) AS rn
WHERE rn = 1

🧠 26. ROW_NUMBER vs RANK
funkce	chování
ROW_NUMBER()	rozbije remízy
RANK()	zachová remízy

🔥 27. MAX + JOIN pattern

👉 vrací všechny top hodnoty při shodě

WITH revenue_by_category AS (...)
SELECT *
FROM revenue_by_category r
JOIN (
    SELECT customer, MAX(total_revenue) AS max_revenue
    FROM revenue_by_category
    GROUP BY customer
) m
    ON r.customer = m.customer
   AND r.total_revenue = m.max_revenue;

🚀 28. WINDOW FUNCTIONS

👉 agregace bez ztráty řádků

Total vedle řádku
SUM(revenue) OVER (PARTITION BY customer)
Podíl %
revenue * 100.0 / SUM(revenue) OVER (PARTITION BY customer)
Podíl na celku
revenue * 100.0 / SUM(revenue) OVER ()
Running total
SUM(revenue) OVER (
    PARTITION BY customer
    ORDER BY date
)
MAX ve skupině
MAX(revenue) OVER (PARTITION BY customer)

🔥 29. LAG / LEAD
LAG(revenue) OVER (
    PARTITION BY customer
    ORDER BY date
)

👉 předchozí hodnota

LEAD(revenue) OVER (...)

👉 následující hodnota

📈 30. Revenue change
revenue - prev_revenue AS revenue_change
(revenue - prev_revenue) * 100.0 / prev_revenue AS pct_change

👉 100.0 zajistí desetinný výpočet

🗓️ 31. Activity / gap analysis
DATEDIFF(date, prev_date) AS days_since_prev
CASE
    WHEN prev_date IS NULL THEN 'new'
    WHEN days_since_prev > 45 THEN 'inactive_gap'
    ELSE 'active'
END AS status

⚡ 32. Mentální model
data → mezivýpočet → business logika → filtr → výstup

🚀 33. Rychlé rozhodování
otázka	řešení
kolik	COUNT
celkem	SUM
průměr	AVG
max	MAX
kdo nemá	LEFT JOIN + IS NULL
NULL → 0	COALESCE
segmentace	CASE WHEN
top 1	ROW_NUMBER
top s remízami	RANK
předchozí hodnota	LAG
mezivýsledek	CTE
rozdíl dat	DATEDIFF

🧠 34. SQL mindset

👉 SQL = popis výsledku
👉 ne krokové programování

Ptej se:

Co chci vidět?
Z jakých tabulek?
Co musím spočítat?
Potřebuji mezivýsledek?
Filtruji řádky, nebo agregace?
