{{ config(materialized='table') }}

WITH agency_values AS (

    SELECT DISTINCT
        agency,
        agency_name
    FROM {{ ref('stg_311_requests') }}
    WHERE agency IS NOT NULL
      AND agency <> ''
      AND agency_name IS NOT NULL
      AND agency_name <> ''

),

final AS (

    SELECT
        ROW_NUMBER() OVER (
            ORDER BY agency, agency_name
        ) AS agency_id,

        agency,
        agency_name,
        CURRENT_TIMESTAMP AS created_at

    FROM agency_values

)

SELECT *
FROM final