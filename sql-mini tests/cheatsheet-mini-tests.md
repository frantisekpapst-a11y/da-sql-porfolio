📘 SQL Mini Testy — Kompletní sada (Lekce 1–23)

1.

K čemu slouží PRIMARY KEY?

✅ Jednoznačně identifikuje řádek.

2.

Jaký je rozdíl mezi INT a BIGINT?

✅ BIGINT ukládá větší čísla.

3.

Proč se používá IDENTITY?

✅ Automatické generování ID.

4.

Kdy použít NVARCHAR místo VARCHAR?

✅ Když potřebujeme Unicode.

5.

Co znamená NOT NULL?

✅ Hodnota musí být vyplněna.

6.

Jaký datový typ použiješ pro ceny?

✅ DECIMAL(10,2)

7.

K čemu slouží DEFAULT?

✅ Nastaví výchozí hodnotu.

8.

Co znamená UNIQUE?

✅ Hodnoty se nesmí opakovat.

9.

Jaký typ použiješ pro TRUE/FALSE?

✅ BIT

10.

Rozdíl DATETIME vs DATETIME2?

✅ DATETIME2 je přesnější a modernější.

11.

Jak vložíš více řádků?

✅ VALUES (...), (...)

12.

Proč je lepší vypisovat názvy sloupců?

✅ Bezpečnost a čitelnost.

13.

Co se stane při špatném počtu hodnot?

✅ SQL vrátí chybu.

14.

K čemu slouží SET IDENTITY_INSERT?

✅ Ruční vložení IDENTITY hodnoty.

15.

Jaký je rozdíl mezi INSERT a UPDATE?

✅ INSERT vytváří nový řádek.

16.

Může INSERT fungovat bez názvů sloupců?

✅ Ano, ale musí sedět pořadí.

17.

Co je bezpečnější?

✅ Explicitní názvy sloupců.

18.

Co je špatně na:

INSERT INTO Users VALUES ('Jan');

✅ Chybí další povinné hodnoty.

19.

Jak vložíš NULL?

✅ NULL

20.

Jak vložíš datum?

✅ '2025-01-01'

21.

Co dělá UPDATE?

✅ Mění existující data.

22.

Proč je UPDATE bez WHERE nebezpečný?

✅ Změní všechny řádky.

23.

Jak zvýšíš hodnotu o 1?

✅ SET x = x + 1

24.

Lze měnit více sloupců najednou?

✅ Ano.

25.

Jak odděluješ více sloupců?

✅ Čárkou.

26.

Co je špatně?

UPDATE users WHERE id = 1;

✅ Chybí SET.

27.

Může UPDATE používat výpočty?

✅ Ano.

28.

Jak nastavíš NULL?

✅ SET column = NULL

29.

Rozdíl UPDATE vs ALTER TABLE?

✅ UPDATE mění data, ALTER strukturu.

30.

Co vrátí UPDATE?

✅ Počet upravených řádků.

31.

Co dělá DELETE?

✅ Maže řádky.

32.

Co dělá TRUNCATE?

✅ Rychle smaže všechna data.

33.

Co dělá DROP TABLE?

✅ Smaže data i strukturu.

34.

Který příkaz resetuje IDENTITY?

✅ TRUNCATE

35.

Který příkaz může mít WHERE?

✅ DELETE

36.

Rozdíl DELETE vs TRUNCATE?

✅ DELETE může mít WHERE.

37.

Rozdíl TRUNCATE vs DROP?

✅ DROP smaže strukturu.

38.

Který příkaz je nejrychlejší?

✅ TRUNCATE

39.

Co je nebezpečné na:

DELETE FROM users;

✅ Smaže všechny řádky.

40.

Kdy použít DROP TABLE?

✅ Když tabulku už nepotřebujeme.

41.

Co znamená CRUD?

✅ Create Read Update Delete.

42.

Jaká operace je Read?

✅ SELECT

43.

Jaká operace je Create?

✅ INSERT

44.

Jaká operace je Update?

✅ UPDATE

45.

Jaká operace je Delete?

✅ DELETE

46.

Co je DDL?

✅ CREATE ALTER DROP

47.

Co je DML?

✅ INSERT UPDATE DELETE SELECT

48.

Které příkazy mění strukturu?

✅ CREATE ALTER DROP

49.

Které příkazy pracují s daty?

✅ CRUD operace.

50.

Co je SQL mindset?

✅ Říkáme co chceme, ne jak.

51.

Co dělá SELECT?

✅ Vybírá data.

52.

Co dělá WHERE?

✅ Filtruje řádky.

53.

Co znamená % v LIKE?

✅ Libovolný počet znaků.

54.

Co znamená _ v LIKE?

✅ Jeden znak.

55.

Kdy použiješ IN?

✅ Pro více hodnot.

56.

Kdy použiješ BETWEEN?

✅ Pro rozsah.

57.

Co vrací TOP?

✅ Omezený počet řádků.

58.

Co vrací DISTINCT?

✅ Unikátní hodnoty.

59.

Jak se kontroluje NULL?

✅ IS NULL

60.

Co znamená DESC?

✅ Sestupné řazení.

61.

Co dělá GROUP BY?

✅ Seskupuje data.

62.

Rozdíl WHERE vs HAVING?

✅ HAVING filtruje agregace.

63.

Co vrací COUNT(*)?

✅ Počet řádků.

64.

Co dělá AVG()?

✅ Průměr.

65.

Co dělá SUM()?

✅ Součet.

66.

Co dělá MIN()?

✅ Nejnižší hodnota.

67.

Co dělá MAX()?

✅ Nejvyšší hodnota.

