Ing. Hana Řeháková – Datová Akademie (od 10. 9. 2025)

Tento projekt se zaměřuje na analýzu vývoje mezd a cen základních potravin v České republice a jejich vzájemného vztahu.
Cílem je vytvořit robustní datové podklady pro pět výzkumných otázek týkajících se kupní síly, cen potravin a ekonomického vývoje.

Obsah repozitáře

🔹 Primární tabulka (SQL)
t_hana_rehakova_project_SQL_primary_final.sql

→ sjednocená data průměrné roční mzdy a průměrné roční ceny potravin v ČR.

🔹 Sekundární tabulka (SQL)
t_hana_rehakova_project_SQL_secondary_final.sql

→ data o HDP, GINI indexu a populaci evropských států od roku 2006.

🔹 SQL skripty pro výzkumné otázky

1.VÝZKUMNÁ OTÁZKA - FINAL.sql

2.VÝZKUMNÁ OTÁZKA - FINAL.sql

3.VÝZKUMNÁ OTÁZKA - FINAL.sql

4.VÝZKUMNÁ OTÁZKA - FINAL.sql

5.VÝZKUMNÁ OTÁZKA - FINAL.sql

🔹 Dokumentace (DOCX)

Úvodní strana projektu

1.Výzkumná otázka – FINAL.docx

2.Výzkumná otázka – FINAL.docx

3.Výzkumná otázka – FINAL.docx

4.Výzkumná otázka – FINAL.docx

5.Výzkumná otázka – FINAL.docx

Projekt využívá datové zdroje:

czechia_payroll – mzdy

czechia_price – ceny potravin

czechia_price_category – kategorie potravin

economies – makroekonomické ukazatele (HDP, GINI, populace)

countries – číselník států


Informace o výstupních datech (důležité pro hodnotitele)

Použita byla pouze data s hodnotou value IS NOT NULL.

Časové období společné všem tabulkám: 2006–2018.

Průměrné mzdy a ceny jsou agregovány za celý rok.

Ceny potravin jsou zprůměrovány přes všechny kraje.

Primární tabulka obsahuje pouze roky, které mají data v obou zdrojích (mzdy + ceny).

Sekundární tabulka obsahuje všechny evropské státy (kontinent = 'Europe').


Popis generovaných tabulek

Primární tabulka: t_hana_rehakova_project_SQL_primary_final

Obsah:

year

avg_wage — průměrná roční mzda v ČR

avg_food_price — průměrná roční cena potravin v ČR

Použití:
→ Otázka 2, 4, 5

Sekundární tabulka: t_hana_rehakova_project_SQL_secondary_final

Obsah:

country

year

gdp

gini

population

Použití:
→ Otázka 5

Mezivýsledky k výzkumným otázkám

1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?
2. 
Analýza ukazuje, že většina odvětví má dlouhodobě rostoucí mzdy, avšak několik odvětví zaznamenalo meziroční pokles, například zemědělství nebo vzdělávání.

3. Kolik je možné koupit chleba a mléka za první a poslední společný rok?
4. 
Výsledky ukazují, že kupní síla výrazně stoupla. V prvních letech bylo možné koupit méně chleba a mléka. V roce 2018 si lidé mohou za průměrnou mzdu koupit chleba a mléka výrazně více.

5. Která potravinová kategorie zdražuje nejpomaleji?
6. 
Některé potraviny mají minimální růst, dokonce i zlevňují (např. cukr krystalový).

7. Existuje rok, kdy růst cen > růst mezd o více než 10 %?
8. 
Ano.
Např. roky 2007, 2008, 2012, 2013, 2014, 2016, 2017, 2018.
V těchto letech ceny rostly výrazně rychleji než mzdy.

9. Ovlivňuje růst HDP změny mezd a cen potravin?
10. 
Výsledek:
Mzdy vykazují poměrně silnou vazbu na růst HDP.
Ceny potravin mají vztah slabý a nepravidelný.
Ceny potravin jsou ovlivněny i jinými faktory (inflace, komodity, sezónnost).

Závěr projektu

Projekt úspěšně vytvořil:

sjednocené datové přehledy (primární a sekundární tabulku),
SQL dotazy k pěti výzkumným otázkám,
dokumentaci s výsledky analýz.

Analýza potvrzuje dlouhodobý růst mezd, různé tempo zdražování potravin, i fakt, že růst HDP souvisí především s růstem mezd, nikoliv cen potravin.

Autor

Ing. Hana Řeháková

Datová Akademie – ENGETO (2025)






