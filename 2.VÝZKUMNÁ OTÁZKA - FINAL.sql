-- 2. VÝZKUMNÁ OTÁZKA
-- KOLIK JE MOŽNÉ SI KOUPIT LITRŮ MLÉKA A KILOGRAMŮ CHLEBA
-- ZA PRVNÍ A POSLEDNÍ SROVNATELNÉ OBDOBÍ V DOSTUPNÝCH DATECH CEN A MEZD?

-- Za všechny roky
WITH milk_bread_prices AS (
    SELECT 
        cpc.code AS category_code,
        cpc.name AS product_name,
        EXTRACT(YEAR FROM cp.date_from)::int AS year,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_price
    FROM data_academy_content.czechia_price cp
    JOIN data_academy_content.czechia_price_category cpc 
        ON cp.category_code = cpc.code
    -- kódy z czechia_price_category:
    -- 111301 = Chléb konzumní kmínový
    -- 114201 = Mléko polotučné pasterované
    WHERE cp.category_code IN (111301, 114201)
      AND cp.value IS NOT NULL
    GROUP BY cpc.code, cpc.name, EXTRACT(YEAR FROM cp.date_from)
),
avg_wages AS (
    SELECT 
        cp.payroll_year::int AS year,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_wage
    FROM data_academy_content.czechia_payroll cp
    WHERE cp.value_type_code = 316    -- Průměrná hrubá mzda na zaměstnance
      AND cp.unit_code = 80403        -- Kč
      AND cp.calculation_code = 100   -- průměr
      AND cp.value IS NOT NULL
    GROUP BY cp.payroll_year
),
combined AS (
    SELECT 
        m.year,
        m.product_name,
        a.avg_wage,
        m.avg_price,
        ROUND((a.avg_wage / m.avg_price)::numeric, 2) AS quantity_affordable
    FROM milk_bread_prices m
    JOIN avg_wages a 
        ON m.year = a.year
)
SELECT 
    year AS "Rok",
    product_name AS "Produkt",
    avg_wage AS "Průměrná hrubá mzda (Kč)",
    avg_price AS "Průměrná cena (Kč)",
    quantity_affordable AS "Kolik jednotek lze koupit za mzdu"
FROM combined
ORDER BY year, product_name;

-- První versus poslední společný rok

WITH milk_bread_prices AS (
    SELECT 
        cpc.name AS product_name,
        EXTRACT(YEAR FROM cp.date_from)::int AS year,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_price
    FROM data_academy_content.czechia_price cp
    JOIN data_academy_content.czechia_price_category cpc 
        ON cp.category_code = cpc.code
    WHERE cp.category_code IN (111301, 114201)
      AND cp.value IS NOT NULL
    GROUP BY cpc.name, EXTRACT(YEAR FROM cp.date_from)
),
avg_wages AS (
    SELECT 
        cp.payroll_year::int AS year,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_wage
    FROM data_academy_content.czechia_payroll cp
    WHERE cp.value_type_code = 316    -- Průměrná hrubá mzda na zaměstnance
      AND cp.unit_code = 80403        -- Kč
      AND cp.calculation_code = 100   -- průměr
      AND cp.value IS NOT NULL
    GROUP BY cp.payroll_year
),
combined AS (
    SELECT 
        m.year,
        m.product_name,
        a.avg_wage,
        m.avg_price,
        ROUND((a.avg_wage / m.avg_price)::numeric, 2) AS quantity_affordable
    FROM milk_bread_prices m
    JOIN avg_wages a 
        ON m.year = a.year
),
bounds AS (
    SELECT 
        MIN(year) AS y_min, 
        MAX(year) AS y_max 
    FROM combined
)
SELECT 
    c.year AS "Rok",
    c.product_name AS "Produkt",
    c.avg_wage AS "Průměrná hrubá mzda (Kč)",
    c.avg_price AS "Průměrná cena (Kč)",
    c.quantity_affordable AS "Kolik jednotek lze koupit za mzdu"
FROM combined c
JOIN bounds b 
    ON c.year IN (b.y_min, b.y_max)
ORDER BY c.product_name, c.year;




