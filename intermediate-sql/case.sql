-- Query that includes a column that is flagged "yes" when a player is from California, and sort the results with those players first.
SELECT player_name,
    year,
    state,
    hometown,
    CASE WHEN state = 'CA' OR hometown ILIKE '%california%' THEN 'yes'
      ELSE 'no' END AS from_california
  FROM benn.college_football_players
ORDER BY from_california DESC

-- Query that includes players' names and a column that classifies them into four categories based on height. Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights in many ways.
SELECT player_name,
    height,
    CASE WHEN height > 80 THEN 'giants'
        WHEN height >= 60 AND height <= 80 THEN 'upper 60'
        WHEN height >= 40 AND height < 60 THEN 'upper 40'
        ELSE 'tanks' END AS height_category
  FROM benn.college_football_players

-- Query that selects all columns from benn.college_football_players and adds an additional column that displays the player's name if that player is a junior or senior.
SELECT *,
  CASE WHEN year IN ('JR', 'SR') THEN player_name
    ELSE NULL END AS upperclass_player
FROM benn.college_football_players

-- Query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (everywhere else).
SELECT state,
  weight,
  CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
    WHEN state = 'TX' THEN 'Texas'
    ELSE 'others' END AS region,
  COUNT(*) AS count
FROM benn.college_football_players
WHERE weight >= 300
GROUP BY state, weight
ORDER BY state, weight

-- Query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California.
SELECT state,
  year,
  CASE WHEN year IN ('FR', 'SO') THEN 'Underclass Players'
    WHEN year IN ('JR', 'SR') THEN 'Upperclass Players'
    ELSE NULL
  END AS players_category,
  SUM(weight) as total_weight
FROM benn.college_football_players
WHERE state = 'CA'
GROUP BY state, year
ORDER BY players_category