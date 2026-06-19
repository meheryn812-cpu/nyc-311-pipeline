INSERT INTO raw_311_requests (
    unique_key,
    created_date,
    closed_date,
    agency,
    agency_name,
    complaint_type,
    descriptor,
    status,
    borough,
    latitude,
    longitude
)
SELECT
    unique_key,
    NULLIF(created_date, '')::TIMESTAMP,
    NULLIF(closed_date, '')::TIMESTAMP,
    agency,
    agency_name,
    problem AS complaint_type,
    problem_detail AS descriptor,
    status,
    borough,
    NULLIF(latitude, '')::NUMERIC,
    NULLIF(longitude, '')::NUMERIC
FROM temp_311_csv_full
WHERE unique_key IS NOT NULL
  AND unique_key <> ''
ON CONFLICT (unique_key) DO NOTHING;