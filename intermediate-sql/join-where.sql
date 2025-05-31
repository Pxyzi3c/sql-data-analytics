-- Write a query that shows a company's name, "status" (found in the Companies table), 
-- and the number of unique investors in that company. Order by the number of investors from most to fewest. 
-- Limit to only companies in the state of New York. 
SELECT c.name AS company_name, 
  c.status AS company_status,
  COUNT(DISTINCT i.investor_name) AS investors_count
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_investments AS i
ON c.permalink = i.company_permalink
WHERE c.state_code = 'NY'
GROUP BY c.name, c.status
ORDER BY 3 DESC

-- Write a query that lists investors based on the number of companies in which they are invested. 
-- Include a row for companies with no investor, and order from most companies to least.
SELECT CASE WHEN i.investor_name IS NULL THEN 'No investor'
  ELSE i.investor_name END AS investor,
  COUNT(DISTINCT c.permalink) as country_count
FROM tutorial.crunchbase_companies AS c
LEFT JOIN tutorial.crunchbase_investments AS i
ON c.permalink = i.company_permalink
GROUP BY i.investor_name
ORDER BY 2 DESC