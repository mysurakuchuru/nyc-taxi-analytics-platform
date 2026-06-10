CREATE INDEX IF NOT EXISTS idx_fact_pickup_date
ON warehouse.fact_taxi_trip_final(pickup_date);

CREATE INDEX IF NOT EXISTS idx_fact_pickup_hour
ON warehouse.fact_taxi_trip_final(pickup_hour);

CREATE INDEX IF NOT EXISTS idx_fact_pu_location
ON warehouse.fact_taxi_trip_final(pu_location_id);

CREATE INDEX IF NOT EXISTS idx_fact_do_location
ON warehouse.fact_taxi_trip_final(do_location_id);

CREATE INDEX IF NOT EXISTS idx_fact_payment_type
ON warehouse.fact_taxi_trip_final(payment_type);
