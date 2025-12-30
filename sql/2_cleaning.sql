DROP TABLE IF EXISTS results;

CREATE TABLE results AS
SELECT
    name AS runner_name,
    race AS race_name,
    year AS race_year,
    gender,
    CASE
        WHEN age = -1 THEN NULL
        ELSE age
    END AS age,
    finish AS finish_seconds,
    age_bracket
FROM results_raw
WHERE finish IS NOT NULL
  AND finish > 0;


