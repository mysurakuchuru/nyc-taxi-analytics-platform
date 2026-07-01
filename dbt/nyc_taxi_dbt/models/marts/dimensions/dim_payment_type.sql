SELECT
    payment_type,
    payment_description
FROM {{ source('warehouse', 'dim_payment_type') }}
