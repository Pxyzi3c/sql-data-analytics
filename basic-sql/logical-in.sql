-- Query that shows all of the entries for Elvis and M.C. Hammer.
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE group_name IN ('Elvis Presley', 'M.C. Hammer', 'Hammer')