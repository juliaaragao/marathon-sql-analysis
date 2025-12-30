-- total number of observations
SELECT COUNT(*) AS total_results
FROM results;


-- checking how many genders exists. 
SELECT gender,
COUNT(*) as n
FROM  results
GROUP BY gender 
ORDER BY n DESC 

-- number of null ages and total number for ages
SELECT
  SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
  COUNT(*) AS total
FROM results;

-- Present number of runners per marathon and race time average in minutes -> organized by number of runners (descendent)
SELECT
  race_name,
  COUNT(*) AS runners,
  ROUND(AVG(finish_seconds)/60.0, 1) AS avg_minutes,
  ROUND(MIN(finish_seconds)/60.0, 1) AS best_minutes
FROM results
GROUP BY race_name
ORDER BY runners DESC;


-- top 20 best time in minutes
SELECT
  runner_name,
  race_name,
  race_year,
  gender,
  age,
  finish_seconds/60 AS finish_sec_by_60
FROM results
ORDER BY finish_sec_by_60 ASC
LIMIT 20;

-- top 10 athletes per race -> time in minutes
WITH ranked AS (
  SELECT
    runner_name,
    race_name,
    gender,
    race_year,
    age,
    finish_seconds/60 as finish_seconds_by_60,
    ROW_NUMBER() OVER (PARTITION BY race_name ORDER BY finish_seconds) AS rn
  FROM results
)
SELECT *
FROM ranked
WHERE rn <= 10
ORDER BY race_name, rn;

-- Athlete with the most race wins in 2023 -> older athlete first
WITH winners_2023 AS (
  SELECT
    runner_name,
    age,
    race_name,
    finish_seconds,
    ROW_NUMBER() OVER (
      PARTITION BY race_name
      ORDER BY finish_seconds
    ) AS rn
  FROM results
  WHERE race_year = 2023
)
SELECT
  runner_name,
  MAX(age) AS age,
  COUNT(*) AS wins_2023
FROM winners_2023
WHERE rn = 1
GROUP BY runner_name
ORDER BY wins_2023 DESC, age DESC
LIMIT 5;


-- Number of runners by race and distribuition --> p50/p90 finish time
-- p10: The maximum finishing time among the fastest 10% of runners
-- p50: The median finishing time
-- p90: The finishing time below which 90% of runners completed the race 
WITH r AS (
  SELECT
    race_name,
    finish_seconds,
    ROW_NUMBER() OVER (PARTITION BY race_name ORDER BY finish_seconds) AS rn,
    COUNT(*) OVER (PARTITION BY race_name) AS cnt
  FROM results
)
SELECT
  race_name,
  COUNT(*) AS runners,
   ROUND(MAX(CASE WHEN rn = CAST(cnt*0.10 AS INT) THEN finish_seconds END)/3600.0, 1) AS p10_min,
  ROUND(MAX(CASE WHEN rn = CAST(cnt *0.50 AS INT) THEN finish_seconds END)/3600.0, 1) AS p50_min,
  ROUND(MAX(CASE WHEN rn = CAST(cnt *0.90 AS INT) THEN finish_seconds END)/3600.0, 1) AS p90_min
FROM r
GROUP BY race_name
ORDER BY runners DESC;



-- Race competitiveness -> comparing the 1st and 10st racer finish time
WITH ranked AS (
  SELECT
    race_name,
    finish_seconds,
    ROW_NUMBER() OVER (PARTITION BY race_name ORDER BY finish_seconds) AS rn
  FROM results
),
top10 AS (
  SELECT
    race_name,
    MIN(CASE WHEN rn = 1 THEN finish_seconds END) AS t1,
    MIN(CASE WHEN rn = 10 THEN finish_seconds END) AS t10
  FROM ranked
  WHERE rn IN (1, 10)
  GROUP BY race_name
)
SELECT
  race_name,
  ROUND((t10 - t1)/60.0, 1) AS race_competitiveness_time
FROM top10
WHERE race_competitiveness_time IS NOT NULL
ORDER BY race_competitiveness_time ASC;









