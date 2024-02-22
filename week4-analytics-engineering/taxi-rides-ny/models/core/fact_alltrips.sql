{{
    config(
        materialized='table'
    )
}}

with green_tripdata as (
    select
        pickup_datetime,
        dropoff_datetime, 
        'Green' as service_type
    from {{ ref('stg_green_tripdata') }}
), 
yellow_tripdata as (
    select
        pickup_datetime,
        dropoff_datetime, 
        'Yellow' as service_type
    from {{ ref('stg_yellow_tripdata') }}
), 
fhv_tripdata as (
    select
        TIMESTAMP(CAST(pickup_datetime AS STRING)) AS pickup_datetime,
        TIMESTAMP(CAST(dropoff_datetime AS STRING)) AS dropoff_datetime,   
        'FHV' as service_type
    from {{ ref('stg_fhv_tripdata') }}
),
trips_unioned as (
    select * from green_tripdata
    union all 
    select * from yellow_tripdata
    union all
    select * from fhv_tripdata
)
select 
    trips_unioned.service_type, 
    trips_unioned.pickup_datetime, 
    trips_unioned.dropoff_datetime
from trips_unioned