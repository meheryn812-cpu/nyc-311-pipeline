# Data Dictionary

## Project

NYC 311 Data Engineering Pipeline

## Purpose

This data dictionary documents the main tables and columns used in the NYC 311 Data Engineering Pipeline. It explains the raw, staging, dimension, and fact tables created for the project.

## Data Model Overview

The project uses a layered data model:

```text
raw_311_requests
→ stg_311_requests
→ dim_agency
→ dim_borough
→ dim_complaint_type
→ fact_service_requests
```

The model follows a star-schema-style structure, where `fact_service_requests` is the central fact table and connects to the dimension tables using foreign keys.

---

## Table: raw_311_requests

### Description

The `raw_311_requests` table stores NYC 311 service request data loaded into PostgreSQL. This table preserves the selected source fields before deeper transformation and dimensional modeling.

| Column           | Description                                          | Data Type / Notes                                        |
| ---------------- | ---------------------------------------------------- | -------------------------------------------------------- |
| `unique_key`     | Unique identifier for each NYC 311 service request   | Text, primary key                                        |
| `created_date`   | Date and time when the service request was created   | Timestamp without time zone                              |
| `closed_date`    | Date and time when the service request was closed    | Timestamp without time zone, may be null                 |
| `agency`         | Agency code responsible for the request              | Text                                                     |
| `agency_name`    | Full agency name                                     | Text                                                     |
| `complaint_type` | Type or category of complaint/service request        | Text                                                     |
| `descriptor`     | More detailed description of the complaint           | Text, may be null                                        |
| `status`         | Current status of the request                        | Text                                                     |
| `borough`        | NYC borough associated with the request              | Text, may be null                                        |
| `latitude`       | Latitude coordinate of the request location          | Numeric, may be null                                     |
| `longitude`      | Longitude coordinate of the request location         | Numeric, may be null                                     |
| `raw_loaded_at`  | Timestamp when the record was loaded into PostgreSQL | Timestamp without time zone, default `CURRENT_TIMESTAMP` |

---

## Table: stg_311_requests

### Description

The `stg_311_requests` table is the cleaned and standardized staging version of the raw data. It prepares the data for dimensional modeling by standardizing text fields, renaming the request key, cleaning borough values, and calculating response time.

| Column           | Description                                                    | Data Type / Notes                        |
| ---------------- | -------------------------------------------------------------- | ---------------------------------------- |
| `request_id`     | Renamed version of `unique_key`; unique request identifier     | Text, primary key                        |
| `created_date`   | Date and time when the service request was created             | Timestamp without time zone              |
| `closed_date`    | Date and time when the service request was closed              | Timestamp without time zone, may be null |
| `agency`         | Standardized agency code                                       | Text                                     |
| `agency_name`    | Cleaned agency name                                            | Text                                     |
| `complaint_type` | Cleaned complaint type                                         | Text                                     |
| `descriptor`     | Cleaned complaint detail                                       | Text, may be null                        |
| `status`         | Standardized request status                                    | Text                                     |
| `borough`        | Standardized borough value                                     | Text, may be null                        |
| `latitude`       | Latitude coordinate                                            | Numeric, may be null                     |
| `longitude`      | Longitude coordinate                                           | Numeric, may be null                     |
| `response_hours` | Number of hours between request creation and closure           | Numeric, null when not calculable        |
| `raw_loaded_at`  | Timestamp when the source record was loaded into the raw table | Timestamp without time zone              |
| `staged_at`      | Timestamp when the staging table was created                   | Timestamp with time zone                 |

### Indexes

| Index                        | Column           |
| ---------------------------- | ---------------- |
| `stg_311_requests_pkey`      | `request_id`     |
| `idx_stg_311_created_date`   | `created_date`   |
| `idx_stg_311_borough`        | `borough`        |
| `idx_stg_311_agency`         | `agency`         |
| `idx_stg_311_complaint_type` | `complaint_type` |

