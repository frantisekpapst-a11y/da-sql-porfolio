# 🗄️ Data Analytics SQL Portfolio

Portfolio zaměřené na **SQL, relační databáze, analytické dotazy, business reporting a databázové workflow**.

Repozitář obsahuje praktické case studies, SQL příklady a referenční materiály pokrývající práci s relačními daty od základních CRUD operací přes JOINy a agregace až po pokročilejší databázové objekty, transakce, fulltextové vyhledávání a analytické SQL patterny.

Hlavní oblasti:
- relační databáze a datový model,
- SQL querying,
- JOINy a práce s vazbami,
- agregace a business reporting,
- subqueries, `EXISTS` a CTE,
- VIEW a reusable reporting logic,
- transakce a databázová integrita,
- triggery a procedury,
- indexy a performance mindset,
- fulltextové vyhledávání,
- analytické SQL workflow.

---

# 📂 Struktura repozitáře

```text
da-sql-portfolio/
│
├── sql-case-studies/
│   ├── case-study-1.md
│   ├── case-study-2.md
│   ├── case-study-3.md
│   ├── case-study-4.md
│   ├── case-study-5.md
│   ├── case-study-6.md
│   └── sql-case-studies-original/
│
├── sql-cheatsheets/
│   ├── cheatsheet-certification.md
│   └── cheatsheet-original.md
│
├── sql-examples/
│   ├── examples-certification
│   └── examples-fiddle
│
├── sql-mini-tests/
│   └── cheatsheet-mini-tests.md
│
└── README.md
```

---

# 🎯 Zaměření portfolia

Repozitář demonstruje práci se SQL v rámci analytického a databázového workflow:

```text
Business Question
→ Relational Data
→ Query Logic
→ Validation
→ Aggregation / Transformation
→ Analysis
→ Reporting
→ Interpretation
```

Důraz je kladen nejen na syntaxi SQL, ale také na:

- správné pochopení vztahů mezi tabulkami,
- práci s primárními a cizími klíči,
- volbu vhodného typu JOINu,
- tvorbu analytických dotazů,
- validaci výsledků,
- porovnávání různých SQL přístupů,
- business interpretaci výstupů,
- databázovou konzistenci,
- opakovatelnost a čitelnost SQL řešení.

---

# 📁 Case Studies

Case studies jsou prezentovány **od nejpokročilejšího a nejreprezentativnějšího projektu po jednodušší SQL úlohy**.

Důvodem je portfolio-oriented prezentace, kdy je na prvním místě projekt, který nejlépe reprezentuje aktuální úroveň zkušeností a práce se SQL, databázovým návrhem, business logikou a pokročilejšími databázovými koncepty. Původní číslování zůstává zachováno a zároveň dokumentuje vývoj jednotlivých témat.

> Složka `sql-case-studies-original` obsahuje starší samostatné SQL úlohy vytvořené před hlavní sérií case studies. Hlavní část portfolia tvoří šest níže uvedených projektů.

---

## Case Study 06 — E-shop Orders & Transactions

Nejkomplexnější SQL case study v repozitáři propojující databázový návrh, integritu dat, transakční logiku, reporting a pokročilejší databázové funkce.

Použité koncepty:

- `FOREIGN KEY`,
- `ON DELETE CASCADE`,
- `ON DELETE NO ACTION`,
- `VIEW`,
- `INDEX`,
- transakce,
- `COMMIT`,
- `ROLLBACK`,
- triggery,
- fulltext search,
- databázová integrita,
- audit logika.

Business témata:

- e-shop objednávky,
- skladové zásoby,
- integrita dat,
- audit mazání objednávek,
- revenue reporting,
- databázová konzistence.

Projekt ukazuje, jak se SQL používá nejen pro analytické dotazy, ale také pro bezpečné řízení datových operací v relační databázi.

➡️ [Otevřít Case Study 06](sql-case-studies/case-study-6.md)

---

## Case Study 05 — Fulltext Search & Reporting

Case study zaměřená na fulltextové vyhledávání a reporting nad textovými daty.

Použité koncepty:

- `CONTAINS`,
- `FREETEXT`,
- `CONTAINSTABLE`,
- `FREETEXTTABLE`,
- `VIEW`,
- agregace,
- relevance výsledků.

Business témata:

- vyhledávání produktů,
- textová analytika,
- relevance výsledků,
- reporting nad vyhledáváním.

Projekt ukazuje rozdíl mezi běžným filtrováním textu a specializovaným fulltextovým vyhledáváním.

➡️ [Otevřít Case Study 05](sql-case-studies/case-study-5.md)

---

## Case Study 04 — Database Automation & Triggers

Projekt zaměřený na automatizaci databázových procesů pomocí triggerů a procedur.

Použité koncepty:

- triggery,
- `inserted`,
- `deleted`,
- procedury,
- `TRY / CATCH`,
- `DECLARE`,
- `IF / ELSE`,
- audit logika,
- automatizace databázových operací.

Business témata:

- audit změn,
- historie operací,
- databázová automatizace,
- implementace business pravidel.

Cílem je ukázat, jak lze přesunout opakovatelnou databázovou logiku blíže k datové vrstvě.

➡️ [Otevřít Case Study 04](sql-case-studies/case-study-4.md)

---

## Case Study 03 — SQL Reporting & Relational Analysis

Case study zaměřená na práci s více propojenými tabulkami a analytickými SQL patterny.

Použité koncepty:

