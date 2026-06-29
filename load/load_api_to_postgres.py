import logging
from pathlib import Path

import pandas as pd
import psycopg2
from psycopg2.extras import execute_values


CLEAN_FILE = Path("data/processed/nyc_311_api_clean.csv")
LOG_FILE = Path("logs/load_api_to_postgres.log")

DB_NAME = "nyc_311_pipeline"
DB_HOST = "localhost"
DB_PORT = 5432

EXPECTED_COLUMNS = [
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


def setup_logging():
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        filename=LOG_FILE,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )


def load_api_data_to_postgres():
    setup_logging()

    try:
        logging.info("Starting load to PostgreSQL.")
        print("Starting load to PostgreSQL...")

        if not CLEAN_FILE.exists():
            raise FileNotFoundError(f"Clean file not found: {CLEAN_FILE}")

        df = pd.read_csv(CLEAN_FILE, low_memory=False)

        logging.info("Rows found in clean file: %s", len(df))
        logging.info("Columns found: %s", df.columns.tolist())

        print(f"Rows found in clean file: {len(df)}")
        print("Columns found:")
        print(df.columns.tolist())

        missing_columns = [col for col in EXPECTED_COLUMNS if col not in df.columns]

        if missing_columns:
            raise ValueError(f"Missing expected columns: {missing_columns}")

        df = df[EXPECTED_COLUMNS].copy()

        df["created_date"] = pd.to_datetime(df["created_date"], errors="coerce")
        df["closed_date"] = pd.to_datetime(df["closed_date"], errors="coerce")
        df["latitude"] = pd.to_numeric(df["latitude"], errors="coerce")
        df["longitude"] = pd.to_numeric(df["longitude"], errors="coerce")

        df = df[df["unique_key"].notna()]
        df = df[df["unique_key"].astype(str).str.strip() != ""]
        df = df[df["created_date"].notna()]

        df["created_date"] = df["created_date"].apply(
            lambda x: x.to_pydatetime() if pd.notna(x) else None
        )
        df["closed_date"] = df["closed_date"].apply(
            lambda x: x.to_pydatetime() if pd.notna(x) else None
        )

        df = df.astype(object).where(pd.notnull(df), None)

        records = list(df.itertuples(index=False, name=None))

        logging.info("Rows prepared for insert: %s", len(records))
        print(f"Rows prepared for insert: {len(records)}")

        if not records:
            raise ValueError("No records available to insert.")

        conn = psycopg2.connect(
            dbname=DB_NAME,
            host=DB_HOST,
            port=DB_PORT,
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
                logging.info("Rows inserted or skipped if duplicates: %s", cur.rowcount)
                print(f"Rows inserted or skipped if duplicates: {cur.rowcount}")

        conn.close()

        logging.info("Load complete.")
        print("Load complete.")

    except Exception as error:
        logging.error("Load failed: %s", error)
        print("Load failed.")
        raise


if __name__ == "__main__":
    load_api_data_to_postgres()