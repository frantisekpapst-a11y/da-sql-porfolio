# 🗄️ SQL Cheatsheet — ITnetwork Lekce 1–23

MS-SQL základy • CRUD • JOIN • GROUP BY • HAVING • Transakce • View • Procedury • Triggery • Fulltext • Indexy • Cizí klíče

---

# 🎯 Praktický SQL Cheatsheet

Zaměřeno na:

* datovou analytiku
* SQL mindset
* relační databáze
* analytické dotazy
* business reporting
* práci s datasety

---

# 🧠 1. Základní pojmy

| Pojem         | Význam                       |
| ------------- | ---------------------------- |
| Databáze      | Kolekce tabulek              |
| Tabulka       | Data v řádcích a sloupcích   |
| Řádek         | Jeden záznam                 |
| Sloupec       | Jeden atribut                |
| Primární klíč | Unikátní identifikace řádku  |
| Cizí klíč     | Odkaz na jinou tabulku       |
| SQL           | Jazyk pro práci s databází   |
| CRUD          | Create, Read, Update, Delete |

---

# 🏗️ 2. CREATE TABLE

```sql
CREATE TABLE [Uzivatele]
(
    [Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Jmeno] NVARCHAR(60) NOT NULL,
    [Prijmeni] NVARCHAR(60) NOT NULL,
    [DatumNarozeni] DATE NOT NULL,
    [PocetClanku] INT NOT NULL
);
```

---

# 🔑 3. Datové typy

| Datový typ       | Použití                       |
| ---------------- | ----------------------------- |
| INT              | Celá čísla                    |
| BIGINT           | Velká celá čísla              |
| DECIMAL(10,2)    | Přesná desetinná čísla        |
| FLOAT            | Přibližná čísla               |
| BIT              | TRUE / FALSE                  |
| NVARCHAR(x)      | Unicode text                  |
| VARCHAR(x)       | Text bez Unicode              |
| CHAR(x)          | Fixní délka textu             |
| DATE             | Datum                         |
| DATETIME2        | Datum + čas s vyšší přesností |
| UNIQUEIDENTIFIER | GUID                          |

---

# 🧱 4. Důležité vlastnosti sloupců

| Vlastnost   | Význam                    |
| ----------- | ------------------------- |
| PRIMARY KEY | Unikátní identifikátor    |
| IDENTITY    | Automatické číslování     |
| NOT NULL    | Hodnota nesmí být NULL    |
| UNIQUE      | Hodnoty se nesmí opakovat |
| DEFAULT     | Výchozí hodnota           |

---

# ➕ 5. INSERT INTO

## Jeden řádek

```sql
INSERT INTO [Uzivatele]
(
    [Jmeno],
    [Prijmeni]
)
VALUES
(
    'Jan',
    'Novák'
);
```

---

## Více řádků

```sql
INSERT INTO [Uzivatele]
(
    [Jmeno],
    [Prijmeni]
)
VALUES
    ('Jan', 'Novák'),
    ('Eva', 'Černá'),
    ('Petr', 'Malý');
```

---

# 🔍 6. SELECT

```sql
SELECT *
FROM [Uzivatele];
```

```sql
SELECT
    [Jmeno],
    [Prijmeni]
FROM [Uzivatele];
```

---

# 🎯 7. WHERE

```sql
SELECT *
FROM [Uzivatele]
WHERE [PocetClanku] > 10;
```

---

# ⚙️ 8. Operátory

| Operátor | Význam           |
| -------- | ---------------- |
| =        | rovná se         |
| !=       | není rovno       |
| >        | větší            |
| <        | menší            |
| >=       | větší nebo rovno |
| <=       | menší nebo rovno |
| BETWEEN  | rozsah           |
| IN       | více hodnot      |
| LIKE     | hledání textu    |

---

# 🔗 9. AND / OR

```sql
WHERE vek > 18
AND aktivni = 1;
```

```sql
WHERE tarif = 'Premium'
OR tarif = 'Student';
```

---

# ✏️ 10. UPDATE

