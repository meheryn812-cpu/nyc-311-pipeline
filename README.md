# NYC 311 Data Engineering Pipeline

## Project Overview
<<<<<<< HEAD

This project builds an end-to-end data engineering pipeline using NYC 311 service request data. The pipeline extracts data from a public API, loads the raw data into PostgreSQL, transforms it into analytics-ready tables, runs data quality checks, and documents the workflow for reproducibility.

## Business Problem

City agencies need reliable service request data to understand complaint volume, response times, and trends across boroughs, agencies, and complaint categories.

## Dataset

The project uses NYC 311 service request data.

## Tools Used

=======
This projects builds an end-to-end engineering pipeline using NYC 311 service request data. The project begins by loading a raw CSV extract into PostgreSQL to explore the data structure, practice SQL, and build a foundation for data modeling. Later, the pipeline will be automated using Python to extract data from the NYC 311 API, load it into PostgreSQL, transform it into analytics-ready tables, runs data quality checks, and orchestrate the workflow with Airflow.

## Business Problem
City agencies need reliable service request data to understand complaint volume, response times, 
and trends across boroughs, agencies, and complaint categories.

## Dataset
NYC 311 Service Request data.

## Tools Used
>>>>>>> 5c04f7dfd10c86f6ea4ac6fa6f4ff9e3535241fb
- Python
- PostgreSQL
- SQL
- dbt
- Airflow
- GitHub

## Pipeline Steps
<<<<<<< HEAD

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
=======
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

## Expected Output
The final output will include analytics-ready tables showing service request volume by borough, 
agency, complaint type, status, and response time. 

## Why This Project Matters
This project demonstrates core data engineering responsibilities: loading raw data, exploring database tables, transforming records, validating data quality, automating extraction, orchestrating workflows, and documenting technical processes. 
>>>>>>> 5c04f7dfd10c86f6ea4ac6fa6f4ff9e3535241fb
