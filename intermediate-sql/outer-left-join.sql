-- Query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.
SELECT
  COUNT(a.company_permalink) AS acquisition_count,
  COUNT(c.permalink) AS company_count
FROM tutorial.crunchbase_acquisitions AS a
LEFT JOIN tutorial.crunchbase_companies AS c 
ON a.company_permalink = c.permalink

--  Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest. 
SELECT
  c.state_code,
  COUNT(DISTINCT c.name) AS company_count,
  COUNT(DISTINCT a.company_name) AS acquired_companies_count
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_acquisitions AS a 
ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
GROUP BY c.state_code
ORDER BY acquired_companies_count DESC

-- Query that shows the name, status, and category code of companies that were founded more than 5 years before they were acquired.
SELECT
  c.name AS company_name,
  c.status AS status,
  c.category_code as category_code,
  COUNT(i.investor_permalink) AS investors
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_investments AS i 
ON c.permalink = i.company_permalink
WHERE c.founded_year + 5 < i.funded_year
GROUP BY
  c.name,
  c.status,
  c.category_code

-- Query that shows the name and permalink of companies that were acquired by investors. Using multiple keys in the ON clause.
SELECT c.name AS company_name,
  i.company_permalink AS company_permalink
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_investments AS i
ON c.permalink = i.company_permalink
AND c.name = i.company_name