```sql
UPDATE [Uzivatele]
SET [PocetClanku] = 20
WHERE [Id] = 1;
```

---

# ❌ 11. DELETE

```sql
DELETE FROM [Uzivatele]
WHERE [Id] = 2;
```

⚠️ Bez WHERE smaže všechny řádky.

---

# 🧨 12. TRUNCATE TABLE

```sql
TRUNCATE TABLE [Uzivatele];
```

✅ smaže všechna data
✅ resetuje IDENTITY
✅ zachová strukturu

---

# 💥 13. DROP TABLE

```sql
DROP TABLE [Uzivatele];
```

❌ smaže data
❌ smaže strukturu

---

# 🔄 14. DELETE vs TRUNCATE vs DROP

| Příkaz   | Data      | Struktura | WHERE | Reset IDENTITY |
| -------- | --------- | --------- | ----- | -------------- |
| DELETE   | smaže     | zachová   | ANO   | NE             |
| TRUNCATE | smaže vše | zachová   | NE    | ANO            |
| DROP     | smaže vše | smaže     | NE    | ANO            |

---

# 🛡️ 15. SQL Injection

❌ Nebezpečné:

```sql
WHERE prijmeni = '" + prijmeni + "'
```

✅ Bezpečné:

```sql
WHERE prijmeni = @prijmeni
```

---

# 💾 16. Export / Import

| Typ              | Obsah            |
| ---------------- | ---------------- |
| Kompletní export | struktura + data |
| Export struktury | CREATE TABLE     |
| Export dat       | INSERT INTO      |

---

# 🧩 17. SET IDENTITY_INSERT

```sql
SET IDENTITY_INSERT [Uzivatele] ON;

INSERT INTO [Uzivatele]
(
    [Id],
    [Jmeno]
)
VALUES
(
    1,
    'Jan'
);

SET IDENTITY_INSERT [Uzivatele] OFF;
```

---

# 📚 18. CRUD

| Operace | SQL    |
| ------- | ------ |
| Create  | INSERT |
| Read    | SELECT |
| Update  | UPDATE |
| Delete  | DELETE |

---

# 🧠 19. SQL mindset

SQL říká:

👉 Co chci získat
❌ Ne jak to databáze udělá

---

# 📊 20. ORDER BY

```sql
SELECT *
FROM orders
ORDER BY amount DESC;
```

| Klíčové slovo | Význam    |
| ------------- | --------- |
| ASC           | vzestupně |
| DESC          | sestupně  |

---

# 🔢 21. Agregační funkce

```sql
COUNT(*)
SUM(amount)
AVG(amount)
MAX(amount)
MIN(amount)
```

---

# 🧮 22. GROUP BY

```sql
SELECT
    customer_id,
    SUM(amount)
FROM orders
GROUP BY customer_id;
```

👉 Každý sloupec v SELECT musí být:

* v GROUP BY
* nebo agregace

---

# 🔍 23. HAVING

```sql
SELECT
    customer_id,
    SUM(amount) AS revenue
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;
```

👉 filtruje agregace

---

# ⚡ 24. WHERE vs HAVING

| WHERE          | HAVING           |
| -------------- | ---------------- |
| filtruje řádky | filtruje skupiny |
| před GROUP BY  | po GROUP BY      |
| neumí agregace | umí agregace     |

---

# 🔗 25. JOIN

```sql
SELECT
    c.customer_name,
    o.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
```

👉 pouze shody

---

# ⬅️ 26. LEFT JOIN

