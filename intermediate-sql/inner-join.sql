-- Query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
SELECT p.player_name,
  p.school_name,
  t.conference
FROM benn.college_football_players AS p
INNER JOIN benn.college_football_teams AS t
ON p.school_name = t.school_name
WHERE LOWER(t.division) = 'fbs (division i-a teams)'