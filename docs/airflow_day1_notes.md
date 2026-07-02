# Week 5 Day 1: Airflow Setup

## Project

NYC 311 Data Engineering Pipeline

## Goal

Install Apache Airflow locally and confirm that the Airflow web UI runs successfully.

## Completed

- Installed Apache Airflow
- Set `AIRFLOW_HOME`
- Started Airflow using `airflow standalone`
- Opened the Airflow web UI locally
- Logged into the Airflow UI
- Confirmed Airflow is available for local orchestration development

## Airflow Purpose

Airflow will be used to orchestrate the NYC 311 data pipeline.

The planned workflow is:

```text
Python extract
→ Python clean
→ PostgreSQL load
→ dbt run
→ dbt test
```

## Local Airflow URL

```text
http://127.0.0.1:8080
```