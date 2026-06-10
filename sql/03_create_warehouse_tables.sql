CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.dim_zone CASCADE;

CREATE TABLE warehouse.dim_zone AS
SELECT DISTINCT
    location_id,
    borough,
    zone,
    service_zone
FROM raw.taxi_zones;

DROP TABLE IF EXISTS warehouse.fact_taxi_trip CASCADE;

CREATE TABLE warehouse.fact_taxi_trip AS
SELECT
    ROW_NUMBER() OVER () AS trip_id,
    vendor_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    DATE(tpep_pickup_datetime) AS pickup_date,
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,
    pu_location_id,
    do_location_id,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    payment_type,
    source_file,
    loaded_at
FROM staging.yellow_taxi_trips_clean;
