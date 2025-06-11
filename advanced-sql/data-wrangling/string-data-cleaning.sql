-- PRACTICE:
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