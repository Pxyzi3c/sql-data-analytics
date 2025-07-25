-- Total number of shares traded each month. Order your results chronologically.
SELECT year, 
    month, 
    SUM(volume) volume_sum,
    COUNT(*) as count
  FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month

-- Query to calculate the average daily price change in Apple stock, grouped by year.
SELECT year,
    AVG(close - open) AS daily_price_change
  FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year

-- Query that calculates the lowest and highest prices that Apple stock achieved each month.
SELECT year,
    month,
    MIN(low) as lowest_price,
    MAX(high) as highest_price
  FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
ORDER BY year, month