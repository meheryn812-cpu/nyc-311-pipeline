DROP TABLE IF EXISTS raw_311_requests;

CREATE TABLE raw_311_requests (
unique_key TEXT PRIMARY KEY,
created_date TIMESTAMP,
closed_date TIMESTAMP,
agency TEXT,
agency_name TEXT,
complaint_type TEXT,
descriptor TEXT,
status TEXT,
borough TEXT,
latitude NUMERIC,
longitude NUMERIC,
raw_loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);