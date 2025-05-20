-- Query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE song_name NOT ILIKE '%a%'
  AND year = 2013