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