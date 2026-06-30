-- =====================================================
-- Model Quality Checks
-- Project: NYC 311 Data Engineering Pipeline
-- Tables:
--   stg_311_requests
--   dim_agency
--   dim_borough
--   dim_complaint_type
--   fact_service_requests
-- =====================================================


-- 1. Compare staging and fact table row counts
SELECT
    'stg_311_requests' AS table_name,
    COUNT(*) AS row_count
FROM stg_311_requests

UNION ALL

SELECT
    'fact_service_requests' AS table_name,
    COUNT(*) AS row_count
FROM fact_service_requests;


-- 2. Check for missing request IDs in fact table
SELECT
    COUNT(*) AS missing_request_ids
FROM fact_service_requests
WHERE request_id IS NULL
   OR request_id = '';


-- 3. Check for duplicate request IDs in fact table
SELECT
    request_id,
    COUNT(*) AS duplicate_count
FROM fact_service_requests
GROUP BY request_id
HAVING COUNT(*) > 1;


-- 4. Check missing agency foreign keys
SELECT
    COUNT(*) AS missing_agency_ids
FROM fact_service_requests
WHERE agency_id IS NULL;


-- 5. Check missing borough foreign keys
SELECT
    COUNT(*) AS missing_borough_ids
FROM fact_service_requests
WHERE borough_id IS NULL;


-- 6. Check missing complaint type foreign keys
SELECT
    COUNT(*) AS missing_complaint_type_ids
FROM fact_service_requests
WHERE complaint_type_id IS NULL;


-- 7. Check whether agency foreign keys join correctly
SELECT
    COUNT(*) AS broken_agency_joins
FROM fact_service_requests f
LEFT JOIN dim_agency a
    ON f.agency_id = a.agency_id
WHERE f.agency_id IS NOT NULL
  AND a.agency_id IS NULL;


-- 8. Check whether borough foreign keys join correctly
SELECT
    COUNT(*) AS broken_borough_joins
FROM fact_service_requests f
LEFT JOIN dim_borough b
    ON f.borough_id = b.borough_id
WHERE f.borough_id IS NOT NULL
  AND b.borough_id IS NULL;


-- 9. Check whether complaint type foreign keys join correctly
SELECT
    COUNT(*) AS broken_complaint_type_joins
FROM fact_service_requests f
LEFT JOIN dim_complaint_type c
    ON f.complaint_type_id = c.complaint_type_id
WHERE f.complaint_type_id IS NOT NULL
  AND c.complaint_type_id IS NULL;


-- 10. Check response time values
SELECT
    MIN(response_hours) AS min_response_hours,
    MAX(response_hours) AS max_response_hours,
    ROUND(AVG(response_hours), 2) AS avg_response_hours
FROM fact_service_requests
WHERE response_hours IS NOT NULL;


-- 11. Check negative response hours
SELECT
    COUNT(*) AS negative_response_hours
FROM fact_service_requests
WHERE response_hours < 0;


-- 12. Check status distribution
SELECT
    status,
    COUNT(*) AS total_requests
FROM fact_service_requests
GROUP BY status
ORDER BY total_requests DESC;


-- 13. Check requests by borough using fact and dimension tables
SELECT
    b.borough,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_borough b
    ON f.borough_id = b.borough_id
GROUP BY b.borough
ORDER BY total_requests DESC;


-- 14. Check requests by agency using fact and dimension tables
SELECT
    a.agency,
    a.agency_name,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_agency a
    ON f.agency_id = a.agency_id
GROUP BY a.agency, a.agency_name
ORDER BY total_requests DESC
LIMIT 20;


-- 15. Check requests by complaint type using fact and dimension tables
SELECT
    c.complaint_type,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_complaint_type c
    ON f.complaint_type_id = c.complaint_type_id
GROUP BY c.complaint_type
ORDER BY total_requests DESC
LIMIT 20;


-- 16. Check created date range in fact table
SELECT
    MIN(created_date) AS earliest_created_date,
    MAX(created_date) AS latest_created_date
FROM fact_service_requests;


-- 17. Check fact table creation date
SELECT
    DATE(fact_created_at) AS fact_created_date,
    COUNT(*) AS records_created
FROM fact_service_requests
GROUP BY DATE(fact_created_at)
ORDER BY fact_created_date DESC;


-- 18. Preview final model output
SELECT
    f.request_id,
    f.created_date,
    f.closed_date,
    f.status,
    f.response_hours,
    a.agency,
    a.agency_name,
    b.borough,
    c.complaint_type
FROM fact_service_requests f
LEFT JOIN dim_agency a
    ON f.agency_id = a.agency_id
LEFT JOIN dim_borough b
    ON f.borough_id = b.borough_id
LEFT JOIN dim_complaint_type c
    ON f.complaint_type_id = c.complaint_type_id
LIMIT 10;
