"""Load NYC Yellow Taxi Parquet files into PostgreSQL's raw layer."""

from __future__ import annotations

import logging
import os
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

load_dotenv()

logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
LOGGER = logging.getLogger(__name__)

COLUMN_RENAMES = {
    "VendorID": "vendor_id",
    "RatecodeID": "ratecode_id",
    "PULocationID": "pu_location_id",
    "DOLocationID": "do_location_id",
    "Airport_fee": "airport_fee",
}


def database_url() -> URL:
    """Build a SQLAlchemy URL from environment variables."""
    return URL.create(
        drivername="postgresql+psycopg2",
        username=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres"),
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", "5432")),
        database=os.getenv("DB_NAME", "nyc_taxi_analytics"),
    )


def load_files(data_folder: Path, chunk_size: int = 10_000) -> None:
    """Append every Yellow Taxi Parquet file in ``data_folder`` to PostgreSQL."""
    files = sorted(data_folder.glob("yellow_tripdata_*.parquet"))
    if not files:
        raise FileNotFoundError(
            f"No yellow_tripdata_*.parquet files found in {data_folder.resolve()}"
        )

    engine = create_engine(database_url(), pool_pre_ping=True)
    try:
        for file in files:
            LOGGER.info("Loading %s", file.name)
            frame = pd.read_parquet(file).rename(columns=COLUMN_RENAMES)
            frame["source_file"] = file.name
            frame.to_sql(
                "yellow_taxi_trips",
                engine,
                schema="raw",
                if_exists="append",
                index=False,
                chunksize=chunk_size,
                method="multi",
            )
            LOGGER.info("Loaded %,d rows from %s", len(frame), file.name)
    finally:
        engine.dispose()


if __name__ == "__main__":
    load_files(Path(os.getenv("DATA_FOLDER", "data/raw")))

