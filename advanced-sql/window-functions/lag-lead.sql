-- ==============================================================================
-- Query to demonstrate the use of LAG and LEAD window functions
-- ==============================================================================
SELECT start_terminal,
       duration_seconds,
       LAG(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds) AS lag,
       LEAD(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds) AS lead
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 ORDER BY start_terminal, duration_seconds

-- ==============================================================================
-- Query to calculate the difference between the current row and the previous row
-- ==============================================================================
SELECT start_terminal,
       duration_seconds,
       duration_seconds -LAG(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds)
         AS difference
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 ORDER BY start_terminal, duration_seconds

-- ==============================================================================
-- Query to calculate the difference between the current row and the previous row
-- using COALESCE to handle NULL values
-- ==============================================================================
SELECT start_terminal,
       duration_seconds,
       duration_seconds - COALESCE(LAG(duration_seconds, 1) OVER
         (PARTITION BY start_terminal ORDER BY duration_seconds), 0) AS difference
  FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'
ORDER BY start_terminal, duration_seconds

-- ==============================================================================
-- Query to filter out rows where the difference is NULL
-- ==============================================================================
SELECT *
FROM (
  SELECT start_terminal,
         duration_seconds,
         duration_seconds - LAG(duration_seconds, 1) OVER
           (PARTITION BY start_terminal ORDER BY duration_seconds) AS difference
    FROM tutorial.dc_bikeshare_q1_2012
  WHERE start_time < '2012-01-08'
  ORDER BY start_terminal, duration_seconds
) AS sub
WHERE sub.difference IS NOT NULL