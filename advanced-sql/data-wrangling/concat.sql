-- Concatenate the lat and lon fields to form a field that is equivalent to the location field. 
-- (Note that the answer will have a different decimal precision.)
SELECT
    lon,
    lat,
    location,
    CONCAT ('(', lat, ',', lon, ')') AS combined_lon_lat
FROM
    tutorial.sf_crime_incidents_2014_01

-- =============================================================================    
-- Query that concatenates the day of the week and the date to form a field that is equivalent to the date field.
-- =============================================================================    
SELECT
    incidnt_num,
    day_of_week,
    LEFT (date, 10) AS cleaned_date,
    CONCAT (day_of_week, ', ', LEFT (date, 10)) AS day_and_date
FROM
    tutorial.sf_crime_incidents_2014_01

-- OR

SELECT
    day_of_week,
    date,
    LEFT (date, 10) AS cleaned_date,
    day_of_week || ', ' || LEFT (date, 10) AS day_date
FROM
    tutorial.sf_crime_incidents_2014_01

-- =============================================================================    
-- Query that creates a date column formatted YYYY-MM-DD.
-- =============================================================================    
SELECT
    date,
    CONCAT (
        SUBSTR (date, 7, 4),
        '-',
        LEFT (date, 2),
        '-',
        SUBSTR (date, 4, 2)
    ) AS formatted_date
FROM
    tutorial.sf_crime_incidents_2014_01

-- =============================================================================    
-- Query that capitalizes the first letter of each word in the category field.
-- =============================================================================
SELECT
    category,
    CONCAT (
        UPPER(LEFT (category, 1)),
        LOWER(RIGHT (category, LENGTH (category) - 1))
    )
FROM
    tutorial.sf_crime_incidents_2014_01

-- =============================================================================    
-- Query that creates a date column formatted YYYY-MM-DD and a timestamp column formatted YYYY-MM-DD HH:MM:SS.
-- =============================================================================    
SELECT date,
    CONCAT(
        SUBSTR(date, 7, 4),
        '-',
        LEFT(date, 2),
        '-',
        SUBSTR(date, 4, 2),
        ' ', 
        time,
        ':00'
    )::TIMESTAMP AS cleaned_date,
    date::TIMESTAMP + INTERVAL '1 week' AS plus_one_week
FROM tutorial.sf_crime_incidents_2014_01  