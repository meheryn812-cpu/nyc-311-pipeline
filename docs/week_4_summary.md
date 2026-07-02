# Week 4 Summary: dbt Transformation Layer

## Project

NYC 311 Data Engineering Pipeline

## Week 4 Focus

Week 4 focused on adding a professional dbt transformation layer to the NYC 311 Data Engineering Pipeline.

The goal was to move SQL transformation logic into dbt models, add source and model documentation, create tests, generate dbt documentation, and review model lineage.

## dbt Project

The dbt project is located in:

```text
nyc311_dbt/
```

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

## Models Created

### Source

* `source.nyc311.raw_311_requests`

This source points to the PostgreSQL table:

```text
public.raw_311_requests
```

### Staging Model

* `stg_311_requests`

The staging model cleans and standardizes raw NYC 311 service request records.

Key transformations include:

* Renaming `unique_key` to `request_id`
* Standardizing agency codes
* Cleaning agency names
* Cleaning complaint types
* Standardizing request status values
* Cleaning borough values
* Calculating `response_hours`
* Preserving raw load timestamps

### Dimension Models

* `dim_agency`
* `dim_borough`
* `dim_complaint_type`

The dimension models store descriptive values used for filtering, grouping, and reporting.

### Fact Model

* `fact_service_requests`

The fact model stores one row per NYC 311 service request.

The grain of the fact table is:

```text
One row per NYC 311 service request
```

The fact model connects to the dimension models using:

```text
agency_id
borough_id
complaint_type_id
```

## Materialization Strategy

The dbt project uses the following materialization strategy:

```text
Staging model: view
Mart models: tables
```

Staging is materialized as a view because it is a lightweight transformation close to the raw source data.

Mart models are materialized as tables because they are analytics-ready outputs intended for reporting and repeated querying.

## dbt Tests Added

The project includes dbt tests for:

* Not-null checks
* Unique key checks
* Accepted value checks
* Relationship checks

Examples include:

* `request_id` must be unique and not null
* `created_date` must not be null
* `agency_id` must not be null
* `complaint_type_id` must not be null
* `borough` must match accepted NYC borough values
* Fact table foreign keys must match dimension table primary keys

## dbt Documentation

dbt documentation was generated using:

```bash
dbt docs generate
```

The local documentation site was served using:

```bash
dbt docs serve
```

The documentation includes:

* Source descriptions
* Model descriptions
* Column descriptions
* Data tests
* Compiled SQL
* Model dependencies
* Lineage information

## Lineage Review

The dbt documentation pages were reviewed to confirm the model lineage.

Confirmed lineage:

```text
public.raw_311_requests
→ dbt_dev.stg_311_requests
→ dbt_dev.dim_agency
→ dbt_dev.dim_borough
→ dbt_dev.dim_complaint_type
→ dbt_dev.fact_service_requests
```

The lineage confirms that the raw source table feeds the staging model, and the staging model feeds the dimension and fact models.

## Validation Commands Used

```bash
dbt parse
dbt ls --resource-type source
dbt ls --resource-type model
dbt run
dbt test
dbt docs generate
dbt docs serve
dbt clean
```

## Week 4 Deliverables

dbt files:

* `nyc311_dbt/dbt_project.yml`
* `nyc311_dbt/models/staging/sources.yml`
* `nyc311_dbt/models/staging/stg_311_requests.sql`
* `nyc311_dbt/models/marts/dim_agency.sql`
* `nyc311_dbt/models/marts/dim_borough.sql`
* `nyc311_dbt/models/marts/dim_complaint_type.sql`
* `nyc311_dbt/models/marts/fact_service_requests.sql`
* `nyc311_dbt/models/marts/marts.yml`

Documentation files:

* `docs/dbt_day1_notes.md`
* `docs/dbt_day2_notes.md`
* `docs/dbt_day3_notes.md`
* `docs/dbt_day4_notes.md`
* `docs/dbt_day5_notes.md`
* `docs/dbt_day6_notes.md`
* `docs/week_4_summary.md`

## Portfolio Summary

In Week 4, I added a professional dbt transformation layer to the NYC 311 Data Engineering Pipeline. I created a dbt source, staging model, dimension models, and a fact model. I added documentation and tests, generated dbt docs, reviewed lineage, and cleaned the dbt project structure for GitHub readiness.

