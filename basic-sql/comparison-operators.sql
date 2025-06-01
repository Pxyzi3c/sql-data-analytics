-- Query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later. 
SELECT
    year,
    month,
    south + west + midwest + northeast AS total,
    (south / (south + west + midwest + northeast)) * 100 AS south_percentage,
    (west / (south + west + midwest + northeast)) * 100 AS west_percentage
FROM
    tutorial.us_housing_units
WHERE
    year >= 2000