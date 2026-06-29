import pandas as pd
from pathlib import Path

RAW_FILE = Path("data/raw/nyc_311_api_extract.csv")
CLEAN_FILE = Path("data/processed/nyc_311_api_clean.csv")

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
    "longitude"
]

def clean_311_api_extract():
    print("Starting API extract cleaning...")

    if not RAW_FILE.exists():
        raise FileNotFoundError(f"Raw file not found: {RAW_FILE}")

    df = pd.read_csv(RAW_FILE, low_memory=False)

    print(f"Rows before cleaning: {len(df)}")
    print("Columns found:")
    print(df.columns.tolist())

    missing_columns = [col for col in EXPECTED_COLUMNS if col not in df.columns]

    if missing_columns:
        raise ValueError(f"Missing expected columns: {missing_columns}")

    df = df[EXPECTED_COLUMNS].copy()

    # Remove rows without a unique key
    df = df[df["unique_key"].notna()]
    df = df[df["unique_key"].astype(str).str.strip() != ""]

    # Remove duplicate unique keys
    df = df.drop_duplicates(subset=["unique_key"])

    # Standardize text columns
    text_columns = [
        "agency",
        "agency_name",
        "complaint_type",
        "descriptor",
        "status",
        "borough"
    ]

    for col in text_columns:
        df[col] = df[col].astype("string").str.strip()

    # Standardize borough names
    df["borough"] = df["borough"].str.upper()

    # Convert dates
    df["created_date"] = pd.to_datetime(df["created_date"], errors="coerce")
    df["closed_date"] = pd.to_datetime(df["closed_date"], errors="coerce")

    # Convert coordinates
    df["latitude"] = pd.to_numeric(df["latitude"], errors="coerce")
    df["longitude"] = pd.to_numeric(df["longitude"], errors="coerce")

    # Remove rows missing created_date
    df = df[df["created_date"].notna()]

    CLEAN_FILE.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(CLEAN_FILE, index=False)

    print(f"Rows after cleaning: {len(df)}")
    print(f"Clean file saved to: {CLEAN_FILE}")
    print("Cleaning complete.")

if __name__ == "__main__":
    clean_311_api_extract()