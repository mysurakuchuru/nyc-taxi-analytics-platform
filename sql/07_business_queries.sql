-- 1. Overall KPI Summary
SELECT
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_amount,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_trip_distance,
    ROUND(AVG(tip_amount)::numeric, 2) AS avg_tip
FROM warehouse.fact_taxi_trip_final;


-- 2. Revenue by Borough
SELECT
    z.borough,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(f.total_amount)::numeric, 2) AS avg_trip_amount
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.borough
ORDER BY total_revenue DESC;


-- 3. Top 10 Pickup Zones by Revenue
SELECT
    z.zone,
    z.borough,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.zone, z.borough
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. Peak Pickup Hours
SELECT
    pickup_hour,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final
GROUP BY pickup_hour
ORDER BY total_trips DESC;


-- 5. Payment Type Usage
SELECT
    p.payment_description,
    COUNT(*) AS total_trips,
    ROUND(SUM(f.total_amount)::numeric, 2) AS total_revenue
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_payment_type p
    ON f.payment_type = p.payment_type
GROUP BY p.payment_description
ORDER BY total_trips DESC;


-- 6. Tip Percentage by Borough
SELECT
    z.borough,
    ROUND(SUM(f.tip_amount)::numeric, 2) AS total_tips,
    ROUND(SUM(f.fare_amount)::numeric, 2) AS total_fare,
    ROUND((SUM(f.tip_amount) / NULLIF(SUM(f.fare_amount), 0) * 100)::numeric, 2) AS tip_percentage
FROM warehouse.fact_taxi_trip_final f
JOIN warehouse.dim_zone z
    ON f.pu_location_id = z.location_id
GROUP BY z.borough
ORDER BY tip_percentage DESC;
