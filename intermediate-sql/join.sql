-- Query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names in relation to the alias.
SELECT teams.school_name AS school_name,
  players.player_name AS player_name,
  players.position AS position,
  players.weight AS weight
FROM benn.college_football_players players
JOIN benn.college_football_teams teams
ON teams.school_name = players.school_name
WHERE players.state = 'GA'
ORDER BY weight DESC