{{ config(materialized='table') }}

with trips as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)

select 
    trips.*
  , pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone
from trips
inner join dim_zones as pickup_zone
on trips.PUlocationID = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips.DOLocationID = dropoff_zone.locationid