# Data Modeling Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This document explains the data modeling approach used in the project.

## Data Layers

### Raw Layer

The raw layer stores source data with minimal transformation.

Current raw table:

`raw_311_requests`

This table preserves the service request records loaded from the NYC 311 CSV/API process.

### Staging Layer

The staging layer cleans and standardizes raw records before they are used in analytics-ready tables.

Current staging table:

`stg_311_requests`

The staging table standardizes text fields, cleans borough values, renames `unique_key` to `request_id`, and calculates `response_hours`.

### Mart Layer

The mart layer will contain analytics-ready fact and dimension tables.

Planned mart tables:

- `dim_agency`
- `dim_borough`
- `dim_complaint_type`
- `fact_service_requests`

## Why This Matters

Data modeling makes raw data easier to query, validate, and use for reporting. Separating raw, staging, and mart layers creates a cleaner and more maintainable data pipeline. 