```sql
SELECT
    c.customer_name,
    o.amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

👉 vše zleva + shody zprava

---

# ➡️ 27. RIGHT JOIN

👉 vše zprava + shody zleva

Používá se méně často.

---

# 🧠 28. LEFT JOIN + WHERE problém

❌ Může rozbít LEFT JOIN:

```sql
WHERE o.amount > 1000
```

✅ Zachová LEFT JOIN:

```sql
ON c.customer_id = o.customer_id
AND o.amount > 1000
```

---

# 🔢 29. COUNT(*) vs COUNT(sloupec)

```sql
COUNT(*)
```

👉 počítá řádky

```sql
COUNT(o.order_id)
```

👉 počítá pouze nenull hodnoty

---

# 🧩 30. COALESCE

```sql
COALESCE(total_orders, 0)
```

👉 NULL → 0

---

# 🏷️ 31. Aliasy

```sql
FROM customers c
JOIN orders o
SELECT c.name
```

👉 zpřehlednění dotazu

---

# ⚠️ 32. Ambiguous column name

❌

```sql
WHERE Id = customer_id
```

✅

```sql
WHERE customers.Id = orders.customer_id
```

nebo:

```sql
WHERE c.Id = o.customer_id
```

---

# 🔄 33. Vazba 1:N

1 zákazník → více objednávek

👉 cizí klíč je na straně N

---

# 🔀 34. Vazba M:N

student ↔ kurz

👉 řeší se přes vazební tabulku

---

# 🧱 35. Vazební tabulka

```sql
CREATE TABLE student_courses (
    student_id INT,
    course_id INT
);
```

---

# 🔗 36. JOIN přes vazební tabulku

```sql
SELECT
    s.name,
    c.course_name
FROM students s
JOIN student_courses sc
    ON s.student_id = sc.student_id
JOIN courses c
    ON sc.course_id = c.course_id;
```

---

# 🧠 37. Poddotaz (Subquery)

```sql
SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
);
```

👉 dotaz uvnitř dotazu

---

# 🔄 38. Korelovaný poddotaz

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT *
    FROM orders o
    WHERE c.customer_id = o.customer_id
);
```

👉 vnitřní dotaz používá vnější dotaz

---

# 🔍 39. EXISTS / NOT EXISTS

```sql
EXISTS
```

👉 testuje existenci řádku

```sql
NOT EXISTS
```

👉 testuje neexistenci

---

# 📋 40. IN

```sql
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
)
```

👉 práce s více hodnotami

---

# 📊 41. ALL / ANY

| Operátor | Význam                               |
| -------- | ------------------------------------ |
| ALL      | podmínku musí splnit všechny hodnoty |
| ANY      | stačí jedna hodnota                  |

---

# 🧱 42. Poddotaz jako tabulka

```sql
SELECT *
FROM (
    SELECT
        customer_id,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY customer_id
) t
```

👉 mezivýsledek jako dočasná tabulka

---

# 🚀 43. CTE (WITH)

```sql
WITH revenue_by_customer AS (
    SELECT
        customer_id,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY customer_id
)

SELECT *
FROM revenue_by_customer;
```

👉 pojmenovaný mezivýsledek

---

# 🧠 44. Subquery vs CTE

| Subquery                   | CTE                   |
| -------------------------- | --------------------- |
| uvnitř dotazu              | pojmenovaný blok      |
| kratší                     | čitelnější            |
| vhodné pro jednoduché věci | vhodné pro více kroků |

---

# 🔀 45. CROSS JOIN

```sql
SELECT *
FROM A
CROSS JOIN B;
```

👉 všechny kombinace všech řádků

---

# 🏗️ 46. Logické pořadí SQL

```sql
FROM
JOIN
ON
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
```

👉 SELECT běží téměř na konci

---

# ⚡ 47. Mentální model analytického SQL

```text
data
↓
JOIN
↓
mezivýpočet
↓
GROUP BY
↓
filtr
↓
výstup
```

---

# 🚀 48. Nejčastější analytické patterny

| Úloha                    | Řešení              |
| ------------------------ | ------------------- |
| zákazníci bez objednávky | LEFT JOIN + IS NULL |
| NULL → 0                 | COALESCE            |
| revenue zákazníka        | SUM + GROUP BY      |
| existence záznamu        | EXISTS              |
| práce s více hodnotami   | IN                  |
| mezivýsledek             | CTE                 |
| top hodnota              | MAX                 |
| průměr                   | AVG                 |

---

# 🧠 49. Největší posuny v SQL mindsetu

