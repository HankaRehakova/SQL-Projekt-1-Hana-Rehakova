-- 3. VÝZKUMNÁ OTÁZKA
-- KTERÁ KATEGORIE POTRAVIN ZDRAŽUJE NEJPOMALEJI
-- (MÁ NEJNIŽŠÍ PRŮMĚRNÝ MEZIROČNÍ % NÁRŮST)?

WITH yearly_avg AS (
    SELECT
        cpc.name AS category_name,
        EXTRACT(YEAR FROM cp.date_from)::int AS year,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_price
    FROM data_academy_content.czechia_price cp
    JOIN data_academy_content.czechia_price_category cpc
        ON cp.category_code = cpc.code
    WHERE cp.value IS NOT NULL
    GROUP BY cpc.name, EXTRACT(YEAR FROM cp.date_from)
),
yearly_change AS (
    SELECT
        category_name,
        year,
        avg_price,
        LAG(avg_price) OVER (
            PARTITION BY category_name 
            ORDER BY year
        ) AS prev_price,
        ROUND(
            (avg_price - LAG(avg_price) OVER (
                            PARTITION BY category_name 
                            ORDER BY year
                     ))
            / LAG(avg_price) OVER (
                            PARTITION BY category_name 
                            ORDER BY year
                     ) * 100
            , 2
        ) AS pct_change
    FROM yearly_avg
)
SELECT
    category_name,
    ROUND(AVG(pct_change)::numeric, 2) AS avg_annual_growth_pct
FROM yearly_change
WHERE pct_change IS NOT NULL
GROUP BY category_name
ORDER BY avg_annual_growth_pct ASC
LIMIT 5;
