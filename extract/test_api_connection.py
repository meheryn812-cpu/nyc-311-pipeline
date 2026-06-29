import requests
import pandas as pd

API_URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.json"

params = {
    "$limit": 5,
    "$select": "unique_key, created_date, closed_date, agency, agency_name, complaint_type, descriptor, status, borough, latitude, longitude",
    "$order": "created_date DESC"}

response = requests.get(API_URL, params=params, timeout=30)

print("Status code:", response.status_code)

response.raise_for_status()

data = response.json()

df = pd.DataFrame(data)

print("\nRows returned:", len(df))
print("\nColumns returned:")
print(df.columns.to_list())

print("\nPreview:")
print(df.head())