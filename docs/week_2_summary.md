# Week 2 Summary

## Project

NYC 311 Data Engineering Pipeline

## Week 2 Focus

The focus of Week 2 was building a Python ETL workflow to extract NYC 311 data from the API, clean the data, and load it into PostgreSQL.

## What I Built

I created Python scripts that connect to the NYC 311 API, extract service request records, save the raw output as a CSV file, clean and standardize the data, and load the cleaned data into the PostgreSQL `raw_311_requests` table.

I also created a pipeline runner script that automates the full extract, clean, and load process.

## Tools Used

- Python
- pandas
- requests
- psycopg2
- PostgreSQL
- GitHub
- VS Code
- Markdown

## Scripts Created:

### `extract/test_api_connection.py`

Tests the connection to the NYC 311 API and confirms that expected records and fields are returned.

### `extract/extract_311_api.py`

Extracts NYC 311 service request records from the API and saves the raw output to:

`data/raw/nyc_311_api_extract.csv`

### `extract/clean_api_extract.py`

Cleans and standardizes the API extract by selecting expected columns, removing missing or duplicate keys, standardizing text values, converting dates, converting coordinates, and saving a processed file to:

`data/processed/nyc_311_api_clean.csv`

### `load/load_api_to_postgres.py`

Loads the cleaned API extract into the PostgreSQL table:

`raw_311_requests`

Duplicate records are skipped using:

`ON CONFLICT (unique_key) DO NOTHING`

### `run_pipeline.py`

Runs the full Python ETL workflow in order:

1. Extract NYC 311 API data
2. Clean the API extract
3. Load the cleaned data into PostgreSQL

## Logging and Error Handling

The ETL scripts include logging and error handling to make the pipeline easier to monitor and troubleshoot.

Logs are stored in the `logs/` folder.

The scripts log:

- Start and completion of ETL steps
- API status code
- Row counts
- Column names
- Output file paths
- Error messages

## Key Skills Practiced

- Connecting to an API with Python
- Extracting JSON data
- Converting API results into a pandas DataFrame
- Saving raw data as CSV
- Cleaning and standardizing data
- Handling missing dates and null values
- Loading data into PostgreSQL
- Avoiding duplicate inserts
- Adding logging and error handling
- Automating ETL steps with one pipeline script

## What This Demonstrates

This project demonstrates my ability to build a repeatable Python ETL process that extracts data from an external API, prepares it for database loading, inserts it into PostgreSQL, and records pipeline activity through logs.

## Next Step

In Week 3, I will create staging and analytics-ready tables, including fact and dimension tables, to turn the raw NYC 311 data into a structured data model for reporting and analysis.