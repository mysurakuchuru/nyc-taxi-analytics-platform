SELECT
    pickup_hour,
    time_period
FROM {{ source('warehouse', 'dim_time') }}
