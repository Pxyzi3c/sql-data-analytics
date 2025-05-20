-- Query that shows all of the rows for which song_name is null.
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE song_name IS NULL