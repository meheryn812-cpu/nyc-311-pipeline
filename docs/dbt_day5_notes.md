The dbt documentation pages were reviewed to confirm model lineage. The source table `raw_311_requests` feeds into `stg_311_requests`, and the staging model feeds the dimension models and fact model.

The confirmed lineage is:

```text
public.raw_311_requests
→ dbt_dev.stg_311_requests
→ dbt_dev.dim_agency
→ dbt_dev.dim_borough
→ dbt_dev.dim_complaint_type
→ dbt_dev.fact_service_requests