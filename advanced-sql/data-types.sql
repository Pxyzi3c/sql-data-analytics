-- Convert the funding_total_usd and founded_at_clean columns in the tutorial.crunchbase_companies_clean_date table
-- to strings (varchar format) using a different formatting function for each one.
-- USING CAST
SELECT CAST(funding_total_usd AS VARCHAR),
  CAST(founded_at_clean AS VARCHAR)
FROM tutorial.crunchbase_companies_clean_date

-- USING ::
SELECT funding_total_usd::VARCHAR,
  founded_at_clean::VARCHAR
FROM tutorial.crunchbase_companies_clean_date