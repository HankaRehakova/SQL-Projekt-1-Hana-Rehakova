-- Výzkumná otázka č. 1
-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

-- 1️⃣ Nejprve vypočítáme průměrné mzdy podle odvětví a roku
WITH mzdy AS (
    SELECT 
        i.name AS odvetvi,
        p.payroll_year AS rok,
        ROUND(AVG(p.value), 2) AS prumerna_mzda
    FROM czechia_payroll p
    JOIN czechia_payroll_industry_branch i 
        ON p.industry_branch_code = i.code
    WHERE p.value_type_code = 316       -- průměrná hrubá mzda na zaměstnance
      AND p.unit_code = 80403           -- Kč
      AND p.calculation_code = 100      -- výpočet: průměr
    GROUP BY i.name, p.payroll_year
),

-- 2️⃣ Vypočítáme meziroční změnu a určíme trend (růst / pokles / beze změny)
trend AS (
    SELECT 
        odvetvi,
        rok,
        prumerna_mzda,
        ROUND(prumerna_mzda - LAG(prumerna_mzda) OVER (PARTITION BY odvetvi ORDER BY rok), 2) AS mezirocni_zmena,
        CASE 
            WHEN prumerna_mzda > LAG(prumerna_mzda) OVER (PARTITION BY odvetvi ORDER BY rok) THEN 'Růst'
            WHEN prumerna_mzda < LAG(prumerna_mzda) OVER (PARTITION BY odvetvi ORDER BY rok) THEN 'Pokles'
            ELSE 'Beze změny'
        END AS trend
    FROM mzdy
)

-- 3️⃣ Výběr odvětví, kde mzdy alespoň jednou klesly
SELECT DISTINCT odvetvi
FROM trend
WHERE trend = 'Pokles'
ORDER BY odvetvi;