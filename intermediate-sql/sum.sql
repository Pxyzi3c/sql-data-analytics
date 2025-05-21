-- Query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).
SELECT SUM(open) / COUNT(open) AS opening_average 
  FROM tutorial.aapl_historical_stock_price