-- Query that shows companies that received an investment from Great Britain following an investment from Japan.
SELECT DISTINCT jp_investments.company_name,
  jp_investments.company_permalink
FROM tutorial.crunchbase_investments_part1 AS jp_investments
LEFT JOIN tutorial.crunchbase_investments_part1 AS gb_investments
ON jp_investments.company_permalink = gb_investments.company_permalink
AND gb_investments.company_country_code = 'GBR'
AND gb_investments.funded_at > jp_investments.funded_at
WHERE jp_investments.company_country_code = 'JPN'
ORDER BY 1