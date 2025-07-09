-- ==============================================================================
-- Write a query that shows only the duration of the trip and the percentile into
-- which that duration falls (across the entire dataset—not partitioned by terminal).
-- ==============================================================================
SELECT
  duration_seconds,
  NTILE(100) OVER(ORDER BY duration_seconds) as percentile
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY duration_seconds DESC

-- ==============================================================================
-- A query that shows the duration of each trip, the quartile, quantile, and percentile
-- into which that duration falls, grouped by start_terminal
-- ==============================================================================
SELECT start_terminal,
  duration_seconds,
  NTILE(4) OVER ntile_window AS quartile,
  NTILE(5) OVER ntile_window AS quantile,
  NTILE(100) OVER ntile_window AS percentile
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
WINDOW ntile_window AS (PARTITION BY start_terminal ORDER BY duration_seconds)
ORDER BY start_terminal, duration_seconds