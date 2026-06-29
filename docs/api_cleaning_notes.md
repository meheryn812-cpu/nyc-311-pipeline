# API Cleaning Notes

## Project

NYC 311 Data Engineering Pipeline

## Source File

`data/raw/nyc_311_api_extract.csv`

## Clean Output File

`data/processed/nyc_311_api_clean.csv`

## Cleaning Steps

The API cleaning script performs the following steps:

- Selects expected columns
- Removes rows missing `unique_key`
- Removes duplicate `unique_key` values
- Trims extra spaces from text fields
- Standardizes borough values to uppercase
- Converts created and closed dates to datetime values
- Converts latitude and longitude to numeric values
- Removes rows missing `created_date`

## Why This Matters

Cleaning the API extract before loading it into PostgreSQL helps reduce load errors and makes the data more reliable for downstream SQL analysis, data quality checks, and future transformations.
