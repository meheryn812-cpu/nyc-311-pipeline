{{ config(materialized='table') }}

WITH service_requests AS (

    SELECT
        *
    FROM {{ ref('stg_311_requests') }}

),

agency AS (

    SELECT
        *
    FROM {{ ref('dim_agency') }}

),

borough AS (

    SELECT
        *
    FROM {{ ref('dim_borough') }}

),

complaint_type AS (

    SELECT
        *
    FROM {{ ref('dim_complaint_type') }}

),

final AS (

    SELECT
        s.request_id,

        s.created_date,
        s.closed_date,

        s.status,
        s.response_hours,

        s.latitude,
        s.longitude,

        a.agency_id,
        b.borough_id,
        c.complaint_type_id,

        s.raw_loaded_at,
        CURRENT_TIMESTAMP AS fact_created_at

    FROM service_requests s

    LEFT JOIN agency a
        ON s.agency = a.agency
       AND s.agency_name = a.agency_name

    LEFT JOIN borough b
        ON s.borough = b.borough

    LEFT JOIN complaint_type c
        ON s.complaint_type = c.complaint_type

)

SELECT *
FROM final