68.

Kdy musíš použít GROUP BY?

✅ Když kombinuješ agregace s běžnými sloupci.

69.

Co je špatně?

SELECT name, COUNT(*)
FROM users;

✅ Chybí GROUP BY.

70.

HAVING běží před nebo po GROUP BY?

✅ Po GROUP BY.

71.

K čemu slouží JOIN?

✅ Spojuje tabulky.

72.

Rozdíl INNER vs LEFT JOIN?

✅ LEFT vrací vše zleva.

73.

Jak najdeš zákazníky bez objednávky?

✅ LEFT JOIN + IS NULL.

74.

K čemu slouží ON?

✅ Definuje spojení.

75.

Co je M:N vztah?

✅ Více k více.

76.

Jak řešíme M:N?

✅ Vazební tabulkou.

77.

Kde je FK u 1:N?

✅ Na straně N.

78.

Co je ambiguous column?

✅ Nejednoznačný název sloupce.

79.

Jak řešíme ambiguous column?

✅ Aliasem/tabulkou.

80.

Co dělá COALESCE?

✅ NULL → hodnota.

81.

Co je poddotaz?

✅ Dotaz uvnitř dotazu.

82.

Co dělá EXISTS?

✅ Test existence.

83.

Co dělá NOT EXISTS?

✅ Test neexistence.

84.

Výhoda CTE?

✅ Lepší čitelnost.

85.

Co je korelovaný poddotaz?

✅ Používá vnější dotaz.

86.

Co vrací IN?

✅ Test více hodnot.

87.

Rozdíl subquery vs CTE?

✅ CTE je pojmenovaný blok.

88.

Co dělá CROSS JOIN?

✅ Všechny kombinace.

89.

Co je analytický mezivýsledek?

✅ CTE/subquery.

90.

Proč používat CTE?

✅ Rozdělení problému.

91.

K čemu slouží ALTER TABLE?

✅ Změna struktury.

92.

K čemu slouží index?

✅ Zrychlení SELECT.

93.

Nevýhoda indexů?

✅ Zpomalení INSERT/UPDATE/DELETE.

94.

Co je VIEW?

✅ Virtuální tabulka.

95.

Výhoda VIEW?

✅ Zjednodušení složitých dotazů.

96.

Co je transakce?

✅ Skupina dotazů jako jeden celek.

97.

Co dělá COMMIT?

✅ Potvrdí změny.

98.

Co dělá ROLLBACK?

✅ Vrátí změny.

99.

Co znamená Atomicity?

✅ Všechno nebo nic.

100.

Výchozí isolation level?

✅ READ COMMITTED.

101.

Na co trigger nereaguje?

✅ SELECT

102.

Co je AFTER trigger?

✅ Trigger po operaci.

103.

Co je INSTEAD OF trigger?

✅ Nahrazuje operaci.

104.

K čemu slouží inserted?

✅ Nové hodnoty.

105.

K čemu slouží deleted?

✅ Staré/smazané hodnoty.

106.

Jak deklaruješ proměnnou?

✅ DECLARE

107.

K čemu slouží IF ELSE?

✅ Podmíněná logika.

108.

Co je statement-level trigger?

✅ Trigger pro celý statement.

109.

HAVING filtruje co?

✅ Agregované skupiny.

110.

WHERE může obsahovat agregace?

✅ Ne.

111.

Co je stored procedure?

✅ Uložený program.

112.

Jak spustíš proceduru?

✅ EXEC

113.

Jak smažeš proceduru?

✅ DROP PROCEDURE

114.

Co je OUTPUT parametr?

✅ Vrací hodnotu.

115.

K čemu slouží TRY CATCH?

✅ Zachytávání chyb.

116.

Může procedura obsahovat IF?

✅ Ano.

117.

Může procedura obsahovat LOOP?

✅ Ano.

118.

Výhoda procedur?

✅ Zapouzdření logiky.

119.

Co je EXECUTE AS USER?

✅ Přepnutí uživatele.

120.

Co dělá REVERT?

✅ Návrat uživatele.

121.

Rozdíl LOGIN vs USER?

✅ LOGIN = server, USER = databáze.

122.

K čemu slouží CONTAINS?

✅ Přesná fulltext shoda.

123.

K čemu slouží FREETEXT?

✅ Významové hledání.

124.

Co je FULLTEXT INDEX?

✅ Index pro textové hledání.

125.

Co je RANK?

✅ Relevance výsledku.

126.

Co je LANGUAGE 1029?

✅ Český jazyk.

127.

Co umožňuje fulltext?

✅ Hledání významu slov.

128.

Co vytvoří CREATE LOGIN?

✅ Serverový login.

129.

Co vytvoří CREATE USER?

✅ Databázového uživatele.

130.

Co dělá GRANT?

✅ Přiděluje oprávnění.

131.

Co je FOREIGN KEY?

✅ Odkaz na jinou tabulku.

132.

K čemu slouží FK?

✅ Integrita dat.

133.

Co jsou sirotčí záznamy?

✅ Child bez parent.

134.

Co dělá CASCADE?

✅ Automaticky smaže/upraví child data.

135.

Co dělá SET NULL?

✅ Nastaví FK na NULL.

136.

Co dělá NO ACTION?

✅ Zabrání změně.

137.

Co dělá SET DEFAULT?

✅ Nastaví default hodnotu.

138.

Kdo je parent tabulka?

✅ Nadřízená tabulka.

139.

Kdo je child tabulka?

✅ Podřízená tabulka.

140.

Jak smažeš constraint?

✅ ALTER TABLE DROP CONSTRAINT.
