SELECT
    trip_id,
    pickup_date,
    pickup_hour,
    vendor_id,
    pu_location_id,
    do_location_id,
    payment_type,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    source_file,
    loaded_at
FROM warehouse.fact_taxi_trip_final
