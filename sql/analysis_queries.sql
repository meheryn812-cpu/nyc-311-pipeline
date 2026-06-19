-- 1. View sample records
SELECT * FROM raw_311_requests
LIMIT 10;

-- 2. Count total requests 
SELECT COUNT(*) AS total_requests
FROM raw_311_requests;

-- 3. Count requests by borough
SELECT borough, COUNT(*) AS total_requests 
FROM raw_311_requests
GROUP BY borough
ORDER BY total_requests DESC;

-- 4. Count requests by agency
SELECT agency, COUNT(*) AS total_requests 
FROM raw_311_requests
GROUP BY agency
ORDER BY total_requests DESC;

-- 5. Count requests by complaint type
SELECT complaint_type, COUNT(*) AS total_requests
FROM raw_311_requests
GROUP BY complaint_type
ORDER BY total_requests DESC;

-- 6. Count open vs closed requests
SELECT status, COUNT(*) AS total_requests
FORM raw_311_requests
GROUP BY status
ORDER BY total_requests DESC;

-- 7. Requests created by date
SELECT date(created_date) AS request_date, COUNT(*) AS total_requests
FROM raw_311_requests
GROUP BY date(created_date)
ORDER BY request_date;

-- 8. Average response hours for closed requests
SELECT ROUND(AVG(EXTRACT(EPOCH FROM (closed_date - created_date)) / 3600), 2) AS avg_response_hours
FROM raw_311_requests
WHERE closed_date IS NOT NULL;

-- 9. Top complaint type by borough Manhattan
SELECT borough, complaint_type, COUNT(*) AS total_requests
FROM raw_311_requests
GROUP BY complaint_type
ORDER BY complaint_type DESC;

-- 10. Requests with missing borough
SELECT COUNT(*) AS missing_borough_count
FROM raw_311_requests
WHERE borough IS NULL OR borough='';


