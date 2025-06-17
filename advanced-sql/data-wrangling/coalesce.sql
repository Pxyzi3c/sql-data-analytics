-- =============================================================================    
-- PRACTICE
-- =============================================================================
SELECT
    incidnt_num,
    COALESCE(descript, 'No Description')
FROM
    tutorial.sf_crime_incidents_cleandate
ORDER BY
    descript DESC