

  create or replace view `chicago-taxi-analytics`.`analytics`.`stg_taxi_trips`
  OPTIONS()
  as with source as (
    select *
    from `bigquery-public-data.chicago_taxi_trips.taxi_trips`
)
select *
from source;

