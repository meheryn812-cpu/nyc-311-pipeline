WITH source AS (

    SELECT
        *
    FROM {{ source('nyc311', 'raw_311_requests') }}

),

renamed AS (

    SELECT
        unique_key AS request_id,

        created_date,
        closed_date,

        UPPER(TRIM(agency)) AS agency,
        TRIM(agency_name) AS agency_name,

        TRIM(complaint_type) AS complaint_type,
        TRIM(descriptor) AS descriptor,

        UPPER(TRIM(status)) AS status,

        CASE
            WHEN borough IS NULL THEN NULL
            WHEN TRIM(borough) = '' THEN NULL
            WHEN UPPER(TRIM(borough)) = 'UNSPECIFIED' THEN NULL
            ELSE UPPER(TRIM(borough))
        END AS borough,

        latitude,
        longitude,

        CASE
            WHEN closed_date IS NOT NULL
             AND created_date IS NOT NULL
             AND closed_date >= created_date
            THEN ROUND(
                (EXTRACT(EPOCH FROM (closed_date - created_date)) / 3600)::NUMERIC,
                2
            )
            ELSE NULL
        END AS response_hours,

        raw_loaded_at,
        CURRENT_TIMESTAMP AS staged_at

    FROM source
    WHERE unique_key IS NOT NULL
      AND created_date IS NOT NULL

)

SELECT *
FROM renamed
