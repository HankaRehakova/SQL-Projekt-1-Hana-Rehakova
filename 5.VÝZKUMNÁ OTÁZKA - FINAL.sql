WITH base AS (
    SELECT
        year,
        avg_wage,
        avg_food_price,
        ROUND(
            (avg_wage - LAG(avg_wage) OVER (ORDER BY year))
            / LAG(avg_wage) OVER (ORDER BY year) * 100, 2
        ) AS wage_growth_pct,
        ROUND(
            (avg_food_price - LAG(avg_food_price) OVER (ORDER BY year))
            / LAG(avg_food_price) OVER (ORDER BY year) * 100, 2
        ) AS food_growth_pct
    FROM data_academy_content.t_hana_rehkova_project_sql_primary_final
),
gdp AS (
    SELECT
        year,
        gdp,
        ROUND(
            (gdp - LAG(gdp) OVER (ORDER BY year))
            / LAG(gdp) OVER (ORDER BY year) * 100, 2
        ) AS gdp_growth_pct
    FROM data_academy_content.t_hana_rehkova_project_sql_secondary_final
)
SELECT
    b.year,
    g.gdp_growth_pct,
    b.wage_growth_pct,
    b.food_growth_pct
FROM base b
JOIN gdp g USING (year)
ORDER BY b.year;
