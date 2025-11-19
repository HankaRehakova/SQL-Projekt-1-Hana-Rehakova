DROP TABLE IF EXISTS data_academy_content.t_hana_rehkova_project_sql_primary_final;

CREATE TABLE data_academy_content.t_hana_rehkova_project_sql_primary_final AS
WITH wage_by_year AS (
    SELECT
        payroll_year AS year,
        ROUND(AVG(value)::numeric, 0) AS avg_wage
    FROM data_academy_content.czechia_payroll
    WHERE value IS NOT NULL
      AND unit_code = 200
      AND calculation_code = 100
    GROUP BY payroll_year
),
food_by_year AS (
    SELECT
        EXTRACT(YEAR FROM date_from)::int AS year,
        ROUND(AVG(value)::numeric, 2) AS avg_food_price
    FROM data_academy_content.czechia_price
    WHERE value IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM date_from)
)
SELECT
    w.year,
    w.avg_wage,
    f.avg_food_price
FROM wage_by_year w
JOIN food_by_year f
    ON w.year = f.year
ORDER BY w.year;

