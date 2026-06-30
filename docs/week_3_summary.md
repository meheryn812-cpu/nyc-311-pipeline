# Week 3 Summary: Data Modeling and Star Schema

## Project

NYC 311 Data Engineering Pipeline

## Week 3 Focus

Week 3 focused on transforming the raw NYC 311 service request data into a cleaned, validated, analytics-ready data model.

The main goal was to build a star-schema-style model in PostgreSQL using staging, dimension, and fact tables.

## Tables Created

### Staging Table

- `stg_311_requests`

The staging table cleans and standardizes data from `raw_311_requests`.

Key transformations include:

- Renaming `unique_key` to `request_id`
- Standardizing agency, status, and borough values
- Cleaning blank or unspecified borough values
- Calculating `response_hours`
- Preserving raw load timestamps

### Dimension Tables

- `dim_agency`
- `dim_borough`
- `dim_complaint_type`

The dimension tables store descriptive values used for filtering, grouping, and reporting.

### Fact Table

- `fact_service_requests`

The fact table stores one row per NYC 311 service request and connects to the dimension tables using foreign keys.

The grain of the fact table is:

One row per NYC 311 service request.

## Model Structure

```text
raw_311_requests
        ↓
stg_311_requests
        ↓
dim_agency
dim_borough
dim_complaint_type
        ↓
fact_service_requests
```

## Fact and Dimension Relationships 

fact_service_requests.agency_id
→ dim_agency.agency_id

fact_service_requests.borough_id
→ dim_borough.borough_id

fact_service_requests.complaint_type_id
→ dim_complaint_type.complaint_type_id
