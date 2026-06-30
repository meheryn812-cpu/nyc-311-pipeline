# Model Quality Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This document summarizes the quality checks used to validate the dimensional data model.

## Tables Checked

- `stg_311_requests`
- `dim_agency`
- `dim_borough`
- `dim_complaint_type`
- `fact_service_requests`

## Model Structure

The project uses a star-schema-style model.

The central fact table is:

`fact_service_requests`

The dimension tables are:

- `dim_agency`
- `dim_borough`
- `dim_complaint_type`

## Checks Included

### 1. Staging vs. Fact Row Count

Compares `stg_311_requests` and `fact_service_requests` to confirm that records were not unexpectedly lost when creating the fact table.

### 2. Missing Request IDs

Checks whether any fact table records are missing `request_id`.

### 3. Duplicate Request IDs

Checks whether the same service request appears more than once in the fact table.

### 4. Missing Foreign Keys

Checks for missing:

- `agency_id`
- `borough_id`
- `complaint_type_id`

Missing foreign keys may indicate missing or unmatched dimension values.

### 5. Broken Dimension Joins

Checks whether fact table foreign keys correctly join to the dimension tables.

The checks validate relationships between:

- `fact_service_requests.agency_id` and `dim_agency.agency_id`
- `fact_service_requests.borough_id` and `dim_borough.borough_id`
- `fact_service_requests.complaint_type_id` and `dim_complaint_type.complaint_type_id`

### 6. Response Time Values

Checks minimum, maximum, and average response hours.

### 7. Negative Response Times

Checks whether any records have negative response hours.

### 8. Business Summary Queries

Runs final model queries to summarize requests by:

- Borough
- Agency
- Complaint type
- Status

## Why This Matters

Model quality checks confirm that the fact and dimension tables work together correctly. These checks help ensure that the data model is reliable for reporting, dashboards, and business analysis.

## Findings

The fact table contains 75248 records, matching the staging table row count. This confirms that no records were lost when creating the fact table from the staging table.

No missing or duplicate request IDs were found in the fact table.

No missing agency IDs or complaint type IDs were found. There are 51 records with missing borough IDs because the source data contained blank or missing borough values.

The model quality checks confirmed that agency, borough, and complaint type foreign keys join correctly to their dimension tables. No broken joins were found.

No negative response time values were found. Valid response times range from 0.00 hours to 364.47 hours, with an average response time of 14.81 hours.

The model supports analysis by status, borough, agency, complaint type, date, and response time.

Top findings from the model include:

- NYPD has the highest request volume with 38,729 requests.
- Manhattan has the highest borough request volume with 34,729 requests.
- The overall average response time for valid closed records is 14.81 hours.
- HPD has a higher average response time than NYPD in this sample.