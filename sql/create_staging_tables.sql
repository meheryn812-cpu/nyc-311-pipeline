-- =====================================================
-- Create Staging Tables
-- Project: NYC 311 Data Engineering Pipeline
-- Source table: raw_311_requests
-- Target table: stg_311_requests
-- =====================================================

DROP TABLE IF EXISTS stg_311_requests;

CREATE TABLE stg_311_requests AS
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

FROM raw_311_requests
WHERE unique_key IS NOT NULL
  AND created_date IS NOT NULL;


ALTER TABLE stg_311_requests
ADD CONSTRAINT stg_311_requests_pkey PRIMARY KEY (request_id);


CREATE INDEX idx_stg_311_created_date
ON stg_311_requests (created_date);


CREATE INDEX idx_stg_311_borough
ON stg_311_requests (borough);


CREATE INDEX idx_stg_311_agency
ON stg_311_requests (agency);


CREATE INDEX idx_stg_311_complaint_type
ON stg_311_requests (complaint_type); 