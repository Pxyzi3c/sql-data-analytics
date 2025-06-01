-- Write a query that appends the two crunchbase_investments datasets above (including duplicate values).
-- Filter the first dataset to only companies with names that start with the letter "T",
-- and filter the second to companies with names starting with "M" (both not case-sensitive).
-- Only include the company_permalink, company_name, and investor_name columns.
SELECT
    company_permalink,
    company_name,
    investor_name
FROM
    tutorial.crunchbase_investments_part1
WHERE
    company_name ILIKE 't%'
UNION ALL
SELECT
    company_permalink,
    company_name,
    investor_name
FROM
    tutorial.crunchbase_investments_part2
WHERE
    company_name ILIKE 'm%'

-- Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, 
-- the second shows company status, and the third is a count of the number of investors.
-- Hint: you will have to use the tutorial.crunchbase_companies table as well as the investments tables. 
-- And you'll want to group by status and dataset.
SELECT
    investments.source_dataset,
    companies.status,
    COUNT(DISTINCT investments.investor_permalink) AS investments_count
FROM
    tutorial.crunchbase_companies AS companies
    INNER JOIN (
        SELECT
            'part 1' AS source_dataset,
            ip1.company_permalink,
            ip1.investor_permalink
        FROM
            tutorial.crunchbase_investments_part1 AS ip1
        UNION ALL
        SELECT
            'part 2' AS source_dataset,
            ip2.company_permalink,
            ip2.investor_permalink
        FROM
            tutorial.crunchbase_investments_part2 AS ip2
    ) AS investments ON companies.permalink = investments.company_permalink
GROUP BY
    investments.source_dataset,
    companies.status