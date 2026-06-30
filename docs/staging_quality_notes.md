# Staging Quality Notes

## Project

NYC 311 Data Engineering Pipeline

## Table Checked

`stg_311_requests`

## Purpose

This document summarizes the quality checks used to validate the staging table before building analytics-ready fact and dimension tables.

## Staging Table Purpose

The staging table cleans and standardizes records from the raw table. It prepares the data for downstream modeling by renaming fields, standardizing text values, cleaning borough values, and calculating response time.

## Checks Included

### 1. Raw vs. Staging Row Count

Compares `raw_311_requests` and `stg_311_requests` to confirm records were not unexpectedly lost.

### 2. Missing Request IDs

Checks whether any rows are missing `request_id`.

### 3. Duplicate Request IDs

Checks whether the same request appears more than once.

### 4. Missing Created Dates

Checks whether records are missing `created_date`.

### 5. Missing Closed Dates

Checks whether records are missing `closed_date`. This may happen when a request is still open.

### 6. Invalid Date Order

Checks whether any `closed_date` occurs before `created_date`.

### 7. Negative Response Hours

Checks whether calculated response times are negative.

### 8. Borough Values

Reviews borough values after standardization.

### 9. Status Values

Reviews status values after standardization.

### 10. Missing Complaint Types

Checks whether records are missing complaint categories.

### 11. Missing Agencies

Checks whether records are missing agency codes or agency names.

### 12. Missing Coordinates

Checks whether records are missing latitude or longitude.

### 13. Date Range

Checks the earliest and latest created dates in the staging table.

## Why This Matters

Staging quality checks confirm that the cleaned data is reliable before creating fact and dimension tables. This helps prevent bad or incomplete data from flowing into reporting-ready tables.

