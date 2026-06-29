import getpass
from pathlib import Path

import pandas as pd
import psycopg2
from psycopg2.extras import execute_values


CLEAN_FILE = Path("data/processed/nyc_311_api_clean.csv")

DB_NAME = "nyc_311_pipeline"
DB_HOST = "localhost"
DB_PORT = 5432


def load_api_data_to_postgres():
    print("Starting load to PostgreSQL...")

    if not CLEAN_FILE.exists():
        raise FileNotFoundError(f"Clean file not found: {CLEAN_FILE}")

    df = pd.read_csv(CLEAN_FILE, low_memory=False)

    print(f"Rows found in clean file: {len(df)}")
    print("Columns found:")
    print(df.columns.tolist())

    expected_columns = [
        "unique_key",
        "created_date",
        "closed_date",
        "agency",
        "agency_name",
        "complaint_type",
        "descriptor",
        "status",
        "borough",
        "latitude",
        "longitude",
    ]

    missing_columns = [col for col in expected_columns if col not in df.columns]

    if missing_columns:
        raise ValueError(f"Missing expected columns: {missing_columns}")

    df = df[expected_columns].copy()

    # Convert dates and numeric fields safely
    df["created_date"] = pd.to_datetime(df["created_date"], errors="coerce")
    df["closed_date"] = pd.to_datetime(df["closed_date"], errors="coerce")
    df["latitude"] = pd.to_numeric(df["latitude"], errors="coerce")
    df["longitude"] = pd.to_numeric(df["longitude"], errors="coerce")

    # Keep only records with a valid unique key and created date
    df = df[df["unique_key"].notna()]
    df = df[df["created_date"].notna()]

    # Convert pandas timestamps to Python datetime objects or None
    df["created_date"] = df["created_date"].apply(lambda x: x.to_pydatetime() if pd.notna(x) else None)
    df["closed_date"] = df["closed_date"].apply(lambda x: x.to_pydatetime() if pd.notna(x) else None)

    # Convert remaining missing values to None for PostgreSQL
    df = df.astype(object).where(pd.notnull(df), None)

    records = list(df.itertuples(index=False, name=None))

    print(f"Rows prepared for insert: {len(records)}")


    conn = psycopg2.connect(
    dbname="nyc_311_pipeline",
    host="localhost",
    port=5432,
    )

    insert_sql = """
        INSERT INTO raw_311_requests (
            unique_key,
            created_date,
            closed_date,
            agency,
            agency_name,
            complaint_type,
            descriptor,
            status,
            borough,
            latitude,
            longitude
        )
        VALUES %s
        ON CONFLICT (unique_key) DO NOTHING;
    """

    with conn:
        with conn.cursor() as cur:
            execute_values(cur, insert_sql, records)
            print(f"Rows inserted or skipped if duplicates: {cur.rowcount}")

    conn.close()

    print("Load complete.")


if __name__ == "__main__":
    load_api_data_to_postgres()

