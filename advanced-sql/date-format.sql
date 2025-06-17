-- Write a query that counts the number of companies acquired within 3 years, 5 years, and 10 years of being founded
-- (in 3 separate columns). Include a column for total companies acquired as well. 
-- Group by category and limit to only rows with a founding date.
SELECT 
    c.category_code,
    COUNT(CASE
        WHEN EXTRACT(YEAR FROM a.acquired_at_cleaned::DATE) - EXTRACT(YEAR FROM c.founded_at_clean::DATE) <= 3
        THEN c.permalink
        END
    ) AS acquired_3_yrs,
    COUNT(CASE
        WHEN EXTRACT(YEAR FROM a.acquired_at_cleaned::DATE) - EXTRACT(YEAR FROM c.founded_at_clean::DATE) <= 5
        THEN c.permalink
        END
    ) AS acquired_5_yrs,
    COUNT(CASE
        WHEN EXTRACT(YEAR FROM a.acquired_at_cleaned::DATE) - EXTRACT(YEAR FROM c.founded_at_clean::DATE) <= 10
        THEN c.permalink
        END
    ) AS acquired_10_yrs,
    COUNT(a.company_permalink) as total_companies_acquired
FROM tutorial.crunchbase_companies_clean_date AS c
JOIN tutorial.crunchbase_acquisitions_clean_date AS a
ON c.permalink = a.company_permalink
WHERE c.founded_at IS NOT NULL
GROUP BY c.category_code
ORDER BY 5 DESC

-- Query that shows the permalink, founded date, and a date that is one week after the founded date.
SELECT companies.permalink,
       companies.founded_at_clean,
       companies.founded_at_clean::timestamp +
         INTERVAL '1 week' AS plus_one_week
FROM tutorial.crunchbase_companies_clean_date companies
WHERE founded_at_clean IS NOT NULL

-- =============================================================================
-- Query that counts the number of incidents reported by week. Cast the week as a date to get rid of the hours/minutes/seconds.
-- =============================================================================
SELECT 
    DATE_TRUNC('week', cleaned_date)::DATE AS week,
    COUNT(*) AS incident_counts
FROM tutorial.sf_crime_incidents_cleandate
GROUP BY 1
ORDER BY 1 desc

-- =============================================================================
-- Write a query that shows exactly how long ago each indicent was reported. Assume that the dataset is in Pacific Standard Time (UTC - 8).
-- =============================================================================
SELECT incidnt_num,
  cleaned_date,
  (NOW() AT TIME ZONE 'UTC-8') - (cleaned_date AT TIME ZONE 'UTC-8') AS how_long_ago
FROM tutorial.sf_crime_incidents_cleandate