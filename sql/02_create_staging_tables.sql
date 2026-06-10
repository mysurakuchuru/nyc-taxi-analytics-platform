CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.yellow_taxi_trips_clean AS
SELECT
    vendor_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    ratecode_id,
    store_and_fwd_flag,
    pu_location_id,
    do_location_id,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    airport_fee,
    cbd_congestion_fee,
    source_file,
    loaded_at
FROM raw.yellow_taxi_trips
WHERE trip_distance > 0
  AND fare_amount >= 0
  AND total_amount >= 0
  AND tpep_dropoff_datetime > tpep_pickup_datetime;
