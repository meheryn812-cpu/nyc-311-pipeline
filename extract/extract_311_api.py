import logging
from pathlib import Path

import pandas as pd
import requests


API_URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.json"
OUTPUT_FILE = Path("data/raw/nyc_311_api_extract.csv")
LOG_FILE = Path("logs/extract_311_api.log")

PARAMS = {
    "$limit": 50000,
    "$select": (
        "unique_key, created_date, closed_date, agency, agency_name, "
        "complaint_type, descriptor, status, borough, latitude, longitude"
    ),
    "$order": "created_date DESC",
}


def setup_logging():
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        filename=LOG_FILE,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )


def extract_311_data():
    setup_logging()

    try:
        logging.info("Starting NYC 311 API extraction.")
        print("Starting NYC 311 API extraction...")

        response = requests.get(API_URL, params=PARAMS, timeout=60)

        logging.info("API status code: %s", response.status_code)
        print("Status code:", response.status_code)

        response.raise_for_status()

        data = response.json()
        df = pd.DataFrame(data)

        if df.empty:
            raise ValueError("API returned no records.")

        OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
        df.to_csv(OUTPUT_FILE, index=False)

        logging.info("Rows extracted: %s", len(df))
        logging.info("Columns extracted: %s", df.columns.tolist())
        logging.info("Saved file to: %s", OUTPUT_FILE)

        print("Rows extracted:", len(df))
        print("Columns extracted:")
        print(df.columns.tolist())
        print(f"Saved API extract to: {OUTPUT_FILE}")
        print("Extraction complete.")

    except requests.exceptions.RequestException as error:
        logging.error("API request failed: %s", error)
        print("API request failed.")
        raise

    except Exception as error:
        logging.error("Extraction failed: %s", error)
        print("Extraction failed.")
        raise


if __name__ == "__main__":
    extract_311_data()