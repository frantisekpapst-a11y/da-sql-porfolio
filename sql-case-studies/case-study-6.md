# SQL Case Study 08 — E-shop Orders & Transactions

Praktická SQL case study zaměřená na:
- foreign keys
- transakce
- VIEW
- indexy
- triggery
- fulltext search
- business logiku databází
- integritu dat

Inspirace: ITnetwork lekce 17–23.

---

# Zadání

Firma provozuje jednoduchý e-shop.

Potřebujeme řešit:

- zákazníky
- produkty
- objednávky
- položky objednávek
- historii mazání objednávek
- správu skladových zásob
- fulltextové vyhledávání produktů
- relace mezi tabulkami

---

# Návrh databáze

## Customers

```sql
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    City NVARCHAR(50)
);
```

---

## Products

```sql
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2),
    Stock INT
);
```

---

## Orders

```sql
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    OrderDate DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (CustomerId)
    REFERENCES Customers(CustomerId)
    ON DELETE CASCADE
);
```

---

## OrderItems

```sql
CREATE TABLE OrderItems (
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT,

    CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY (OrderId)
    REFERENCES Orders(OrderId)
    ON DELETE CASCADE,

    CONSTRAINT FK_OrderItems_Products
    FOREIGN KEY (ProductId)
    REFERENCES Products(ProductId)
    ON DELETE NO ACTION
);
```

---

# Business logika relací

## ON DELETE CASCADE

Použito mezi:

```text
Orders → OrderItems
```

Pokud smažeme objednávku:

- automaticky se smažou její položky
- nevzniknou sirotčí záznamy

---

## ON DELETE NO ACTION

Použito mezi:

```text
Products → OrderItems
```

Historie objednávek musí zůstat zachována.

Pokud by byl produkt smazán:

- nechceme rozbít historické objednávky
- nechceme ztratit revenue data
- nechceme poškodit reporting

---

# 🔄 Explicitní transakce

Při vytvoření objednávky musí proběhnout:

1. vytvoření objednávky
2. vložení položek objednávky
3. snížení skladu

Buď:

✅ všechno  
nebo  
❌ nic

```sql

BEGIN TRANSACTION;

BEGIN TRY

    INSERT INTO Orders (CustomerId)
    VALUES (1);

    INSERT INTO OrderItems (
        OrderId,
        ProductId,
        Quantity
    )
    VALUES (
        1,
        1,
        2
    );

    UPDATE Products
    SET Stock = Stock - 2
    WHERE ProductId = 1;

    COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;

END CATCH;
```

---

# VIEW pro reporting

```sql
CREATE VIEW OrderReport AS
SELECT
    o.OrderId,
    c.FullName,
    c.City,
    p.ProductName,
    oi.Quantity,
    p.Price,
    oi.Quantity * p.Price AS Revenue
FROM Orders o
JOIN Customers c
    ON o.CustomerId = c.CustomerId
JOIN OrderItems oi
    ON o.OrderId = oi.OrderId
JOIN Products p
    ON oi.ProductId = p.ProductId;
```

Použití:

```sql
SELECT *
FROM OrderReport;
```

---

# Index pro rychlejší lookup

```sql
CREATE INDEX IDX_Customers_Email
ON Customers(Email);
```

Použití:

```sql
SELECT *
FROM Customers
WHERE Email = 'jan@email.cz';
```

---

# Fulltext Search

```sql
SELECT *
FROM Products
WHERE CONTAINS(Description, 'notebook');
```

## LIKE vs CONTAINS

### LIKE

```sql
LIKE '%notebook%'
```

- obyčejné textové hledání
- substring matching

### CONTAINS

```sql
CONTAINS()
```

- fulltext engine
- relevance výsledků
- práce s jazykem
- efektivnější pro větší texty

---

# Trigger — historie mazání objednávek

## History Table

```sql
CREATE TABLE DeletedOrdersHistory (
    OrderId INT,
    DeletedAt DATETIME2
);
```

## AFTER DELETE Trigger

```sql
CREATE TRIGGER AfterDeleteOrder
ON Orders
AFTER DELETE
AS
BEGIN

    INSERT INTO DeletedOrdersHistory (
        OrderId,
        DeletedAt
    )
    SELECT
        OrderId,
        GETDATE()
    FROM deleted;

END;
```

---

# 🔒 Foreign Key Protection

```sql
DELETE FROM Products
WHERE ProductId = 1;
```

Skončí chybou kvůli:

```sql
ON DELETE NO ACTION
```

Databáze chrání integritu dat.

---

# Procvičené koncepty

## Databázový design

- parent / child tabulky
- foreign keys
- integrita dat

## Transakce

- BEGIN TRANSACTION
- COMMIT
- ROLLBACK
- TRY / CATCH

## Reporting

- VIEW
- JOIN
- revenue výpočty

## Performance

- INDEX
- lookup optimalizace

## Automatizace

- AFTER DELETE trigger
- historie mazání

## Fulltext Search

- CONTAINS
- fulltext mindset

---

# SQL Mindset

Tato case study propojuje:

- business logiku
- integritu dat
- reporting
- bezpečnost
- výkon databáze
- analytické přemýšlení

Cílem není jen znát syntax SQL, ale chápat:

👉 jak databáze funguje v reálném business prostředí.