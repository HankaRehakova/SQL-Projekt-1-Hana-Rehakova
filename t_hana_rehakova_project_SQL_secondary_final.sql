DROP TABLE IF EXISTS data_academy_content.t_hana_rehkova_project_sql_secondary_final;

CREATE TABLE data_academy_content.t_hana_rehkova_project_sql_secondary_final AS
SELECT
    e.country,
    e.year,
    e.gdp::numeric(18,2)        AS gdp,
    e.gini::numeric(10,2)       AS gini,
    e.population::numeric(18,0) AS population
FROM data_academy_content.economies e
JOIN data_academy_content.countries c
    ON e.country = c.country
WHERE c.continent = 'Europe'     -- ❗ všechny evropské státy
  AND e.year >= 2006
ORDER BY e.country, e.year;

-- Kontrola
SELECT *
FROM data_academy_content.t_hana_rehkova_project_sql_secondary_final
ORDER BY country, year;