✅ SQL = práce s datasety
✅ JOIN = spojování datasetů
✅ WHERE = filtrování výsledku
✅ ON = pravidla spojování
✅ GROUP BY = agregace
✅ CTE = rozdělení problému na kroky
✅ SQL není programování krok po kroku

---

# 🧠 50. ALTER TABLE

## Přidání sloupce

```sql
ALTER TABLE [Komentare]
ADD [Palce] INT;
```

---

## Změna datového typu

```sql
ALTER TABLE [Komentare]
ALTER COLUMN [Palce] BIGINT;
```

---

## Odebrání sloupce

```sql
ALTER TABLE [Komentare]
DROP COLUMN [Palce];
```

---

# 🔢 51. DBCC CHECKIDENT

```sql
DBCC CHECKIDENT ('Uzivatele', RESEED, 1233);
```

👉 další vložené ID bude `1234`

---

# 🔄 52. Transakce

```sql
BEGIN TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT TRANSACTION;
```

👉 buď proběhne vše
👉 nebo nic

---

# ❌ 53. ROLLBACK

```sql
ROLLBACK TRANSACTION;
```

👉 vrátí databázi do původního stavu

---

# ⚡ 54. COMMIT

```sql
COMMIT TRANSACTION;
```

👉 potvrdí změny

---

# 🧠 55. ACID

| Vlastnost   | Význam             |
| ----------- | ------------------ |
| Atomicity   | vše nebo nic       |
| Consistency | konzistence dat    |
| Isolation   | oddělení transakcí |
| Durability  | trvalost dat       |

---

# 👁️ 56. VIEW

```sql
CREATE VIEW AktivniUzivatele AS
SELECT *
FROM users
WHERE active = 1;
```

👉 virtuální tabulka
👉 uložený SELECT

---

# ⚡ 57. Databázový index

```sql
CREATE INDEX I1
ON [Clanky] ([Url]);
```

👉 rychlejší vyhledávání

---

# 🚀 58. Kdy použít index

✅ WHERE
✅ JOIN
✅ ORDER BY
✅ časté filtrování

---

# ⚠️ 59. Nevýhoda indexů

❌ zpomalují:

* INSERT
* UPDATE
* DELETE

---

# 🔗 60. Vícesloupcový index

```sql
CREATE INDEX idx_user
ON users(first_name, last_name);
```

---

# 🧱 61. Normalizace

👉 rozdělení dat do správných tabulek

Cíl:

* méně duplicit
* konzistence
* škálovatelnost

---

# 💥 62. Denormalizace

👉 úmyslné porušení normalizace kvůli výkonu

---

# ⚙️ 63. Trigger

👉 automaticky spuštěný kód při změně dat

Typy:

* INSERT
* UPDATE
* DELETE

---

# 🔥 64. AFTER Trigger

```sql
AFTER INSERT
AFTER UPDATE
AFTER DELETE
```

👉 spustí se po operaci

---

# 🔄 65. INSTEAD OF Trigger

```sql
INSTEAD OF INSERT
```

👉 nahradí původní operaci

---

# 📥 66. inserted a deleted

| Pseudotabulka | Obsah         |
| ------------- | ------------- |
| inserted      | nové hodnoty  |
| deleted       | staré hodnoty |

---

# 🧠 67. DECLARE

```sql
DECLARE @pocet INT;
```

👉 deklarace proměnné

---

# ⚙️ 68. IF ELSE

```sql
IF @pocet > 10
    SELECT 'OK';
ELSE
    SELECT 'Malo';
```

---

# 📦 69. Stored Procedure

```sql
CREATE PROCEDURE GetUsers
AS
BEGIN
    SELECT * FROM users;
END;
```

👉 uložený program na serveru

---

# ▶️ 70. EXEC

```sql
EXEC GetUsers;
```

👉 spuštění procedury

---

# ✏️ 71. ALTER PROCEDURE

```sql
ALTER PROCEDURE GetUsers
AS
BEGIN
    SELECT id, name FROM users;
END;
```

---

