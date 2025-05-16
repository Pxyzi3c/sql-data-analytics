-- NOTE: LIKE - is case-sensitive.
--       ILIKE - is not case-sensitive.

-- Query that returns all rows for which Ludacris was a member of the group.
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE group_name ILIKE '%ludacris%'


-- Query that returns all rows for which the first artist listed in the group has a name that begins with "DJ". 
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE artist LIKE 'DJ%'


-- Query that returns all rows for which the artist has a name that contains "dr" and "ke".
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE artist ILIKE 'dr_ke'