---

## Table: dim_agency

### Description

The `dim_agency` table stores unique agency values from the staging table.

| Column        | Description                                     | Data Type / Notes        |
| ------------- | ----------------------------------------------- | ------------------------ |
| `agency_id`   | Surrogate key for the agency dimension          | Bigint, primary key      |
| `agency`      | Agency code                                     | Text                     |
| `agency_name` | Full agency name                                | Text                     |
| `created_at`  | Timestamp when the dimension record was created | Timestamp with time zone |

### Use

This table supports analysis of service requests by agency.

### Indexes

| Index                   | Column                  |
| ----------------------- | ----------------------- |
| `dim_agency_pkey`       | `agency_id`             |
| `idx_dim_agency_unique` | `agency`, `agency_name` |

---

## Table: dim_borough

### Description

The `dim_borough` table stores unique NYC borough values from the staging table.

| Column       | Description                                     | Data Type / Notes        |
| ------------ | ----------------------------------------------- | ------------------------ |
| `borough_id` | Surrogate key for the borough dimension         | Bigint, primary key      |
| `borough`    | NYC borough name                                | Text                     |
| `created_at` | Timestamp when the dimension record was created | Timestamp with time zone |

### Use

This table supports analysis of service requests by borough.

### Indexes

| Index                    | Column       |
| ------------------------ | ------------ |
| `dim_borough_pkey`       | `borough_id` |
| `idx_dim_borough_unique` | `borough`    |

---

## Table: dim_complaint_type

### Description

The `dim_complaint_type` table stores unique complaint type values from the staging table.

| Column              | Description                                     | Data Type / Notes        |
| ------------------- | ----------------------------------------------- | ------------------------ |
| `complaint_type_id` | Surrogate key for the complaint type dimension  | Bigint, primary key      |
| `complaint_type`    | Complaint or service request category           | Text                     |
| `created_at`        | Timestamp when the dimension record was created | Timestamp with time zone |

### Use

This table supports analysis of service requests by complaint category.

### Indexes

| Index                           | Column              |
| ------------------------------- | ------------------- |
| `dim_complaint_type_pkey`       | `complaint_type_id` |
| `idx_dim_complaint_type_unique` | `complaint_type`    |

---

## Table: fact_service_requests

### Description

The `fact_service_requests` table stores one row per NYC 311 service request. It connects service request events to agency, borough, and complaint type dimensions.

## Grain

The grain of the fact table is one row per NYC 311 service request.

| Column              | Description                                          | Data Type / Notes                        |
| ------------------- | ---------------------------------------------------- | ---------------------------------------- |
| `request_id`        | Unique identifier for the service request            | Text, primary key                        |
| `created_date`      | Date and time when the service request was created   | Timestamp without time zone              |
| `closed_date`       | Date and time when the service request was closed    | Timestamp without time zone, may be null |
| `status`            | Current status of the request                        | Text                                     |
| `response_hours`    | Number of hours between request creation and closure | Numeric, may be null                     |
| `latitude`          | Latitude coordinate                                  | Numeric, may be null                     |
| `longitude`         | Longitude coordinate                                 | Numeric, may be null                     |
| `agency_id`         | Foreign key to `dim_agency`                          | Bigint                                   |
| `borough_id`        | Foreign key to `dim_borough`                         | Bigint, may be null                      |
| `complaint_type_id` | Foreign key to `dim_complaint_type`                  | Bigint                                   |
| `raw_loaded_at`     | Timestamp when the raw record was loaded             | Timestamp without time zone              |
| `fact_created_at`   | Timestamp when the fact table record was created     | Timestamp with time zone                 |

### Primary Key

| Column       | Description                                                |
| ------------ | ---------------------------------------------------------- |
| `request_id` | Uniquely identifies each service request in the fact table |

### Foreign Keys

