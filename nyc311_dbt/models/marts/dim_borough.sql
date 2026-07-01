{{ config(materialized='table') }}

WITH borough_values AS (

    SELECT DISTINCT
        borough
    FROM {{ ref('stg_311_requests') }}
    WHERE borough IS NOT NULL
      AND borough <> ''

),

final AS (

    SELECT
        ROW_NUMBER() OVER (
            ORDER BY borough
        ) AS borough_id,

        borough,
        CURRENT_TIMESTAMP AS created_at

    FROM borough_values

)

SELECT *
FROM final