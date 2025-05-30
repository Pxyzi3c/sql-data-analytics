-- Query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.
SELECT COUNT(a.company_permalink) AS acquisition_count,
  COUNT(c.permalink) AS company_count
FROM tutorial.crunchbase_acquisitions AS a
LEFT JOIN tutorial.crunchbase_companies AS c
ON a.company_permalink = c.permalink

--  Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest. 
SELECT c.state_code, 
  COUNT(DISTINCT c.name) AS company_count,
  COUNT(DISTINCT a.company_name) AS acquired_companies_count
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_acquisitions AS a
ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
GROUP BY c.state_code
ORDER BY acquired_companies_count DESC