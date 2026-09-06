# Case Study 01 — Fitness Center Membership Management

## Cíl projektu

Procvičit základní SQL operace na realistickém business scénáři.

Projekt simuluje databázi fitness centra, ve které spravujeme členy,
jejich tarify a aktivitu.

Case study je zaměřena na:

- vytváření tabulek
- vkládání dat
- úpravu dat
- mazání dat
- filtrování dat pomocí WHERE
- pochopení business logiky v SQL

---

# Procvičené dovednosti

- CREATE TABLE
- INSERT INTO
- UPDATE
- DELETE
- SELECT
- WHERE
- základní business logika
- filtrování datasetu

---

# Business scénář

Fitness centrum eviduje své členy v databázi.

Management se rozhodl:

1. nahradit tarif „Basic“ tarifem „Standard“
2. odstranit neaktivní členy
3. analyzovat Premium zákazníky samostatně

---

# Dataset

```sql
CREATE TABLE [Clenove]
(
    [Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Jmeno] NVARCHAR(50) NOT NULL,
    [Vek] INT NOT NULL,
    [Tarif] NVARCHAR(30) NOT NULL,
    [Aktivni] INT NOT NULL
);

INSERT INTO [Clenove]
(
    [Jmeno],
    [Vek],
    [Tarif],
    [Aktivni]
)
VALUES
    ('Jan', 28, 'Premium', 1),
    ('Eva', 34, 'Basic', 1),
    ('Petr', 19, 'Student', 1),
    ('Lucie', 41, 'Premium', 0),
    ('Adam', 25, 'Basic', 1);
```

---

# Zadání

## 1. Nahrazení tarifu Basic tarifem Standard

```sql
UPDATE [Clenove]
SET [Tarif] = 'Standard'
WHERE [Tarif] = 'Basic';
```

---

## 2. Odstranění neaktivních členů

```sql
DELETE FROM [Clenove]
WHERE [Aktivni] = 0;
```

---

## 3. Výpis členů starších než 30 let

```sql
SELECT *
FROM [Clenove]
WHERE [Vek] > 30;
```

---

## 4. Zvýšení věku Petra o 1 rok

```sql
UPDATE [Clenove]
SET [Vek] = [Vek] + 1
WHERE [Jmeno] = 'Petr';
```

---

## 5. Výpis členů s tarifem Standard

```sql
SELECT *
FROM [Clenove]
WHERE [Tarif] = 'Standard';
```

---

# Očekávaný výsledek

## Členové s tarifem Standard

| Id | Jmeno | Vek | Tarif | Aktivni |
|----|--------|-----|--------|----------|
| 2 | Eva | 34 | Standard | 1 |
| 5 | Adam | 25 | Standard | 1 |

---

# Co jsem se naučil

- SQL příkazy mohou trvale měnit data
- WHERE je klíčový pro bezpečné UPDATE a DELETE
- SQL řeší reálné business problémy
- pořadí SQL příkazů ovlivňuje výsledná data
- UPDATE mění existující data
- DELETE odstraňuje záznamy
- SELECT slouží pro získávání a filtrování dat

---

# Využití v praxi

Tato case study simuluje běžné úkoly junior datového analytika nebo databázového specialisty:

- správa zákazníků
- změny tarifů
- odstraňování neaktivních uživatelů
- implementace business pravidel
- základní analytické filtrování.