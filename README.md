# NYC 311 Data Engineering Pipeline

## Project Overview

This projects builds an end-to-end engineering pipeline using NYC 311 service request data. The project begins by loading a raw CSV extract into PostgreSQL to explore the data structure, practice SQL, and build a foundation for data modeling. Later, the pipeline will be automated using Python to extract data from the NYC 311 API, load it into PostgreSQL, transform it into analytics-ready tables, runs data quality checks, and orchestrate the workflow with Airflow.

## Business Problem
City agencies need reliable service request data to understand complaint volume, response times, 
and trends across boroughs, agencies, and complaint categories.

## Dataset
The project uses NYC 311 Service Request data.

## Tools Used
- Python
- PostgreSQL
- SQL
- dbt
- Airflow
- GitHub
- VS Code

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

## Python ETL Pipeline

The project includes a Python ETL pipeline that runs the workflow from API extraction to PostgreSQL loading.

Main pipeline command:

```bash
python run_pipeline.py
```

## Data Modeling Layers

The project uses a layered data modeling approach.

### Raw Layer

The raw layer stores source data loaded from the NYC 311 CSV/API process.

Main table:

- `raw_311_requests`

### Staging Layer

The staging layer cleans and standardizes raw data before analytics modeling.

Main table:

- `stg_311_requests`

The staging table is validated using SQL checks for row counts, missing request IDs, duplicate request IDs, missing dates, invalid date order, response time values, borough values, status values, missing complaint types, missing agencies, and missing coordinates.

### Mart Layer

The mart layer contains analytics-ready tables for reporting and analysis.

Current dimension tables:

- `dim_agency`
- `dim_borough`
- `dim_complaint_type`

Planned fact table:

- `fact_service_requests`

The dimension tables store unique descriptive values for agencies, boroughs, and complaint types. These tables will connect to the future fact table using ID fields.


## Data Quality Checks

The project includes SQL-based data quality checks for row counts, missing primary keys, duplicate records, missing dates, invalid date order, missing boroughs, missing coordinates, status values, complaint type distribution, agency distribution, and response time calculations.

## Expected Output
The final output will include analytics-ready tables showing service request volume by borough, 
agency, complaint type, status, and response time. 

## Why This Project Matters

This project demonstrates core data engineering responsibilities: loading raw data, exploring database tables, transforming records, validating data quality, automating extraction, orchestrating workflows, and documenting technical processes. 

1. Download a raw NYC 311 CSV sample.
2. Load the raw data into PostgreSQL.
3. Explore the data using SQL.
4. Clean and standardize the records.
5. Create staging tables.
6. Create fact and dimension tables.
7. Replace the manual CSV download with Python API extraction.
8. Run data quality checks.
9. Schedule the workflow with Airflow.
10. Document the full project in GitHub.


## Project Status

Current status: **Week 2 Complete — Python ETL Pipeline**

The project now includes a repeatable Python ETL workflow that extracts NYC 311 data from the API, saves a raw file, cleans and standardizes the data, loads it into PostgreSQL, and logs pipeline activity.

Next step: **Week 3 — Data Modeling and Staging Tables**
