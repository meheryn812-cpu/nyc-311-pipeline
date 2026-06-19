import pandas as pd
from pathlib import Path

raw_file = Path("data/raw/nyc_311_sample.csv")
clean_file = Path("data/raw/nyc_311_clean_sample.csv")

# Read the csv file
df = pd.read_csv(raw_file, low_memory=False)

# Clean columns names by removing extra spaces
df.columns = df.columns.str.strip()

print("Original columns:")
print(df.columns.tolist())

# Rename NYC Open Data columns to PostgreSQL-friendly names
column_mapping = {
    "Unique Key": "unique_key",
    "Created Date": "created_date",
    "Closed Date": "closed_date",
    "Agency": "agency",
    "Agency Name": "agency_name",

    # NYC Open Data changed these names
    "Complaint Type": "complaint_type",
    "Problem (formerly Complaint Type)": "complaint_type",

    "Descriptor": "descriptor",
    "Problem Detail (formerly Descriptor)": "descriptor",
    "Problem Details": "descriptor",

    "Status": "status",
    "Borough": "borough",
    "Latitude": "latitude",
    "Longitude": "longitude"}

df = df.rename(columns=column_mapping)

needed_columns = [
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
    "longitude"]

missing_columns = [col for col in needed_columns if col not in df.columns]

if missing_columns:
    print("Missing columns:")
    print(missing_columns)
    print()
    print("Available columns after renaming:")
    print(df.columns.tolist())
    raise ValueError("Some expected columns are missing. Check the CSV column names.")

clean_df = df[needed_columns]

clean_df.to_csv(clean_file, index=False)

print(f"Clean CSV created: {clean_file}")
print(f"Rows saved: {len(clean_df)}")
print("Clean columns:")
print(clean_df.columns.tolist())