# ❌ 72. DROP PROCEDURE

```sql
DROP PROCEDURE GetUsers;
```

---

# 📥 73. Parametry procedury

```sql
CREATE PROCEDURE AddUser
    @Name NVARCHAR(50)
AS
BEGIN
    ...
END;
```

---

# 📤 74. OUTPUT parametr

```sql
@Count INT OUT
```

👉 vrací hodnotu zpět

---

# 🧠 75. TRY CATCH

```sql
BEGIN TRY
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE();
END CATCH;
```

👉 zachytávání chyb

---

# 👤 76. LOGIN vs USER

| LOGIN             | USER               |
| ----------------- | ------------------ |
| přístup k serveru | přístup k databázi |

---

# 🔐 77. GRANT

```sql
GRANT SELECT, EXECUTE
ON DATABASE::Firma
TO test;
```

👉 přidělení oprávnění

---

# 🔄 78. EXECUTE AS USER

```sql
EXECUTE AS USER='test';
```

👉 přepnutí uživatele

---

# ↩️ 79. REVERT

```sql
REVERT;
```

👉 návrat k původnímu uživateli

---

# 🔍 80. LIKE

```sql
WHERE email LIKE '%@gmail.com'
```

| Symbol | Význam                |
| ------ | --------------------- |
| %      | libovolný počet znaků |
| _      | jeden znak            |

---

# 🚀 81. Fulltextové vyhledávání (FTS)

👉 rychlé vyhledávání v textu
👉 relevance výsledků
👉 práce s významem slov

---

# 🧱 82. Fulltextový katalog

```sql
CREATE FULLTEXT CATALOG ClankyCatalog;
```

👉 kontejner pro fulltext indexy

---

# 🔎 83. Fulltextový index

```sql
CREATE FULLTEXT INDEX ON [Clanky]
(
    [Obsah] LANGUAGE 1029
)
KEY INDEX [FulltextId]
ON [ClankyCatalog];
```

---

# 🧠 84. CONTAINS

```sql
WHERE CONTAINS([Obsah], 'hra')
```

👉 přesná fulltext shoda

---

# 🧠 85. FREETEXT

```sql
WHERE FREETEXT([Obsah], 'hra')
```

👉 významové hledání

---

# 📊 86. CONTAINSTABLE / FREETEXTTABLE

Vrací:

* KEY
* RANK

```sql
SELECT *
FROM CONTAINSTABLE(...)
```

---

# 🏆 87. RANK

👉 relevance výsledku

Čím vyšší:

👉 tím relevantnější výsledek

---

# 🌍 88. LANGUAGE 1029

```sql
LANGUAGE 1029
```

👉 český jazyk

Umožňuje:

* skloňování
* časování
* práci s kořeny slov

---

# 🔗 89. FOREIGN KEY

```sql
ALTER TABLE [Komentare]
ADD CONSTRAINT [KomentareClanek]
FOREIGN KEY (ClanekId)
REFERENCES [Clanky](Id);
```

👉 propojení parent a child tabulky

---

# 🔥 90. CASCADE

```sql
ON DELETE CASCADE
ON UPDATE CASCADE
```

👉 změna v parent tabulce se propíše do child tabulky

---

# 🧩 91. SET NULL

```sql
ON DELETE SET NULL
```

👉 FK se nastaví na NULL

---

# 🚫 92. NO ACTION

```sql
ON DELETE NO ACTION
```

👉 zabrání smazání parent záznamu

---

# ❌ 93. DROP CONSTRAINT

```sql
ALTER TABLE [Komentare]
DROP CONSTRAINT [KomentareClanek];
```

👉 smaže existující vztah

---

# 🧠 94. SQL mindset — pokročilejší úroveň

✅ databáze = optimalizace práce s datasety
✅ indexy = výkon
✅ transakce = konzistence
✅ procedury = zapouzdření logiky
✅ triggery = automatické reakce
✅ fulltext = inteligentní vyhledávání
✅ cizí klíče = integrita dat
✅ SQL není jen SELECT 🙂
