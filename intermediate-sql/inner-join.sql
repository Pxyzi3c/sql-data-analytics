-- Query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
SELECT p.player_name,
  p.school_name,
  t.conference
FROM benn.college_football_players AS p
INNER JOIN benn.college_football_teams AS t
ON p.school_name = t.school_name
WHERE LOWER(t.division) = 'fbs (division i-a teams)'

-- Query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.
SELECT COUNT(a.company_permalink) AS acquisition_count,
  COUNT(c.permalink) AS company_count
FROM tutorial.crunchbase_acquisitions AS a
JOIN tutorial.crunchbase_companies AS c
ON a.company_permalink = c.permalink