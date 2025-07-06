-- =============================================================================
-- Write a query modification of the above example query that shows the duration
-- of each ride as a percentage of the total time accrued by riders from each start_terminal
-- =============================================================================

SELECT 
  start_terminal,
  duration_seconds,
  SUM(duration_seconds) OVER (PARTITION BY start_terminal) AS running_total,
  (duration_seconds/SUM(duration_seconds) OVER (PARTITION BY start_terminal))*100 AS running_total_percentage
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'