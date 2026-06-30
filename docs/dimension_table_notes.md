# Dimension Table Notes

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This document explains the dimension tables created from the staging table.

## Source Table

`stg_311_requests`

## Dimension Tables Created

### `dim_agency`

This table stores unique agency values from the staging table.

Columns:

- `agency_id`
- `agency`
- `agency_name`
- `created_at`

Purpose:

`dim_agency` supports analysis of service requests by responding agency.

### `dim_borough`

This table stores unique borough values from the staging table.

Columns:

- `borough_id`
- `borough`
- `created_at`

Purpose:

`dim_borough` supports analysis of service requests by New York City borough.

### `dim_complaint_type`

This table stores unique complaint type values from the staging table.

Columns:

- `complaint_type_id`
- `complaint_type`
- `created_at`

Purpose:

`dim_complaint_type` supports analysis of service request patterns by complaint category.

## Why Dimension Tables Matter

Dimension tables reduce repeated text values and make the data model easier to query, maintain, and extend. They also prepare the project for a fact table that will store service request events and connect to these dimensions using IDs.

## Next Step

The next step is to create the `fact_service_requests` table, which will store each 311 request event and reference the dimension tables.