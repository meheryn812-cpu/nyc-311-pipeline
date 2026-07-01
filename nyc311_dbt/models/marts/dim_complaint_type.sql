{{ config(materialized='table') }}

WITH complaint_type_values AS (

    SELECT DISTINCT
        complaint_type
    FROM {{ ref('stg_311_requests') }}
    WHERE complaint_type IS NOT NULL
      AND complaint_type <> ''

),

final AS (

    SELECT
        ROW_NUMBER() OVER (
            ORDER BY complaint_type
        ) AS complaint_type_id,

        complaint_type,
        CURRENT_TIMESTAMP AS created_at

    FROM complaint_type_values

)

SELECT *
FROM final