- `INNER JOIN`,
- `LEFT JOIN`,
- `EXISTS`,
- `NOT EXISTS`,
- subqueries,
- CTE,
- M:N relationships,
- vazební tabulky.

Business témata:

- customer reporting,
- revenue analýza,
- identifikace zákazníků bez objednávek,
- produktové kategorie,
- práce s relačním modelem.

Projekt ukazuje více způsobů, jak řešit analytické otázky nad propojenými daty.

➡️ [Otevřít Case Study 03](sql-case-studies/case-study-3.md)

---

## Case Study 02 — E-commerce Product Analytics

Projekt zaměřený na produktovou analytiku a business reporting nad e-commerce daty.

Použité koncepty:

- `SELECT`,
- `WHERE`,
- `GROUP BY`,
- `HAVING`,
- agregace,
- filtrování agregovaných výsledků,
- business reporting.

Business témata:

- produktová analytika,
- skladová analytika,
- revenue reporting,
- cenová analýza.

Projekt ukazuje přechod od jednoduchých SQL dotazů k analytickému reportingu.

➡️ [Otevřít Case Study 02](sql-case-studies/case-study-2.md)

---

## Case Study 01 — Fitness Center Membership Management

Case study zaměřená na základní práci s relační databází a CRUD operacemi.

Použité koncepty:

- `CREATE TABLE`,
- `INSERT`,
- `UPDATE`,
- `DELETE`,
- `WHERE`,
- datové typy,
- základní business logika.

Business témata:

- správa zákazníků,
- členství,
- změny tarifů,
- filtrování aktivních členů.

Projekt tvoří základ pro navazující analytické a databázové scénáře.

➡️ [Otevřít Case Study 01](sql-case-studies/case-study-1.md)

---

# 🧩 SQL Skills

Portfolio pokrývá praktickou práci s SQL od základního queryingu až po pokročilejší databázové scénáře.

Hlavní oblasti:

- `SELECT`, `WHERE`, `ORDER BY`, `TOP`, `LIKE`, `IN`, `BETWEEN`,
- `INSERT`, `UPDATE`, `DELETE`,
- primary keys, foreign keys a relační vazby,
- `INNER JOIN`, `LEFT JOIN`,
- agregace, `GROUP BY`, `HAVING`,
- subqueries,
- `EXISTS`, `NOT EXISTS`,
- CTE,
- `VIEW`,
- transakce, `COMMIT`, `ROLLBACK`,
- ACID principy,
- triggery,
- stored procedures,
- `TRY / CATCH`,
- indexy,
- fulltext search,
- referenční integrita,
- business reporting,
- analytické SQL patterny.

Důraz je kladen na:

```text
správnou logiku dotazu
→ validaci výsledků
→ čitelnost řešení
→ business interpretaci
```

Detailní syntaxe, příklady a poznámky jsou součástí SQL cheatsheetů a examples sekce repozitáře.

---

# 📂 SQL Examples

## examples-certification

Praktické SQL příklady pokrývající například:

- `CREATE DATABASE`,
- `CREATE TABLE`,
- `INSERT`,
- `UPDATE`,
- `DELETE`,
- `TRUNCATE`,
- `DROP`,
- `SELECT`,
- `WHERE`,
- `LIKE`,
- `IN`,
- `BETWEEN`,
- `ORDER BY`,
- `TOP`,
- agregace,
- `GROUP BY`,
- `HAVING`,
- JOINy,
- subqueries,
- `EXISTS`,
- CTE,
- `ALTER TABLE`,
- `VIEW`,
- indexy,
- transakce,
- triggery,
- procedury,
- fulltext search,
- foreign keys.

➡️ [SQL Certification Examples](sql-examples/examples-certification)

---

## examples-fiddle

Samostatné SQL playground příklady a experimenty zaměřené na:

- testování SQL syntaxe,
- JOIN logiku,
- agregace,
- analytické patterny,
- business reporting,
- debugging dotazů,
- databázové modelování,
- porovnávání variant řešení.

➡️ [SQL Fiddle Examples](sql-examples/examples-fiddle)

---

# 📚 Knowledge Base

## sql-cheatsheets

Repozitář obsahuje dvě SQL reference.

### Certification Cheatsheet

[cheatsheet-certification.md](sql-cheatsheets/cheatsheet-certification.md)

Obsahuje například:

- SQL syntax,
- JOINy,
- agregace,
- subqueries,
- CTE,
- VIEW,
- triggery,
- procedury,
- transakce,
- fulltext search,
- indexy,
- foreign keys.

### Original Cheatsheet

[cheatsheet-original.md](sql-cheatsheets/cheatsheet-original.md)

Rozšířená vlastní SQL reference zaměřená například na:

- analytické SQL patterny,
- business reporting,
- customer analytics,
- revenue reporting,
- debugging,
- performance mindset,
- databázové best practices.

---

## sql-mini-tests

Sada znalostních testů zaměřených na:

- JOINy,
- agregace,
- business scénáře,
- SQL debugging,
- foreign keys,
- transakce,
- rozdíly mezi SQL patterny,
- databázovou logiku.

➡️ [SQL Mini Tests](sql-mini-tests/)

---

# 🛠 Technologie a koncepty

```text
Microsoft SQL Server
T-SQL
Relational Databases
CRUD
Primary Keys
Foreign Keys
JOINs
Aggregations
Subqueries
CTE
Views
Transactions
Triggers
Stored Procedures
Indexes
Fulltext Search
Business Reporting
Data Analytics
Git
GitHub
```

Pro experimentování a rychlé testování SQL jsou využívána také online SQL prostředí.