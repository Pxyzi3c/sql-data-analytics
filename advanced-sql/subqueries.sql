-- =============================================================================
-- PRACTICE
-- =============================================================================
SELECT sub.* 
FROM (
    SELECT
        descript,
        day_of_week,
        resolution
    FROM tutorial.sf_crime_incidents_2014_01
    WHERE day_of_week = 'Monday'
) sub
WHERE sub.resolution ILIKE 'none'

-- Query that returns the average number of incidents per day of the week, grouped by month.
SELECT 
    LEFT(sub.date, 2) AS month,
    sub.day_of_week,
    AVG(sub.incidents) AS avg_incidents
FROM (
    SELECT 
        date,
        day_of_week,
        COUNT(incidnt_num) AS incidents
    FROM tutorial.sf_crime_incidents_2014_01
    GROUP BY 1, 2
) sub
GROUP BY 1, 2
ORDER BY 1, 2

-- =============================================================================
-- EXERCISES
-- =============================================================================
-- Query that selects all Warrant Arrests from the tutorial.sf_crime_incidents_2014_01 dataset, then wrap it in an outer query that only displays unresolved incidents. 
SELECT sub.* 
FROM (
    SELECT 
        category,
        descript,
        resolution
    FROM tutorial.sf_crime_incidents_2014_01
    WHERE descript ILIKE 'warrant arrest'
) sub
WHERE sub.resolution ILIKE 'none'

-- Query that displays the average number of monthly incidents for each category. 
SELECT 
    sub.category,
    AVG(sub.incidents) AS avg_incidents
FROM (
    SELECT
        EXTRACT(MONTH FROM date::DATE) AS month,
        category,
        COUNT(*) AS incidents
    FROM tutorial.sf_crime_incidents_2014_01
    GROUP BY 1, 2
) AS sub
GROUP BY category

-- Query that displays all rows from the three categories with the fewest incidents reported.
SELECT 
  incidents.*,
  sub.incidents_count
FROM tutorial.sf_crime_incidents_2014_01 AS incidents
INNER JOIN (
    SELECT category,
        COUNT(incidnt_num) AS incidents_count
    FROM tutorial.sf_crime_incidents_2014_01
    GROUP BY category
    ORDER BY 2 
    LIMIT 3 
) AS sub
ON incidents.category = sub.category