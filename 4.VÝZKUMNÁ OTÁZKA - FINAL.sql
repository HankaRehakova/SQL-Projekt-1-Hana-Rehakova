-- 4. VÝZKUMNÁ OTÁZKA
-- EXISTUJE ROK, VE KTERÉM BYL MEZIROČNÍ NÁRŮST CEN POTRAVIN
-- VÝRAZNĚ VYŠŠÍ NEŽ RŮST MEZD (VĚTŠÍ NEŽ 10 %)?


WITH food_by_year AS (
    SELECT
        EXTRACT(YEAR FROM date_from)::int AS year,
        ROUND(AVG(value)::numeric, 2) AS avg_food_price
    FROM data_academy_content.czechia_price
    WHERE value IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM date_from)
),
wage_by_year AS (
    SELECT
        payroll_year::int AS year,
        ROUND(AVG(value)::numeric, 2) AS avg_wage
    FROM data_academy_content.czechia_payroll
    WHERE value IS NOT NULL
      AND value_type_code = 316    -- Průměrná hrubá mzda na zaměstnance
      AND unit_code = 80403        -- Kč
      AND calculation_code = 100   -- průměr
    GROUP BY payroll_year
),
yoy AS (
    SELECT
        f.year,
        f.avg_food_price,
        LAG(f.avg_food_price) OVER (ORDER BY f.year) AS prev_food_price,
        w.avg_wage,
        LAG(w.avg_wage) OVER (ORDER BY w.year) AS prev_wage
    FROM food_by_year f
    JOIN wage_by_year w USING (year)
),
growth AS (
    SELECT
        year,
        ROUND(
            (avg_food_price - prev_food_price) / prev_food_price * 100.0
            , 2
        ) AS food_yoy_pct,
        ROUND(
            (avg_wage - prev_wage) / prev_wage * 100.0
            , 2
        ) AS wage_yoy_pct,
        ROUND(
            (
                (avg_food_price - prev_food_price) / prev_food_price * 100.0
                - (avg_wage - prev_wage) / prev_wage * 100.0
            )::numeric
            , 2
        ) AS diff_pct_points
    FROM yoy
    WHERE prev_food_price IS NOT NULL 
      AND prev_wage IS NOT NULL
)
SELECT
    year AS "Rok",
    food_yoy_pct AS "Meziroční růst cen potravin (%)",
    wage_yoy_pct AS "Meziroční růst mezd (%)",
    diff_pct_points AS "Rozdíl (p.b. – ceny mínus mzdy)"
FROM growth
WHERE diff_pct_points > 10
ORDER BY year;


