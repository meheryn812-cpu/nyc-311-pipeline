# Pipeline Run Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This document explains how the Python ETL pipeline runs from extraction to loading.

## Pipeline Script

`run_pipeline.py`

## Pipeline Steps

### 1. Extract NYC 311 API Data

Script:

`extract/extract_311_api.py`

This script connects to the NYC 311 API, extracts selected service request fields, and saves the raw API output to:

`data/raw/nyc_311_api_extract.csv`

### 2. Clean API Extract

Script:

`extract/clean_api_extract.py`

This script reads the raw API extract, selects expected columns, removes duplicate or missing keys, standardizes text fields, converts dates and coordinates, and saves the cleaned output to:

`data/processed/nyc_311_api_clean.csv`

### 3. Load Clean Data to PostgreSQL

Script:

`load/load_api_to_postgres.py`

This script reads the cleaned CSV and loads records into the PostgreSQL table:

`raw_311_requests`

Duplicate records are skipped using `ON CONFLICT (unique_key) DO NOTHING`.

## Logging

The pipeline creates logs in the `logs/` folder.

Main pipeline log:

`logs/run_pipeline.log`

Additional logs:

- `logs/extract_311_api.log`
- `logs/load_api_to_postgres.log`

## How to Run the Pipeline

From the project folder:

```bash
cd ~/Desktop/nyc-311-pipeline
source .venv/bin/activate
python run_pipeline.py