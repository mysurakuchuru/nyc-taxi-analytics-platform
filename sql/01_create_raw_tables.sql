CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.yellow_taxi_trips (
    vendor_id INTEGER,
    tpep_pickup_datetime TIMESTAMP,
    tpep_dropoff_datetime TIMESTAMP,
    passenger_count NUMERIC,
    trip_distance NUMERIC,
    ratecode_id NUMERIC,
    store_and_fwd_flag TEXT,
    pu_location_id INTEGER,
    do_location_id INTEGER,
    payment_type INTEGER,
    fare_amount NUMERIC,
    extra NUMERIC,
    mta_tax NUMERIC,
    tip_amount NUMERIC,
    tolls_amount NUMERIC,
    improvement_surcharge NUMERIC,
    total_amount NUMERIC,
    congestion_surcharge NUMERIC,
    airport_fee NUMERIC,
    cbd_congestion_fee NUMERIC,
    source_file TEXT,
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS raw.taxi_zones (
    location_id INTEGER,
    borough TEXT,
    zone TEXT,
    service_zone TEXT
);
