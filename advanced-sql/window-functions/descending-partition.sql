-- Write a query that shows a running total of the duration of bike rides (similar to the last example),
-- but grouped by end_terminal, and with ride duration sorted in descending order.

SELECT
  end_terminal,
  duration_seconds,
  SUM(duration_seconds) OVER
    (PARTITION BY end_terminal ORDER BY duration_seconds DESC) AS total_duration
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'

-- =============================================================================
-- TO-DO:
-- https://mode.com/blog/most-popular-window-functions-and-how-to-use-them?utm_medium=referral&utm_source=mode-site&utm_campaign=sql-tutorial
-- =============================================================================