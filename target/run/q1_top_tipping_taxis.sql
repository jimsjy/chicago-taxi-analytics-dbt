
  
    

    create or replace table `chicago-taxi-analytics`.`analytics`.`q1_top_tipping_taxis`
      
    
    

    
    OPTIONS()
    as (
      

WITH recent_trips AS (
    SELECT *
    FROM `chicago-taxi-analytics`.`analytics`.`stg_taxi_trips`
    WHERE trip_start_timestamp >= TIMESTAMP('2023-10-01')
      AND trip_start_timestamp <= TIMESTAMP('2023-12-31')
)

SELECT
    taxi_id,
    company,
    SUM(tips) AS total_tips,
    COUNT(*) AS total_trips
FROM recent_trips
GROUP BY taxi_id, company
ORDER BY total_tips DESC
LIMIT 100
    );
  