SELECT
    location_id,
    borough,
    zone,
    service_zone
FROM {{ source('warehouse', 'dim_zone') }}
