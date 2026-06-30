# Fact Table Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This document explains the `fact_service_requests` table created from the staging and dimension tables.

## Source Table

`stg_311_requests`

## Dimension Tables Used

- `dim_agency`
- `dim_borough`
- `dim_complaint_type`

## Fact Table Created

`fact_service_requests`

## Grain

The grain of the fact table is one row per NYC 311 service request.

Each row represents one service request event.

## Key Columns

- `request_id`
- `created_date`
- `closed_date`
- `status`
- `response_hours`
- `latitude`
- `longitude`
- `agency_id`
- `borough_id`
- `complaint_type_id`
- `raw_loaded_at`
- `fact_created_at`

## Foreign Keys

The fact table connects to the dimension tables using:

- `agency_id`
- `borough_id`
- `complaint_type_id`

## Why This Matters

The fact table stores the main service request events and connects them to descriptive dimension tables. This creates a star schema structure that supports reporting and analysis by agency, borough, complaint type, status, date, and response time.

## Example Questions This Table Supports

- How many 311 requests were created by borough?
- Which agencies handled the most requests?
- Which complaint types had the longest average response time?
- How many requests are open, closed, or in progress?
- How does response time vary by borough or agency?