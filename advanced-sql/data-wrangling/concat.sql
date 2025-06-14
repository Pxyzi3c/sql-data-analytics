-- Concatenate the lat and lon fields to form a field that is equivalent to the location field. 
-- (Note that the answer will have a different decimal precision.)
SELECT
    lon,
    lat,
    location,
    CONCAT ('(', lat, ',', lon, ')') AS combined_lon_lat
FROM
    tutorial.sf_crime_incidents_2014_01

-- Query that concatenates the day of the week and the date to form a field that is equivalent to the date field.
SELECT
    incidnt_num,
    day_of_week,
    LEFT (date, 10) AS cleaned_date,
    CONCAT (day_of_week, ', ', LEFT (date, 10)) AS day_and_date
FROM
    tutorial.sf_crime_incidents_2014_01