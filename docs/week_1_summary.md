# Week 1 Summary

## Project

NYC 311 Data Engineering Pipeline

## Week 1 Focus

The focus of Week 1 was building the SQL and PostgreSQL foundation for the data engineering pipeline.

## What I Built

I created the initial project structure, set up a PostgreSQL database, created a raw data table, loaded NYC 311 service request data, wrote SQL analysis queries, and added SQL-based data quality checks.

## Tools Used

- PostgreSQL
- Postgres.app
- SQL
- GitHub
- VS Code
- Markdown

## Database Created

Database name:

`nyc_311_pipeline`

Main table:

`raw_311_requests`

## Key Table Column

- `unique_key`
- `created_date`
- `closed_date`
- `agency`
- `agency_name`
- `complaint_type`
- `descriptor`
- `status`
- `borough`
- `latitude`
- `longitude`
- `raw_loaded_at`

## SQL Skills Practiced

- Creating tables
- Loading CSV data
- Selecting records
- Filtering records
- Grouping and aggregating data
- Counting records
- Checking missing values
- Checking duplicate values
- Calculating response time
- Reviewing date ranges
- Validating data quality

## Data Quality Checks Added

The project includes checks for:

- Total row count
- Missing primary keys
- Duplicate records
- Missing created dates
- Missing closed dates
- Invalid date order
- Borough distribution
- Missing borough values
- Missing latitude and longitude
- Status distribution
- Complaint type distribution
- Agency distribution
- Created date range
- Closed date range
- Average response time
- Records loaded today

## What This Demonstrates

This project demonstrates my ability to ingest raw data into PostgreSQL, inspect the data with SQL, validate data quality, and document the workflow clearly.

## Next Step

In Week 2, I will replace the manual CSV process with Python ETL scripts that extract NYC 311 data, save the raw file, and load the data into PostgreSQL.