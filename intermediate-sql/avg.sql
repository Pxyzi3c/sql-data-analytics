-- Query that calculates the average daily trade volume for Apple stock.
SELECT AVG(volume) AS average_volume
  FROM tutorial.aapl_historical_stock_price
WHERE volume IS NOT NULL