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

-- Query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.
SELECT state, 
  COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
  COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
  COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
  COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
  COUNT(*) AS number_of_players
FROM benn.college_football_players
GROUP BY state
ORDER BY number_of_players DESC

-- Query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
SELECT school_name, 
  CASE WHEN school_name < 'n' THEN 'A-M'
    WHEN school_name >= 'n' THEN 'N-Z'
    ELSE NULL END AS school_category, 
  COUNT(1) AS players
FROM benn.college_football_players
GROUP BY school_name