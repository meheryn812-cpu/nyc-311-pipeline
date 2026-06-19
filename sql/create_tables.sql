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

DROP TABLE IF EXISTS temp_311_csv;

CREATE TABLE temp_311_csv (
    unique_key TEXT,
    created_date TEXT,
    closed_date TEXT,
    agency TEXT,
    agency_name TEXT,
    complaint_type TEXT,
    descriptor TEXT,
    status TEXT,
    borough TEXT,
    latitude TEXT,
    longitude Text);

  DROP TABLE IF EXISTS temp_311_csv_full;

CREATE TABLE temp_311_csv_full (
    unique_key TEXT,
    created_date TEXT,
    closed_date TEXT,
    agency TEXT,
    agency_name TEXT,
    problem TEXT,
    problem_detail TEXT,
    additional_details TEXT,
    location_type TEXT,
    incident_zip TEXT,
    incident_address TEXT,
    street_name TEXT,
    cross_street_1 TEXT,
    cross_street_2 TEXT,
    intersection_street_1 TEXT,
    intersection_street_2 TEXT,
    address_type TEXT,
    city TEXT,
    landmark TEXT,
    facility_type TEXT,
    status TEXT,
    due_date TEXT,
    resolution_description TEXT,
    resolution_action_updated_date TEXT,
    community_board TEXT,
    council_district TEXT,
    police_precinct TEXT,
    bbl TEXT,
    borough TEXT,
    x_coordinate_state_plane TEXT,
    y_coordinate_state_plane TEXT,
    open_data_channel_type TEXT,
    park_facility_name TEXT,
    park_borough TEXT,
    vehicle_type TEXT,
    taxi_company_borough TEXT,
    taxi_pick_up_location TEXT,
    bridge_highway_name TEXT,
    bridge_highway_direction TEXT,
    road_ramp TEXT,
    bridge_highway_segment TEXT,
    latitude TEXT,
    longitude TEXT,
    location TEXT
);  