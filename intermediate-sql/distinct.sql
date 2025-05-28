-- Query that returns the unique values in the year column, in chronological order.
SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
ORDER BY 

-- Query that counts the number of unique values in the month column for each year.
SELECT year,
  COUNT(DISTINCT month) AS month_count
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year

-- Query that separately counts the number of unique values in the month column and the number of unique values in the `year` column. 
SELECT COUNT(DISTINCT month) AS months_count,
  COUNT(DISTINCT year) AS years_count
FROM tutorial.aapl_historical_stock_price