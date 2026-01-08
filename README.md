<<<<<<< HEAD
# chicago-taxi-analytics-dbt
Task (TIME)
=======
This project analyzes the Chicago Taxi Trips public dataset using dbt and BigQuery.
The raw data comes from the BigQuery public dataset and is transformed into analytics-ready tables using dbt best practices.

Data Source
Dataset: bigquery-public-data.chicago_taxi_trips.taxi_trips
Platform: BigQuery Public Dataset
Date Range Used: October 1, 2023 – December 31, 2023

The raw data is first staged into a dbt staging model (stg_taxi_trips) and then used to build downstream analytical models.

Project Structure 
models/
├── staging/
│   └── stg_taxi_trips.sql
└── marts/
    ├── q1_top_tipping_taxis.sql
    └── q2_long_shift_taxis.sql
    └── q3_holiday_trips.sql  


Question 1: Top 100 Tip Earners
- I have saved the .sql file as q1_top_tipping_taxis with the source from stg_taxi_trips that took directly from Kaggle Public Dataset. 

To answer this question, taxi trips were first filtered to a three-month period from October 1, 2023 to December 31, 2023, ensuring the analysis reflects recent tipping behavior.
The filtered trips were grouped by taxi_id and company to evaluate tipping performance at the individual taxi level. For each taxi, the following metrics were calculated:

- Total tips earned during the period

- Total number of trips completed

Taxis were then ranked in descending order based on total tips earned, and the top 100 taxis were selected. This approach provides a clear and consistent method for identifying the highest tip-earning taxis within the specified time window, while also offering context through trip volume.

Question 2: Long Shift Taxis (Oct–Dec 2023)

- I have saved the .sql file as q1_top_overworkers with the source from stg_taxi_trips that took directly from Kaggle Public Dataset. 

To address this question, taxi trips were filtered to the same three-month period from October 1, 2023 to December 31, 2023, ensuring consistency with the first analysis.

For each taxi and day, daily shift duration was approximated by calculating the difference between the earliest trip start time and the latest trip end time. This method captures the full active time window of a taxi across multiple trips within a day. Days where the calculated shift duration exceeded 12 hours were classified as long-shift days. These long-shift days were then aggregated at the taxi level to compute:

- Number of long-shift days
- Average shift duration on long-shift days

Finally, taxis were ranked by the number of long-shift days in descending order, with average shift duration used as a secondary ranking criterion. This approach highlights taxis that consistently operate extended working hours during the analysis period.

Question 3: Holiday vs Non-Holiday Trip Volume (Oct–Dec 2023)

To answer this question, taxi trips were filtered to the same three-month period from October 1, 2023 to December 31, 2023, maintaining consistency with previous analyses.

Trips were first aggregated at the daily level to calculate the total number of trips per day. A reference list of major US. Holidays occurring within the analysis period—Veterans Day, Thanksgiving, and Christmas—was then defined. Each day was classified as either a Holiday or Non-Holiday based on whether it matched one of the specified holiday dates. Daily trip volumes were joined to this holiday classification to enable direct comparison between holiday and non-holiday travel patterns. 

This approach allows for a clear evaluation of how taxi demand differs on holidays compared to regular days within the same time window.

Additonal Insight:
Insight 1: Tip Earnings Are Concentrated Among a Small Group of Taxis

A small subset of taxis earns a disproportionately high amount of total tips during the Oct–Dec 2023 period. This suggests that certain drivers or operating patterns consistently perform better than others.

Business value: Fleet operators can study and replicate the behaviors of top-performing taxis and design incentives to retain and motivate high earners.
Supporting data: Top 100 taxis ranked by total tips and trip volume (Question 1).

Insight 2: Repeated Long Shifts May Indicate Fatigue and Operational Risk

Some taxis consistently operate shifts longer than 12 hours per day, often across many days in the analysis period.

Business value: Identifying taxis with frequent long shifts helps operators manage driver fatigue, improve safety, and ensure compliance with working-hour policies.
Supporting data: Number of long-shift days and average shift duration per taxi (Question 2).

Google Looker Dashboard: https://lookerstudio.google.com/reporting/00a0213a-e664-4169-8570-49e8c9a81e06
Git Repo: 
>>>>>>> 8cb3c3f (Initial dbt project with BigQuery models and analysis)
