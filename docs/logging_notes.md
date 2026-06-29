# Logging and Error Handling Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This project includes logging and error handling to make the Python ETL process easier to monitor and troubleshoot.

## Scripts Updated

- `extract/extract_311_api.py`
- `load/load_api_to_postgres.py`

## Logging Added

The scripts now log:

- Start of each process
- API status code
- Number of rows extracted
- Number of rows prepared for loading
- Column names found
- Output file paths
- Successful completion
- Error messages if a failure occurs

## Why This Matters

Logging helps data engineers understand what happened during a pipeline run. If a job fails, logs make it easier to identify whether the issue happened during extraction, cleaning, loading, database connection, or data insertion.

## Common Errors Handled

- API request failures
- Empty API responses
- Missing input files
- Missing expected columns
- Invalid dates
- Empty records for insertion
- PostgreSQL load failures