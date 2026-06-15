# NYC 311 Data Engineering Pipeline

## Project Overview

This project builds an end-to-end data engineering pipeline using NYC 311 service request data. The pipeline extracts data from a public API, loads the raw data into PostgreSQL, transforms it into analytics-ready tables, runs data quality checks, and documents the workflow for reproducibility.

## Business Problem

City agencies need reliable service request data to understand complaint volume, response times, and trends across boroughs, agencies, and complaint categories.

## Dataset

The project uses NYC 311 service request data.

## Tools Used

- Python
- PostgreSQL
- SQL
- dbt
- Airflow
- GitHub

## Pipeline Steps

1. Extract service request data from the NYC 311 API.
2. Save the raw data.
3. Load the raw data into PostgreSQL.
4. Clean and standardize the records.
5. Create staging tables.
6. Create fact and dimension tables.
7. Run data quality checks.
8. Schedule the workflow with Airflow.
9. Document the project in GitHub.

## Expected Output

The final output will include analytics-ready tables showing service request volume by borough, agency, complaint type, status, and response time.

## Why This Project Matters

This project demonstrates core data engineering responsibilities: extracting, loading, transforming, validating, orchestrating, and documenting data workflows.