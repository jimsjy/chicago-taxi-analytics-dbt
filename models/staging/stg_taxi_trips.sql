with source as (
    select *
    from `bigquery-public-data.chicago_taxi_trips.taxi_trips`
)
select *
from source
