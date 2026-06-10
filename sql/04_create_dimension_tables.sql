CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.dim_date CASCADE;

CREATE TABLE warehouse.dim_date AS
SELECT DISTINCT
    DATE(tpep_pickup_datetime) AS pickup_date,
    EXTRACT(YEAR FROM tpep_pickup_datetime)::INT AS year,
    EXTRACT(MONTH FROM tpep_pickup_datetime)::INT AS month,
    TO_CHAR(tpep_pickup_datetime, 'Month') AS month_name,
    EXTRACT(DAY FROM tpep_pickup_datetime)::INT AS day,
    EXTRACT(DOW FROM tpep_pickup_datetime)::INT AS day_of_week,
    TO_CHAR(tpep_pickup_datetime, 'Day') AS day_name,
    CASE 
        WHEN EXTRACT(DOW FROM tpep_pickup_datetime) IN (0, 6) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM staging.yellow_taxi_trips_clean;


DROP TABLE IF EXISTS warehouse.dim_time CASCADE;

CREATE TABLE warehouse.dim_time AS
SELECT DISTINCT
    EXTRACT(HOUR FROM tpep_pickup_datetime)::INT AS pickup_hour,
    CASE
        WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS time_period
FROM staging.yellow_taxi_trips_clean;


DROP TABLE IF EXISTS warehouse.dim_payment_type CASCADE;

CREATE TABLE warehouse.dim_payment_type (
    payment_type INT PRIMARY KEY,
    payment_description TEXT
);

INSERT INTO warehouse.dim_payment_type VALUES
(1, 'Credit Card'),
(2, 'Cash'),
(3, 'No Charge'),
(4, 'Dispute'),
(5, 'Unknown'),
(6, 'Voided Trip')
ON CONFLICT (payment_type) DO NOTHING;


DROP TABLE IF EXISTS warehouse.dim_rate_code CASCADE;

CREATE TABLE warehouse.dim_rate_code (
    ratecode_id INT PRIMARY KEY,
    rate_description TEXT
);

INSERT INTO warehouse.dim_rate_code VALUES
(1, 'Standard Rate'),
(2, 'JFK'),
(3, 'Newark'),
(4, 'Nassau or Westchester'),
(5, 'Negotiated Fare'),
(6, 'Group Ride')
ON CONFLICT (ratecode_id) DO NOTHING;
