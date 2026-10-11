# Hlavní zjištění a doporučení

## 1. Jak se během roku vyvíjely objednávky a tržby?

### Vývoj během roku
- **Nejvyšší měsíční tržby měl prosinec: 610 328,50 Kč** při 111 objednávkách.
- **Nejvíce objednávek bylo v listopadu: 114**, přesto byly listopadové tržby nižší než prosincové.
- Průměrná hodnota objednávky činila v listopadu cca **4 023 Kč**, v prosinci **5 498 Kč**.
- **Největší meziměsíční procentní růst nastal v září: +75,29 %**.
- **Největší meziměsíční procentní pokles nastal v srpnu: −24,81 %**.
- Srpen měl zároveň nejnižší měsíční tržby: **263 936,50 Kč**.
- U ledna nelze meziměsíční změnu vypočítat, protože prosinec 2024 není součástí dat.

### Popisná statistika v Excelu
Statistika byla vypočtena z **12 měsíčních součtů tržeb**, nikoli z jednotlivých objednávek.

| Ukazatel                      | Hodnota       |
| Průměrné měsíční tržby        | 416 728,48 Kč |
| Medián měsíčních tržeb        | 406 194,13 Kč |
| Výběrová směrodatná odchylka  | 107 953,56 Kč |
| Minimum                       | 263 936,50 Kč |
| Maximum                       | 610 328,50 Kč |
| Rozdíl maximum–minimum        | 346 392,00 Kč |
| Šikmost                       | 0,75          |
| Počet pozorování              | 12 měsíců     |

Průměr byl vyšší než medián. Silné měsíce - zejména říjen a prosinec - posouvaly průměr nahoru. Kladná šikmost odpovídá rozdělení s vyššími hodnotami na pravé straně. Směrodatná odchylka popisuje kolísání měsíčních tržeb kolem průměru.

### Souvislost počtu objednávek a tržeb

Mezi měsíčním počtem objednávek a tržbami byla **silná kladná souvislost: Pearsonův korelační koeficient r = 0,83**.

Bodový graf s lineární spojnicí trendu vykázal **R² = 0,6894**. Lineární model s počtem objednávek jako vysvětlující proměnnou zachytil přibližně **69 % variability měsíčních tržeb v těchto 12 pozorováních**.

Tržby jsou součinem počtu objednávek a jejich průměrné hodnoty. Vyšší počet objednávek proto nemusí znamenat vyšší tržby, jak ukazuje srovnání listopadu a prosince.

### Doporučení

- Sledovat společně **tržby, počet objednávek a průměrnou hodnotu objednávky**.
- V reálných datech prověřit srpnový pokles a následný zářijový růst, například podle segmentů a konkrétních objednávek.
- Pro posouzení opakující se sezónnosti doplnit další roky. Jeden rok její potvrzení neumožňuje.

## 2. Jak se liší segmenty B2B a B2C?

| Segment   | Počet objednávek | Celkové tržby | Průměrná hodnota objednávky | Medián hodnoty objednávky | Podíl na tržbách |
| B2B       | 425 | 4 136 475,75 Kč | 9 732,88 Kč | 9 463,75 Kč | 82,72 % |
| B2C       | 570 | 864 266,00 Kč | 1 516,26 Kč | 1 510,88 Kč | 17,28 % |
| Celkem    | 995 | 5 000 741,75 Kč | 5 025,87 Kč | — | 100,00 % |

**B2B generuje většinu tržeb, i když má méně objednávek.** Průměrná hodnota objednávky B2B je asi **6,4krát vyšší**.

V Excelu byly doplněny mediány. Vyšší hodnotu objednávky B2B potvrzuje také porovnání mediánů.

### Doporučení

- Vyhodnocovat segmenty samostatně: **B2B tvoří hlavní zdroj tržeb**, B2C přináší více objednávek s nižší hodnotou.
- Věnovat pozornost udržení B2B zákazníků; u B2C prověřit možnosti zvýšení hodnoty objednávky.
- Před rozhodováním o obchodních prioritách doplnit náklady a marži. Vyšší tržby samy o sobě neznamenají vyšší ziskovost.

## 3. Kteří zákazníci přinesli nejvyšší tržby v každém segmentu?

| Segment   | Pořadí    | Zákazník      | Celkové tržby |
| B2B       | 1         | Firma 004     | 291 299,50 Kč |
| B2B       | 2         | Firma 027     | 199 190,25 Kč |
| B2B       | 3         | Firma 013     | 178 146,50 Kč |
| B2C       | 1         | Zákazník 074  | 29 857,25 Kč  |
| B2C       | 2         | Zákazník 072  | 29 323,50 Kč  |
| B2C       | 3         | Zákazník 045  | 28 502,50 Kč  |

Pořadí bylo v SQL určeno funkcí zvlášť pro každý segment. Na prvních třech pozicích nebyly nalezeny remízy. Výsledek byl ověřen kontingenčními tabulkami v Excelu.

Nejvyšší tržby v B2B přinesla **Firma 004**, v B2C **Zákazník 074**.

### Podíl tří největších zákazníků

| Segment   | Tržby TOP 3   | Celkové tržby segmentu    | Podíl TOP 3   |
| B2B       | 668 636,25 Kč | 4 136 475,75 Kč           | 16,16 %       |
| B2C       | 87 683,25 Kč  | 864 266,00 Kč             | 10,15 %       |

Tři největší zákazníci vytvořili **16,16 % tržeb B2B** a **10,15 % tržeb B2C**. 

### Doporučení

- Sledovat další nákupy největších zákazníků a v reálném prostředí jim věnovat cílenou péči.

## Omezení analýzy

- Data jsou syntetická. Doporučení ukazují způsob interpretace výsledků, takže nepředstavují doporučení konkrétní skutečné firmě.
- Analýza zahrnuje jeden rok a 12 měsíčních pozorování, proto neumožňuje potvrdit opakující se sezónnost.
- Korelace popisuje souvislost, nikoli příčinu.