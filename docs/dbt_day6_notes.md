# Week 4 Day 6: dbt Project Cleanup and Portfolio Readiness

## Project

NYC 311 Data Engineering Pipeline

## Goal

Clean and review the dbt project structure so the transformation layer is organized, maintainable, and portfolio-ready.

## Completed

* Reviewed the dbt project folder structure
* Confirmed staging models are organized under `models/staging`
* Confirmed mart models are organized under `models/marts`
* Reviewed `dbt_project.yml`
* Confirmed staging models are materialized as views
* Confirmed mart models are materialized as tables
* Reviewed dbt source configuration in `sources.yml`
* Reviewed dbt model documentation and tests in `marts.yml`
* Confirmed dbt can parse the project successfully
* Listed dbt sources and models
* Ran the full dbt project
* Ran all dbt tests
* Generated dbt documentation artifacts
* Cleaned generated dbt files
* Checked `.gitignore` to prevent generated dbt folders from being committed

## dbt Project Structure

```text
nyc311_dbt/
├── dbt_project.yml
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   └── stg_311_requests.sql
│   └── marts/
│       ├── dim_agency.sql
│       ├── dim_borough.sql
│       ├── dim_complaint_type.sql
│       ├── fact_service_requests.sql
│       └── marts.yml
```

## dbt Model Flow

```text
public.raw_311_requests
→ dbt_dev.stg_311_requests
→ dbt_dev.dim_agency
→ dbt_dev.dim_borough
→ dbt_dev.dim_complaint_type
→ dbt_dev.fact_service_requests
```

## Validation Commands

```bash
dbt parse
dbt ls --resource-type source
dbt ls --resource-type model
dbt run
dbt test
dbt docs generate
dbt clean
```

## Why This Matters

Cleaning and organizing the dbt project makes the transformation layer easier to understand, maintain, and review. A clear dbt structure helps demonstrate professional analytics engineering practices, including modular SQL models, documentation, tests, lineage, and version control readiness.

## Portfolio Summary

The dbt layer is now organized into staging and mart models. It includes a documented source, a staging model, three dimension models, a fact model, dbt tests, and generated documentation support.
