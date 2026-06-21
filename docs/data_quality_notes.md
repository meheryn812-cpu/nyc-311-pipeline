# Data Quality Notes

## Project

NYC 311 Data Engineering Pipeline

## Table Checked

'raw_311_requests'

## Purpose

This document summarizes the data quality checks used to validate the raw NYC 311 service request data after loading it into PostgreSQL.

## Checks Included

### 1. Row Count
Confirms the total number of records loaded into the raw table.

### 2. Missing Primary Keys
Checks whether any records are missing 'unique_key', which is the primary identifier for each 311 request.

### 3. Duplicate Primary Keys
Checks whether the same 'unique_key' appears more than once.

### 4. Missing Created Dates
Checks whether any service requests are missing a 'created_date'.

### 5. Missing Closed Dates
Checks how many records are missing a 'closed_date'. This may happen for open or unresolved requests.

### 6. Invalid Date Order
Checks whether any records have a 'closed_date' earlier than the 'created_date'.

### 7. Borough Values
Reviews the distribution of records by borough and identifies missing or unspecified boroughs.

### 8. Missing Coordinates
Checks whether records are missing latitude or longitude values.

### 9. Status Values
Reviews the number of records by status, such as Open or Closed.

### 10. Complaint Types
Identifies the most common complaint types in the datatset.

### 11. Agency Values
Identifies the agencies with the highest number of service requests.

### 12. Date Range 
Checks the earliest and latest created and closed dates in the dataset.

### 13. Response Time
Calculates average response time using the difference between 'created_date' and 'closed_date'.

## Why This Matters
Data quality checks help confirm that the dataset is usable before transformation, reporting, or analysis. These checks help identify missing values, duplicate records, invalid dates, and incomplete location information.

## Data Engineering Relevance
In a real data pipeline, data quality checks help prevent bad data from flowing into downstream tables, dashboards, and reports. They also make the pipeline easier to audint and troubleshoot. 