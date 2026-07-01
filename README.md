# NYC Taxi Analytics Platform

An end-to-end analytics engineering project that turns 14.9M NYC Yellow Taxi trips into a tested PostgreSQL warehouse and a Tableau dashboard.

![NYC Taxi revenue dashboard](docs/images/Screenshot%202026-06-11%20at%2012.46.16%E2%80%AFPM.png)

## What this project demonstrates

- Batch ingestion from Parquet with Python and Pandas
- Layered data modeling across raw, staging, warehouse, and analytics schemas
- Reusable dbt models with source definitions, documentation, and data-quality tests
- PostgreSQL indexing and analytics views for BI workloads
- Tableau reporting for revenue, demand, zones, payment behavior, and tips

## Architecture

```text
NYC TLC Parquet files
        |
        v
Python batch loader
        |
        v
PostgreSQL: raw -> staging -> warehouse -> analytics
                         |
                         v
                  dbt models + tests
                         |
                         v
                 Tableau dashboard
```

## Results

The source files contain approximately 14.9M trips from January through April 2026. After quality rules remove invalid distances, negative fares, and impossible trip timestamps, the curated layer contains 14.17M trips.

| Metric | Result |
| --- | ---: |
| Curated trips | 14,170,143 |
| Total revenue | $426.8M |
| Average fare | $30.12 |
| Average tip | $2.83 |

The dashboard highlights Manhattan as the largest revenue market and JFK Airport as the highest-revenue pickup zone in the analyzed period.

## Repository layout

```text
python/                  Batch ingestion
sql/                     Schema, warehouse, indexes, and BI views
dbt/nyc_taxi_dbt/        dbt models, tests, and documentation
docs/images/             Tableau dashboard screenshots
```

## Run locally

1. Create a PostgreSQL database named `nyc_taxi_analytics`.
2. Copy `.env.example` to `.env` and set your local credentials.
3. Install the Python dependencies:

   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

4. Download Yellow Taxi Parquet files from the [NYC Taxi & Limousine Commission](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page) into `data/raw/`.
5. Run `sql/01_create_raw_tables.sql`, then load the files:

   ```bash
   python python/load_raw_data.py
   ```

6. Run the remaining numbered SQL scripts in order.
7. Copy `dbt/nyc_taxi_dbt/profiles.yml.example` to `~/.dbt/profiles.yml`, then validate the models:

   ```bash
   cd dbt/nyc_taxi_dbt
   dbt build
   ```

## Data-quality rules

- Trip distance must be greater than zero.
- Fare and total amount must be non-negative.
- Drop-off time must be later than pickup time.
- dbt verifies primary fields, accepted payment types, and dimension relationships.

## Notes

Raw trip data and credentials are intentionally excluded from version control. The project uses environment variables rather than committed database passwords.

## Future evolution

- Orchestrate ingestion and dbt builds with Airflow or Dagster
- Add CI checks, freshness alerts, lineage, and pipeline observability
- Move curated models toward a cloud warehouse or lakehouse architecture
- Train and monitor demand-forecasting models by zone and hour
- Expose governed metrics to an AI analytics assistant with tested semantic definitions

These items are a roadmap; the repository's current delivered scope is the batch pipeline, warehouse, dbt layer, quality tests, analytics views, and Tableau dashboard.
