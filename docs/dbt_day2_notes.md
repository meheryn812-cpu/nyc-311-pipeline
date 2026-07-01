# Week 4 Day 2: dbt Sources and Staging Model

## Project

NYC 311 Data Engineering Pipeline

## Goal

Create a dbt source definition and build a real dbt staging model from the raw PostgreSQL table.

## Completed

- Updated dbt target schema to `dbt_dev`
- Created a dbt source for `public.raw_311_requests`
- Created the dbt staging model `stg_311_requests`
- Used the dbt `source()` function to reference the raw table
- Standardized agency, status, and borough values
- Renamed `unique_key` to `request_id`
- Calculated `response_hours`
- Added source and model column documentation
- Added dbt tests for uniqueness and not-null checks
- Ran dbt model and tests

## Source Table

`public.raw_311_requests`

## dbt Staging Model

`dbt_dev.stg_311_requests`

## Why This Matters

The dbt source definition formally documents the raw table used by the project. The staging model moves SQL transformation logic into dbt, making the project easier to test, document, maintain, and extend.

## Validation

The dbt staging model row count was compared against the original PostgreSQL raw and staging tables.

Expected row count:

75,248 records