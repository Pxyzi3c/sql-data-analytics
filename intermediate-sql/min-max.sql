-- Apple's lowest stock price (at the time of this data collection)?
SELECT MIN(low) as lowest_stock_price
  FROM tutorial.aapl_historical_stock_price

-- Highest single-day increase in Apple's share value?
SELECT MAX(close - open)
  FROM tutorial.aapl_historical_stock_price