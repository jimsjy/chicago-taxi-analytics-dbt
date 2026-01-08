

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