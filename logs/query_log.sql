-- created_at: 2026-01-08T16:47:39.045368500+00:00
-- finished_at: 2026-01-08T16:47:42.541298200+00:00
-- elapsed: 3.5s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: QPKfjqjIbaJCcN6uI9fakNseiVS
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "my_bigquery_project", "target_name": "dev"} */

    select distinct schema_name from `chicago-taxi-analytics`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2026-01-08T16:47:42.646781700+00:00
-- finished_at: 2026-01-08T16:47:46.025499+00:00
-- elapsed: 3.4s
-- outcome: success
-- dialect: bigquery
-- node_id: model.chicago-taxi-analytics.q3_holiday_trips
-- query_id: ew0ahl2OQKtL4fmpRGm3o02gKH4
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `chicago-taxi-analytics`.`analytics`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2026-01-08T16:47:46.029029200+00:00
-- finished_at: 2026-01-08T16:47:50.666278300+00:00
-- elapsed: 4.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.chicago-taxi-analytics.q3_holiday_trips
-- query_id: zBlngjRcJuHEpIXVDJ0LCPZdroo
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.chicago-taxi-analytics.q3_holiday_trips", "profile_name": "my_bigquery_project", "target_name": "dev"} */

  
    

    create or replace table `chicago-taxi-analytics`.`analytics`.`q3_holiday_trips`
      
    
    

    
    OPTIONS()
    as (
      

WITH trips_per_day AS (
    SELECT
        DATE(trip_start_timestamp) AS trip_date,
        COUNT(*) AS total_trips
    FROM `chicago-taxi-analytics`.`analytics`.`stg_taxi_trips`
    WHERE trip_start_timestamp BETWEEN
          TIMESTAMP('2023-10-01')
      AND TIMESTAMP('2023-12-31')
    GROUP BY trip_date
),

us_holidays AS (
    SELECT DATE('2023-10-10') AS holiday_date UNION ALL  -- Veterans Day
    SELECT DATE('2023-11-23') UNION ALL                  -- Thanksgiving
    SELECT DATE('2023-12-25')                            -- Christmas
)

SELECT
    t.trip_date,
    t.total_trips,
    CASE
        WHEN h.holiday_date IS NOT NULL THEN 'Holiday'
        ELSE 'Non-Holiday'
    END AS day_type
FROM trips_per_day t
LEFT JOIN us_holidays h
    ON t.trip_date = h.holiday_date
ORDER BY t.trip_date
    );
  ;
