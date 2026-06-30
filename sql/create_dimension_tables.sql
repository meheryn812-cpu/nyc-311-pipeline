-- =====================================================
-- Create Dimension Tables
-- Project: NYC 311 Data Engineering Pipeline
-- Source table: stg_311_requests
-- Target tables:
--   dim_agency
--   dim_borough
--   dim_complaint_type
-- =====================================================


-- Drop existing dimension tables if they exist
DROP TABLE IF EXISTS dim_agency;
DROP TABLE IF EXISTS dim_borough;
DROP TABLE IF EXISTS dim_complaint_type;


-- =====================================================
-- Dimension: Agency
-- =====================================================

CREATE TABLE dim_agency AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY agency, agency_name
    ) AS agency_id,
    agency,
    agency_name,
    CURRENT_TIMESTAMP AS created_at
FROM (
    SELECT DISTINCT
        agency,
        agency_name
    FROM stg_311_requests
    WHERE agency IS NOT NULL
      AND agency <> ''
      AND agency_name IS NOT NULL
      AND agency_name <> ''
) agency_values;


ALTER TABLE dim_agency
ADD CONSTRAINT dim_agency_pkey PRIMARY KEY (agency_id);


CREATE UNIQUE INDEX idx_dim_agency_unique
ON dim_agency (agency, agency_name);


-- =====================================================
-- Dimension: Borough
-- =====================================================

CREATE TABLE dim_borough AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY borough
    ) AS borough_id,
    borough,
    CURRENT_TIMESTAMP AS created_at
FROM (
    SELECT DISTINCT
        borough
    FROM stg_311_requests
    WHERE borough IS NOT NULL
      AND borough <> ''
) borough_values;


ALTER TABLE dim_borough
ADD CONSTRAINT dim_borough_pkey PRIMARY KEY (borough_id);


CREATE UNIQUE INDEX idx_dim_borough_unique
ON dim_borough (borough);


-- =====================================================
-- Dimension: Complaint Type
-- =====================================================

CREATE TABLE dim_complaint_type AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY complaint_type
    ) AS complaint_type_id,
    complaint_type,
    CURRENT_TIMESTAMP AS created_at
FROM (
    SELECT DISTINCT
        complaint_type
    FROM stg_311_requests
    WHERE complaint_type IS NOT NULL
      AND complaint_type <> ''
) complaint_type_values;


ALTER TABLE dim_complaint_type
ADD CONSTRAINT dim_complaint_type_pkey PRIMARY KEY (complaint_type_id);


CREATE UNIQUE INDEX idx_dim_complaint_type_unique
ON dim_complaint_type (complaint_type);