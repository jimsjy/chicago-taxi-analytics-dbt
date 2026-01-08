

WITH daily_shifts AS (
    SELECT
        taxi_id,
        DATE(trip_start_timestamp) AS trip_date,
        TIMESTAMP_DIFF(
            MAX(trip_end_timestamp),
            MIN(trip_start_timestamp),
            HOUR
        ) AS shift_hours
    FROM `chicago-taxi-analytics`.`analytics`.`stg_taxi_trips`
    WHERE trip_start_timestamp BETWEEN
          TIMESTAMP('2023-10-01')
      AND TIMESTAMP('2023-12-31')
    GROUP BY taxi_id, DATE(trip_start_timestamp)
    HAVING shift_hours > 12
)

SELECT
    taxi_id,
    COUNT(*) AS long_shift_days,
    AVG(shift_hours) AS avg_shift_hours
FROM daily_shifts
GROUP BY taxi_id
ORDER BY long_shift_days DESC, avg_shift_hours DESC
LIMIT 100