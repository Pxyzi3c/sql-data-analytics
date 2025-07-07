-- ==============================================================================
-- PRACTICE
-- ==============================================================================
SELECT
  start_terminal,
  duration_seconds,
  ROW_NUMBER() OVER(PARTITION BY start_terminal ORDER BY duration_seconds) AS row_num,
  RANK() OVER(PARTITION BY start_terminal ORDER BY duration_seconds) AS rank
FROM tutorial.dc_bikeshare_q1_2012
WHERE start_time < '2012-01-08'

-- ==============================================================================
-- EXERCISES
-- ==============================================================================

-- Write a query that shows the 5 longest rides from each starting terminal, ordered by terminal, 
-- and longest to shortest rides within each terminal. Limit to rides that occurred before Jan. 8, 2012.
SELECT *
FROM (
  SELECT
    start_terminal,
    duration_seconds,
    RANK() OVER(PARTITION BY start_terminal ORDER BY duration_seconds DESC) AS rank 
  FROM tutorial.dc_bikeshare_q1_2012
  WHERE start_time < '2012-01-08'
) AS sub
WHERE sub.rank <= 5