DROP TABLE IF EXISTS results_raw;

CREATE TABLE results_raw (
    name TEXT,
    race TEXT,
    year INTEGER,
    gender TEXT,
    age INTEGER,
    finish INTEGER,        -- final time (secs)
    age_bracket TEXT
);

SELECT COUNT(*) AS total_rows
FROM results_raw;


SELECT *
FROM results_raw
LIMIT 10;
