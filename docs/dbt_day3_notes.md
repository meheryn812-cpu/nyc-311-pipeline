# Week 4 Day 3: dbt Dimension Models

## Project

NYC 311 Data Engineering Pipeline

## Goal

Create dbt dimension models for the NYC 311 data model.

## Completed

- Created a `models/marts` folder
- Created the `dim_agency` dbt model
- Created the `dim_borough` dbt model
- Created the `dim_complaint_type` dbt model
- Materialized dimension models as tables
- Built dimension models from the dbt staging model `stg_311_requests`
- Added documentation for dimension models and columns
- Added dbt tests for primary key uniqueness and not-null checks
- Added an accepted values test for borough
- Generated dbt documentation artifacts

## dbt Models Created

- `dbt_dev.dim_agency`
- `dbt_dev.dim_borough`
- `dbt_dev.dim_complaint_type`

## Model Flow

```text
public.raw_311_requests
→ dbt_dev.stg_311_requests
→ dbt_dev.dim_agency
→ dbt_dev.dim_borough
→ dbt_dev.dim_complaint_type