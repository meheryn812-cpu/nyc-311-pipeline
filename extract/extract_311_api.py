import requests
import pandas as pd
from pathlib import Path

API_URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.json"

OUTPUT_FILE = Path("data/raw/nyc_311_api_extract.csv")

params = {
    "$limit": 50000,
    "$select": (
        "unique_key, created_date, closed_date, agency, agency_name, "
        "complaint_type, descriptor, status, borough, latitude, longitude"),
    "$order": "created_date DESC"}

def extract_311_data():
    print("starting NYC 311 API extraction...")

    response = requests.get(API_URL, params=params, timeout=60)

    print("Status code:", response.status_code)

    response.raise_for_status()

    data = response.json()
    df = pd.DataFrame(data)

    print("Rows extracted:", len(df))
    print("Columns extracted:")
    print(df.columns.to_list())

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

    df.to_csv(OUTPUT_FILE, index=False)

    print(f"Saved API extract to: {OUTPUT_FILE}")

if __name__ == "__main__":
    extract_311_data()