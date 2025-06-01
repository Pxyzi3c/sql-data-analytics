-- Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. 
-- Count up the number of rows that are matched/unmatched as in the example above.
SELECT COUNT(CASE WHEN c.permalink IS NOT NULL AND i_p1.company_permalink IS NOT NULL THEN 1 END) AS matched_rows,
  COUNT(CASE WHEN c.permalink IS NULL OR i_p1.company_permalink IS NULL THEN 1 END) AS unmatched_rows
FROM tutorial.crunchbase_companies AS c
FULL JOIN tutorial.crunchbase_investments_part1 AS i_p1
ON c.permalink = i_p1.company_permalink

-- Query that counts rows that appear only in the 'companies' table, only in the 'investments' table, or in both.
SELECT COUNT(CASE WHEN c.permalink IS NOT NULL AND i_p1.company_permalink IS NULL THEN c.permalink ELSE NULL END) AS companies_only,
  COUNT(CASE WHEN c.permalink IS NULL AND i_p1.company_permalink IS NOT NULL THEN i_p1.company_permalink ELSE NULL END) AS investments_only,
  COUNT(CASE WHEN c.permalink IS NOT NULL AND i_p1.company_permalink IS NOT NULL THEN c.permalink ELSE NULL END) AS both_tables
FROM tutorial.crunchbase_companies AS c
FULL JOIN tutorial.crunchbase_investments_part1 AS i_p1
ON c.permalink = i_p1.company_permalink