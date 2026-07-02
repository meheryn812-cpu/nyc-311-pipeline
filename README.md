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

## dbt Transformation Layer

The project includes a dbt transformation layer located in:

- `nyc311_dbt/`

The dbt layer is organized into:

- `models/staging/`
- `models/marts/`

The dbt layer includes:

- A source definition for `public.raw_311_requests`
- A staging model:
  - `stg_311_requests`
- Dimension models:
  - `dim_agency`
  - `dim_borough`
  - `dim_complaint_type`
- A fact model:
  - `fact_service_requests`
- Column documentation
- dbt tests for uniqueness, not-null checks, accepted values, and model relationships
- dbt documentation and lineage generation

The dbt models are built in the `dbt_dev` schema and transform raw NYC 311 records into cleaned, analytics-ready staging, dimension, and fact models.

## Data Model

The project uses a layered data model that moves data from raw ingestion to analytics-ready tables.

```text
raw_311_requests
→ stg_311_requests
→ dim_agency
→ dim_borough
→ dim_complaint_type
→ fact_service_requests
```

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

Current fact table:

- `fact_service_requests`

The dimension tables store descriptive values for agencies, boroughs, and complaint types. The fact table stores each 311 service request event and connects to the dimension tables using ID fields.

Together, these tables create a star schema that supports analysis by agency, borough, complaint type, status, date, and response time.


## Data Quality Checks

The project includes SQL-based data quality checks for row counts, missing primary keys, duplicate records, missing dates, invalid date order, missing boroughs, missing coordinates, status values, complaint type distribution, agency distribution, and response time calculations.

## Model Quality Checks

The project includes SQL checks to validate the dimensional model.

Model quality checks include:

- Staging vs. fact row count comparison
- Missing request IDs
- Duplicate request IDs
- Missing foreign keys
- Broken joins between fact and dimension tables
- Response time validation
- Status distribution
- Final business summary queries by borough, agency, and complaint type

## Data Dictionary

The project includes a data dictionary that documents the raw, staging, dimension, and fact tables used in the NYC 311 data model.

Data dictionary file:

- `docs/data_dictionary.md`

The data dictionary explains table purpose, column definitions, relationships, key metrics, and known data quality notes.


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

Current status: **Week 4 Completion: dbt Transformation Layer**

Week 4 focused on adding a dbt transformation layer to the NYC 311 pipeline.

Completed work includes:

- Created a dbt project inside `nyc311_dbt/`
- Configured dbt to connect to PostgreSQL
- Created a dbt source for `public.raw_311_requests`
- Built a staging model: `stg_311_requests`
- Built dimension models:
  - `dim_agency`
  - `dim_borough`
  - `dim_complaint_type`
- Built a fact model:
  - `fact_service_requests`
- Added source, model, and column documentation
- Added dbt tests for not-null, unique, accepted values, and relationships
- Generated and reviewed dbt documentation
- Reviewed model lineage from raw source to analytics-ready fact table
- Cleaned the dbt project structure for GitHub readiness

The dbt layer transforms raw NYC 311 data into cleaned, tested, analytics-ready staging, dimension, and fact models.


