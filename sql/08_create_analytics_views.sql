CREATE SCHEMA IF NOT EXISTS analytics;

CREATE OR REPLACE VIEW analytics.kpi_summary AS
SELECT
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_amount,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_trip_distance,
    ROUND(AVG(tip_amount)::numeric, 2) AS avg_tip
FROM warehouse.fact_taxi_trip_final;


CREATE OR REPLACE VIEW analytics.revenue_by_borough AS
SELECT
    z.borough,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(f.total_amount)::numeric, 2) AS avg_trip_amount
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.borough;


CREATE OR REPLACE VIEW analytics.top_pickup_zones AS
SELECT
    z.zone,
    z.borough,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.zone, z.borough;


CREATE OR REPLACE VIEW analytics.peak_pickup_hours AS
SELECT
    pickup_hour,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final
GROUP BY pickup_hour;


CREATE OR REPLACE VIEW analytics.payment_type_usage AS
SELECT
    p.payment_description,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_payment_type p
    ON f.payment_type = p.payment_type
GROUP BY p.payment_description;


CREATE OR REPLACE VIEW analytics.tip_percentage_by_borough AS
SELECT
    z.borough,
    ROUND(SUM(f.tip_amount)::numeric, 2) AS total_tips,
    ROUND(SUM(f.fare_amount)::numeric, 2) AS total_fare,
    ROUND((SUM(f.tip_amount) / NULLIF(SUM(f.fare_amount), 0) * 100)::numeric, 2) AS tip_percentage
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.borough;
