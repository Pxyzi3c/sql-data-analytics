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