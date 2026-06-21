-- ==========================================================================
-- Data Quality Checks for NYC 311 Raw Data
-- Table: raw_311_requests
-- ==========================================================================

-- 1. Total row count
SELECT COUNT(*) AS total_rows 
FROM raw_311_requests;

-- 2. Check for missing primary keys
SELECT COUNT(*) AS missing_unique_keys
FROM raw_311_requests
WHERE unique_key IS NULL
OR unique_key = '';

-- 3. Check for duplicate primary keys
SELECT unique_key, COUNT(*) AS duplicate_count
FROM raw_311_requests
GROUP BY unique_key
HAVING COUNT(*) > 1;

-- 4. Check for missing created dates
SELECT COUNT(*) AS missing_created_dates
FROM raw_311_requests
WHERE created_date is NULL;

-- 5. Check for missing closed dates
SELECT COUNT(*) AS missing_closed_dates
FROM raw_311_requests
WHERE closed_date IS NULL;

-- 6. Check for closed dates before created dates
SELECT COUNT(*) AS invalid_date_order
FROM raw_311_requests
WHERE closed_date < created_date;

-- 7. Check accepted borough values
SELECT borough, COUNT(*) AS total_records
FROM raw_311_requests
GROUP BY borough
ORDER BY total_records DESC;

-- 8. Check for missing borough values
SELECT COUNT(*) AS missing_boroughs
FROM raw_311_requests
WHERE borough is NULL
OR borough = ''
OR borough = 'Unspecified';

-- 9. Check missing latitude and longitude
SELECT
    COUNT(*) FILTER (WHERE latitude IS NULL) AS missing_latitude,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS missing_longitude
FROM raw_311_requests;

-- 10. Check records by status
SELECT status, COUNT(*) AS total_requests
FROM raw_311_requests
GROUP BY status
ORDER BY total_requests DESC;

-- 11. Check top complaint types
SELECT complaint_type, COUNT(*) AS total_complaints
FROM raw_311_requests
GROUP BY complaint_type
ORDER BY total_complaints DESC
LIMIT 20;

-- 12. Check top agencies 
SELECT agency, agency_name, COUNT(*) AS total_requests
FROM raw_311_requests
GROUP BY agency, agency_name
ORDER BY total_requests DESC
LIMIT 20;

-- 13. Check created date range
SELECT
    MIN(created_date) AS earliest_created_date
    MAX(created_date) AS latest_created_date
FROM raw_311_requests;

-- 14. Check closed date range
SELECT
    MIN(closed_date) AS earliest_closed_date,
    MAX(closed_date) AS latest_closed_date
FROM raw_311_requests
WHERE closed_date IS NOT NULL;

-- 15. Check average response time in hours
SELECT
    ROUND(AVG(EXTRACT(EPOCH FROM (closed_date - created_date)) / 3600), 2)
    AS avg_response_hours
FROM raw_311_requests
WHERE closed_date IS NOT NULL
AND closed_date >= created_date;

-- 16. Check response time by borough
SELECT borough, COUNT(*) AS total_closed_requests,
    ROUND(AVG(EXTRACT(EPOCH FROM (closed_date - created_date)) / 3600), 2)
    AS avg_response_hours
FROM raw_311_requests
WHERE closed_date IS NOT NULL
AND closed_date >= created_date
GROUP BY borough
ORDER BY avg_response_hours DESC;

-- 17. Check records loaded today
SELECT COUNT(*) AS records_loaded_today
FROM raw_311_requests
WHERE DATE(raw_loaded_at) = CURRENT_DATE;

-- 18. Check sample rows
SELECT * 
FROM raw_311_requests
LIMIT 10;