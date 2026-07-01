# Week 4 Day 4: dbt Fact Model

## Project

NYC 311 Data Engineering Pipeline

## Goal

Create a dbt fact model for NYC 311 service requests.

## Completed

* Created the dbt fact model `fact_service_requests`
* Built the fact model from the dbt staging model and dimension models
* Joined `stg_311_requests` to `dim_agency`
* Joined `stg_311_requests` to `dim_borough`
* Joined `stg_311_requests` to `dim_complaint_type`
* Materialized the fact model as a table
* Added documentation for fact model columns
* Added dbt tests for uniqueness, not-null checks, accepted values, and relationships
* Validated fact table row count against the dbt staging model
* Generated updated dbt documentation artifacts

## dbt Model Created

`dbt_dev.fact_service_requests`

## Model Flow

```text
public.raw_311_requests
→ dbt_dev.stg_311_requests
→ dbt_dev.dim_agency
→ dbt_dev.dim_borough
→ dbt_dev.dim_complaint_type
→ dbt_dev.fact_service_requests
```

## Fact Table Grain

The grain of `fact_service_requests` is one row per NYC 311 service request.

## Key Columns

* `request_id`
* `created_date`
* `closed_date`
* `status`
* `response_hours`
* `latitude`
* `longitude`
* `agency_id`
* `borough_id`
* `complaint_type_id`
* `raw_loaded_at`
* `fact_created_at`

## Relationships

The fact model connects to the dimension models through the following keys:

```text
fact_service_requests.agency_id
→ dim_agency.agency_id

fact_service_requests.borough_id
→ dim_borough.borough_id

fact_service_requests.complaint_type_id
→ dim_complaint_type.complaint_type_id
```

## Validation

The dbt fact model row count was compared to the dbt staging model row count.

Expected row count:

```text
75,248 records
```

The model was also validated using dbt tests for:

* Unique request IDs
* Non-null request IDs
* Non-null created dates
* Accepted status values
* Non-null agency IDs
* Agency relationship integrity
* Borough relationship integrity
* Non-null complaint type IDs
* Complaint type relationship integrity

## Known Data Quality Note

Some records have missing `borough_id` values because the source data contained blank or missing borough values. These records are still valid for agency, complaint type, status, date, and response time analysis, but they are not usable for borough-level analysis.

## Why This Matters

The fact model creates the central analytics table for the NYC 311 data model. It connects service request events to descriptive dimension models, making the data ready for analysis and reporting by agency, borough, complaint type, status, date, and response time.
