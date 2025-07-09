-- Write a query that shows only the duration of the trip and the percentile into
-- which that duration falls (across the entire dataset—not partitioned by terminal).
SELECT
  duration_seconds,
  NTILE(100) OVER(ORDER BY duration_seconds) as percentile
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY duration_seconds DESC