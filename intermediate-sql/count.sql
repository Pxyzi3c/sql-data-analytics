-- Query to count the number of non-null rows in the low column.
SELECT count(low)
  FROM tutorial.aapl_historical_stock_price

-- Query that determines counts of every single column. With these counts, can you tell which column has the most null values?
SELECT COUNT(date) AS date_counts,
  COUNT(year) AS year_counts,
  COUNT(month) AS month_counts,
  COUNT(open) AS open_counts,
  COUNT(high) AS high_counts,
  COUNT(low) AS low_counts,
  COUNT(close) AS close_counts,
  COUNT(volume) AS volume_counts
FROM tutorial.aapl_historical_stock_price