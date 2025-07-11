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

-- =============================================================================
-- Query that displays the average number of monthly incidents for each category.
-- =============================================================================
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

-- =============================================================================
-- Query that displays all rows from the three categories with the fewest incidents reported.
-- =============================================================================
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

-- =============================================================================
-- Write a query that counts the number of companies founded and acquired by quarter starting in Q1 2012. 
-- Create the aggregations in two separate queries, then join them.
-- =============================================================================
SELECT 
    COALESCE(f.founded_quarter, a.acquired_quarter) AS quarter,
    COALESCE(f.companies_founded, 0) AS companies_founded,
    COALESCE(a.companies_acquired, 0) AS companies_acquired
FROM (
        SELECT 
            founded_quarter,
            COUNT(permalink) as companies_founded
        FROM tutorial.crunchbase_companies
        WHERE founded_quarter >= '2012-Q1'
        GROUP BY founded_quarter
    ) AS f
FULL JOIN (
        SELECT acquired_quarter,
            COUNT(company_permalink) as companies_acquired
        FROM tutorial.crunchbase_acquisitions
        WHERE acquired_quarter >= '2012-Q1'
        GROUP BY acquired_quarter
    ) AS a
ON f.founded_quarter = a.acquired_quarter
ORDER BY "quarter"

-- =============================================================================
-- Write a query that ranks investors from the combined dataset above by the total number of investments they have made. 
-- =============================================================================
WITH AllInvestments AS (
  SELECT *
  FROM tutorial.crunchbase_investments_part1
  
  UNION ALL
  
  SELECT *
  FROM tutorial.crunchbase_investments_part2
),
InvestorsTotalInvestments AS (
  SELECT investor_permalink,
    COUNT(investor_permalink) AS investments
  FROM AllInvestments
  GROUP BY investor_permalink
)
SELECT 
  iti.investor_permalink,
  iti.investments,
  RANK() OVER (ORDER BY iti.investments DESC) AS ranking
FROM InvestorsTotalInvestments AS iti
ORDER BY iti.investments DESC

-- =============================================================================
-- Write a query that does the same thing as in the previous problem, 
-- except only for companies that are still operating. 
-- Hint: operating status is in tutorial.crunchbase_companies. 
-- =============================================================================
WITH AllInvestments AS (
    SELECT investor_permalink, company_permalink
    FROM tutorial.crunchbase_investments_part1 AS p1
        
    UNION ALL
    
    SELECT investor_permalink, company_permalink
    FROM tutorial.crunchbase_investments_part2
),
InvestorsTotalInvestments AS (
    SELECT ai.investor_permalink AS investor_permalink,
        COUNT(ai.investor_permalink) AS investments
    FROM AllInvestments AS ai
    INNER JOIN tutorial.crunchbase_companies AS c
        ON ai.company_permalink = c.permalink
    WHERE c.status = 'operating'
    GROUP BY ai.investor_permalink
)
SELECT 
    iti.investor_permalink,
    iti.investments,
    RANK() OVER (ORDER BY iti.investments DESC) AS ranking
FROM InvestorsTotalInvestments AS iti
ORDER BY iti.investments DESC