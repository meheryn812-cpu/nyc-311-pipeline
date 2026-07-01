# Week 4 Day 1: dbt Setup

## Project

NYC 311 Data Engineering Pipeline

## Goal

Install dbt Core, connect dbt to PostgreSQL, create a dbt project, and run the first dbt model.

## Completed

- Installed `dbt-core`
- Installed `dbt-postgres`
- Created a dbt project named `nyc311_dbt`
- Configured `profiles.yml`
- Connected dbt to the local PostgreSQL database `nyc_311_pipeline`
- Ran `dbt debug`
- Created the first dbt staging model: `stg_311_requests_dbt`
- Ran the model using `dbt run`
- Verified the dbt-created view in PostgreSQL

## First dbt Model

Model file:

`nyc311_dbt/models/staging/stg_311_requests_dbt.sql`

Model SQL:

```sql
SELECT *
FROM public.stg_311_requests
```