-- =============================================================================
-- SUMMARY
-- =============================================================================
SELECT
    incidnt_num,
    date,
    LEFT (date, 10) AS cleaned_date_l,
    RIGHT (date, LENGTH (date) - 11) AS cleaned_date_r,
    TRIM(
        both '()'
        FROM
            location
    ) AS cleaned_location,
    SUBSTR (date, 7, 4) AS date_year,
    descript,
    POSITION('a' IN LOWER(descript)) AS a_position
FROM
    tutorial.sf_crime_incidents_2014_01

-- =============================================================================
-- EXERCISES
-- =============================================================================

-- Query that separates the `location` field into separate fields for latitude and longitude.
-- You can compare your results against the actual `lat` and `lon` fields in the table.
WITH CleanedLocation AS (
    SELECT
        location,
        lat,
        lon,
        TRIM(BOTH '()' FROM location) AS cleaned_loc,
        POSITION(',' IN TRIM(BOTH '()' FROM location)) AS comma_pos
    FROM tutorial.sf_crime_incidents_2014_01
)
SELECT 
    cl.location,
    cl.lat,
    cl.lon,
    LEFT(cl.cleaned_loc, cl.comma_pos - 1) AS lat_str,
    RIGHT(cl.cleaned_loc, LENGTH(cl.cleaned_loc) - cl.comma_pos - 1) AS lon_str
FROM CleanedLocation AS cl