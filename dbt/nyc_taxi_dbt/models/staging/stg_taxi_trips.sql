SELECT
    vendor_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    payment_type,
    fare_amount,
    tip_amount,
    total_amount,
    pu_location_id,
    do_location_id,
    source_file
FROM {{ source('staging', 'yellow_taxi_trips_clean') }}
