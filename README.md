# Marathon Results Analysis (SQL)

## Objective
The goal of this project is to explore marathon race results using SQL,
focusing on runner performance, race competitiveness, and finish time distributions.
The analysis aims to demonstrate SQL skills such as aggregations, window functions,
and data quality checks.

## Dataset
The dataset 2023 Marathon Results (https://www.kaggle.com/code/runningwithrock/2023-marathon-results-analysis?select=Results.csv) contains approximately 429k individual marathon race results from 2023.
Each record represents a runner in a specific race and includes information such as runner name, gender, age (when available), race name, and finish time in seconds.

## Project Structure
    marathon-sql-project/
    ├── data/
    │   └── Results.csv
    ├── db/
    │   └── marathon.db
    ├── sql/
    │   ├── 01_schema.sql
    │   ├── 02_cleaning.sql
    │   └── 03_analysis.sql
    └── README.md

## Analysis Overview

The full set of SQL queries can be found in `03_analysis.sql`.
Below are the main analyses and key results extracted from the dataset.

1. Overview data: 
The dataset contains **429,266 race results** from multiple marathons held in 2023.
Four gender categories are present:

| Gender | Count |
|------|-------|
| M | 256,327 |
| F | 172,547 |
| X (non-binary) | 379 |
| U (undefined) | 13 |

The dataset is strongly male-dominated, while non-binary and undefined categories represent a very small fraction of the total records.


2. Participation and Average Finish Time by Race:
The number of runners and the average finish time were computed for each marathon.
Below are the top 5 races by number of participants:

| Race | Runners | Avg Finish Time (min) | Best Finish Time (min) |
|------|--------:|----------------------:|-----------------------:|
| NYC Marathon | 51,290 | 280.1 | 125.0 |
| Chicago Marathon | 48,156 | 260.9 | 120.6 |
| Boston Marathon | 26,600 | 222.5 | 125.9 |
| LA Marathon | 16,950 | 332.6 | 133.3 |
| Honolulu Marathon | 15,044 | 377.5 | 135.7 |


Major international marathons (NY, Chigago and Boston) attract significantly more participants.

3. Athlete with the most race wins in 2023:
Race winners were identified as the 1st place finisher in each marathon.
Athletes were ranked by the number of race wins, with age used as a tie-breaker.

runner_name   |age|wins_2023|
--------------+---+---------+
Gary Krugger  | 38|        6|
Bob Stepp     | 62|        4|
Denise Kaufman| 61|        4|
?? ?          | 52|        4|
Jason Baer    | 45|        4|

A small number of athletes dominate race wins across multiple marathons.
Some inconsistencies in runner names highlight data quality limitations.


4. Finish Time Distribution (p10 / p50 / p90):
Finish time distributions were analyzed using percentiles:
- **p10**: upper bound of the fastest 10% of runners
- **p50**: median finishing time
- **p90**: finishing time below which 90% of runners completed the race

race_name                                                               |runners|p10_h|p50_h|p90_h|
------------------------------------------------------------------------+-------+-------+-------+-------+
NYC Marathon                                                            |  51290|    3.5|    4.5|    6.0|
Chicago Marathon                                                        |  48156|    3.2|    4.2|    5.8|
Boston Marathon                                                         |  26600|    2.9|    3.6|    4.8|
LA Marathon                                                             |  16950|    3.9|    5.5|    7.3|
Honolulu Marathon                                                       |  15044|    4.3|    6.1|    8.6|

Boston Marathon shows a narrower distribution, indicating a more homogeneous and competitive field,
while LA and Honolulu marathons display wider performance variability.

5. Race competitiveness :
Race competitiveness was approximated using the time gap between the 1st and 10th finishers.
Smaller gaps indicate a more competitive elite field.

race_name                                                             |race_competitiveness_time|
----------------------------------------------------------------------+-------------------------+
Indianapolis Monumental Marathon                                      |                      2.5|
Boston Marathon                                                       |                      4.4|
California International Marathon                                     |                      4.7|
Grandma's Marathon                                                    |                      4.9|
McKirdy Micro Marathon - NY II                                        |                      4.9|

Race competitiveness was approximated using the time gap between the 1st and 10th finishers.
Smaller gaps indicate a more competitive elite field.

## Key Insights

- Major marathons such as NYC and Chicago attract the largest number of participants, but do not necessarily present the most competitive elite fields.

- Boston Marathon consistently stands out with faster finish times and a more homogeneous performance distribution, reflecting its qualifying standards.

- Finish time distributions vary significantly across races, indicating that some events attract a broad mix of recreational and competitive runners, while others are more selective.

- Elite competitiveness, measured by the gap between the 1st and 10th finishers, is not directly correlated with race size or absolute finishing times. For exemple: besides major marathons such as NYC and Chicago record faster absolute times, they tend to show larger gaps between top finishers due to a more heterogeneous field.
In contrast, races like the Indianapolis Monumental Marathon present smaller time gaps among elite runners, indicating a more competitive race dynamic despite slower absolute times.


## Notes:
Some limitations apply to this analysis, such as missing or approximate age values
and possible ambiguities in runner identification based on names.

## Fun Facts: World Marathon Majors Context
Majors (WMM), the most prestigious marathon races worldwide are:
🇺🇸 Boston Marathon 
🇬🇧 London Marathon
🇩🇪 Berlin Marathon
🇺🇸 Chicago Marathon 
🇺🇸 New York City Marathon 
🇯🇵 Tokyo Marathon
🇦🇺 Sydney Marathon (officially added as a Major starting in 2025)

### Participation Size
- NYC, London, Chicago and Berlin typically attract 45,000 to 55,000 finishers each.
- Boston has a smaller field (around 25,000–30,000 runners) due to its qualification requirements.
- Tokyo usually hosts around 35,000–38,000 runners.
- Sydney, prior to becoming a Major, hosted fewer runners but is expected to grow significantly.

### Key Characteristics
- New York City Marathon
    > Largest marathon in the world (≈ 50,000+ finishers)
    > Highly heterogeneous field
    > More tactical race, with slower winning times
- Chicago Marathon
    > Flat and fast course
    > Frequently used for personal bests
    > Large field with wide performance variability
- Boston Marathon
    > Qualification-based entry
    > Smaller but more selective field
    > Known for high competitiveness despite slower absolute times

### Why This Matters
The observed patterns in the 2023 dataset are consistent with the historical characteristics of major U.S. marathons.


