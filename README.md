# NYC Taxi Analytics Platform

## Project Overview

Built an end-to-end Analytics Engineering platform using NYC Taxi trip data (14.9M+ records).

### Tech Stack

* Python
* Pandas
* PostgreSQL
* SQL
* Tableau
* Git/GitHub

### Architecture

Parquet Files
→ Python ETL
→ Raw Layer
→ Staging Layer
→ Warehouse Layer
→ Analytics Views
→ Tableau Dashboard

### Data Volume

* January 2026: 3.7M records
* February 2026: 3.4M records
* March 2026: 4.0M records
* April 2026: 3.8M records

Total: 14.9M records

### Warehouse Design

Fact Tables:

* fact_taxi_trip_final

Dimension Tables:

* dim_zone
* dim_date
* dim_time
* dim_payment_type
* dim_rate_code

### Analytics Views

* kpi_summary
* revenue_by_borough
* top_pickup_zones
* peak_pickup_hours
* payment_type_usage
* tip_percentage_by_borough

### Dashboard Features

* Revenue Analysis
* Trip Volume Analysis
* Peak Hour Trends
* Pickup Zone Performance
* Payment Type Distribution
* Tip Percentage Analysis

