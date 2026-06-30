-- =====================================================
-- Staging Quality Checks
-- Project: NYC 311 Data Engineering Pipeline
-- Table: stg_311_requests
-- =====================================================


-- 1. Compare raw and staging row counts
SELECT
    'raw_311_requests' AS table_name,
    COUNT(*) AS row_count
FROM raw_311_requests

UNION ALL

SELECT
    'stg_311_requests' AS table_name,
    COUNT(*) AS row_count
FROM stg_311_requests;


-- 2. Check for missing request IDs
SELECT
    COUNT(*) AS missing_request_ids
FROM stg_311_requests
WHERE request_id IS NULL
   OR request_id = '';


-- 3. Check for duplicate request IDs
SELECT
    request_id,
    COUNT(*) AS duplicate_count
FROM stg_311_requests
GROUP BY request_id
HAVING COUNT(*) > 1;


-- 4. Check for missing created dates
SELECT
    COUNT(*) AS missing_created_dates
FROM stg_311_requests
WHERE created_date IS NULL;


-- 5. Check for missing closed dates
SELECT
    COUNT(*) AS missing_closed_dates
FROM stg_311_requests
WHERE closed_date IS NULL;


-- 6. Check for invalid date order
SELECT
    COUNT(*) AS invalid_date_order
FROM stg_311_requests
WHERE closed_date < created_date;


-- 7. Check for negative response hours
SELECT
    COUNT(*) AS negative_response_hours
FROM stg_311_requests
WHERE response_hours < 0;


-- 8. Check response hours summary
SELECT
    MIN(response_hours) AS min_response_hours,
    MAX(response_hours) AS max_response_hours,
    ROUND(AVG(response_hours), 2) AS avg_response_hours
FROM stg_311_requests
WHERE response_hours IS NOT NULL;


-- 9. Check borough values
SELECT
    borough,
    COUNT(*) AS total_records
FROM stg_311_requests
GROUP BY borough
ORDER BY total_records DESC;


-- 10. Check status values
SELECT
    status,
    COUNT(*) AS total_records
FROM stg_311_requests
GROUP BY status
ORDER BY total_records DESC;


-- 11. Check missing complaint types
SELECT
    COUNT(*) AS missing_complaint_types
FROM stg_311_requests
WHERE complaint_type IS NULL
   OR complaint_type = '';


-- 12. Check missing agencies
SELECT
    COUNT(*) AS missing_agencies
FROM stg_311_requests
WHERE agency IS NULL
   OR agency = '';


-- 13. Check missing agency names
SELECT
    COUNT(*) AS missing_agency_names
FROM stg_311_requests
WHERE agency_name IS NULL
   OR agency_name = '';


-- 14. Check missing coordinates
SELECT
    COUNT(*) FILTER (WHERE latitude IS NULL) AS missing_latitude,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS missing_longitude
FROM stg_311_requests;


-- 15. Check top complaint types
SELECT
    complaint_type,
    COUNT(*) AS total_requests
FROM stg_311_requests
GROUP BY complaint_type
ORDER BY total_requests DESC
LIMIT 20;


-- 16. Check top agencies
SELECT
    agency,
    agency_name,
    COUNT(*) AS total_requests
FROM stg_311_requests
GROUP BY agency, agency_name
ORDER BY total_requests DESC
LIMIT 20;


-- 17. Check created date range
SELECT
    MIN(created_date) AS earliest_created_date,
    MAX(created_date) AS latest_created_date
FROM stg_311_requests;


-- 18. Check staged date
SELECT
    DATE(staged_at) AS staged_date,
    COUNT(*) AS records_staged
FROM stg_311_requests
GROUP BY DATE(staged_at)
ORDER BY staged_date DESC;


-- 19. Preview staging data
SELECT
    request_id,
    created_date,
    closed_date,
    agency,
    agency_name,
    complaint_type,
    descriptor,
    status,
    borough,
    response_hours
FROM stg_311_requests
LIMIT 10;