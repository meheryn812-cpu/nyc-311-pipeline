-- =====================================================
-- Create Fact Table
-- Project: NYC 311 Data Engineering Pipeline
-- Source table: stg_311_requests
-- Dimension tables:
--   dim_agency
--   dim_borough
--   dim_complaint_type
-- Target table:
--   fact_service_requests
-- =====================================================


DROP TABLE IF EXISTS fact_service_requests;


CREATE TABLE fact_service_requests AS
SELECT
    s.request_id,

    s.created_date,
    s.closed_date,

    s.status,
    s.response_hours,

    s.latitude,
    s.longitude,

    a.agency_id,
    b.borough_id,
    c.complaint_type_id,

    s.raw_loaded_at,
    CURRENT_TIMESTAMP AS fact_created_at

FROM stg_311_requests s

LEFT JOIN dim_agency a
    ON s.agency = a.agency
   AND s.agency_name = a.agency_name

LEFT JOIN dim_borough b
    ON s.borough = b.borough

LEFT JOIN dim_complaint_type c
    ON s.complaint_type = c.complaint_type;


ALTER TABLE fact_service_requests
ADD CONSTRAINT fact_service_requests_pkey PRIMARY KEY (request_id);


ALTER TABLE fact_service_requests
ADD CONSTRAINT fact_service_requests_agency_fk
FOREIGN KEY (agency_id)
REFERENCES dim_agency (agency_id);


ALTER TABLE fact_service_requests
ADD CONSTRAINT fact_service_requests_borough_fk
FOREIGN KEY (borough_id)
REFERENCES dim_borough (borough_id);


ALTER TABLE fact_service_requests
ADD CONSTRAINT fact_service_requests_complaint_type_fk
FOREIGN KEY (complaint_type_id)
REFERENCES dim_complaint_type (complaint_type_id);


CREATE INDEX idx_fact_service_requests_created_date
ON fact_service_requests (created_date);


CREATE INDEX idx_fact_service_requests_status
ON fact_service_requests (status);


CREATE INDEX idx_fact_service_requests_agency_id
ON fact_service_requests (agency_id);


CREATE INDEX idx_fact_service_requests_borough_id
ON fact_service_requests (borough_id);


CREATE INDEX idx_fact_service_requests_complaint_type_id
ON fact_service_requests (complaint_type_id);