| Fact Table Column   | Dimension Table      | Dimension Key       |
| ------------------- | -------------------- | ------------------- |
| `agency_id`         | `dim_agency`         | `agency_id`         |
| `borough_id`        | `dim_borough`        | `borough_id`        |
| `complaint_type_id` | `dim_complaint_type` | `complaint_type_id` |

### Indexes

| Index                                         | Column              |
| --------------------------------------------- | ------------------- |
| `fact_service_requests_pkey`                  | `request_id`        |
| `idx_fact_service_requests_created_date`      | `created_date`      |
| `idx_fact_service_requests_status`            | `status`            |
| `idx_fact_service_requests_agency_id`         | `agency_id`         |
| `idx_fact_service_requests_borough_id`        | `borough_id`        |
| `idx_fact_service_requests_complaint_type_id` | `complaint_type_id` |

---

## Model Relationships

The fact table connects to the dimension tables through foreign keys:

```text
fact_service_requests.agency_id
→ dim_agency.agency_id

fact_service_requests.borough_id
→ dim_borough.borough_id

fact_service_requests.complaint_type_id
→ dim_complaint_type.complaint_type_id
```

This allows the model to support analysis by agency, borough, complaint type, status, date, and response time.

---

## Key Business Metrics

The data model supports the following metrics:

| Metric                     | Description                                                  |
| -------------------------- | ------------------------------------------------------------ |
| Total requests             | Count of service requests                                    |
| Requests by borough        | Count of service requests grouped by borough                 |
| Requests by agency         | Count of service requests grouped by agency                  |
| Requests by complaint type | Count of service requests grouped by complaint category      |
| Average response time      | Average number of hours between request creation and closure |
| Status distribution        | Count of requests by status                                  |
| Missing location data      | Count of records missing latitude or longitude               |
| Missing borough data       | Count of records missing borough values                      |
| Open request count         | Count of requests that have not yet been closed              |
| Closed request count       | Count of requests with status `CLOSED`                       |

---

## Known Data Quality Notes

The model quality checks identified the following findings:

* The fact table contains 75,248 records.
* The staging table contains 75,248 records.
* The fact table row count matches the staging table row count.
* No records were lost when creating the fact table.
* No missing request IDs were found.
* No duplicate request IDs were found.
* No missing agency IDs were found.
* No missing complaint type IDs were found.
* There are 51 records with missing borough IDs because the source data contained blank or missing borough values.
* No broken joins were found between the fact table and dimension tables.
* No negative response time values were found.
* Valid response times range from 0.00 hours to 364.47 hours.
* The average valid response time is 14.81 hours.
* Some records are missing `closed_date`, which is expected for open or unresolved service requests.
* Some records are missing latitude and longitude values, which may limit map-based analysis.

---

## Example Final Model Query

This query summarizes total requests and average response time by borough:

```sql
SELECT
    b.borough,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_borough b
    ON f.borough_id = b.borough_id
GROUP BY b.borough
ORDER BY total_requests DESC;
```

---

## Example Agency Summary Query

This query summarizes total requests and average response time by agency:

```sql
SELECT
    a.agency,
    a.agency_name,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_agency a
    ON f.agency_id = a.agency_id
GROUP BY a.agency, a.agency_name
ORDER BY total_requests DESC;
```

---

## Example Complaint Type Summary Query

This query summarizes total requests and average response time by complaint type:

```sql
SELECT
    c.complaint_type,
    COUNT(*) AS total_requests,
    ROUND(AVG(f.response_hours), 2) AS avg_response_hours
FROM fact_service_requests f
LEFT JOIN dim_complaint_type c
    ON f.complaint_type_id = c.complaint_type_id
GROUP BY c.complaint_type
ORDER BY total_requests DESC;
```

---

## Why This Data Dictionary Matters

This data dictionary makes the project easier to understand, maintain, and review. It explains how the data moves from raw source records into staging, dimension, and fact tables. It also documents the business meaning of key columns, table relationships, data quality findings, and metrics used for reporting and analysis.
