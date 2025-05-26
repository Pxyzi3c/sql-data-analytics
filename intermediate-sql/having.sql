-- Find every month during which AAPL stock worked its way over $400/share
SELECT year,
    month,
    MAX(high) AS highest_month_year
  FROM tutorial.aapl_historical_stock_price
GROUP BY year, month
HAVING MAX(high) > 400
ORDER BY year, month