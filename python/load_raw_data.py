import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

DB_USER = "postgres"
DB_PASSWORD = "postgres"
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "nyc_taxi_analytics"

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

DATA_FOLDER = Path("data/raw")

files = sorted(DATA_FOLDER.glob("yellow_tripdata_*.parquet"))

for file in files:
    print(f"Loading {file.name}")

    df = pd.read_parquet(file)

    df = df.rename(columns={
        "VendorID": "vendor_id",
        "RatecodeID": "ratecode_id",
        "PULocationID": "pu_location_id",
        "DOLocationID": "do_location_id",
        "Airport_fee": "airport_fee"
    })

    df["source_file"] = file.name

    df.to_sql(
        "yellow_taxi_trips",
        engine,
        schema="raw",
        if_exists="append",
        index=False,
        chunksize=10000
    )

    print(f"Finished {file.name}")





