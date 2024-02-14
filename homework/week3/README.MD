CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-412223.ny_taxi.green_taxi_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dezoomcamp-week3-bernardoc/green_taxi_2022/*.parquet']
);


CREATE OR REPLACE TABLE `dtc-de-course-412223.ny_taxi.green_taxi_tripdata_nonpartitoned`
AS SELECT * FROM `dtc-de-course-412223.ny_taxi.green_taxi_tripdata`;

-- Question 1: What is count of records for the 2022 Green Taxi Data??
SELECT COUNT(*) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata

-- Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
-- What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
SELECT COUNT(DISTINCT PULocationID) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata

SELECT COUNT(DISTINCT PULocationID) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata_nonpartitoned

-- Question 3: How many records have a fare_amount of 0?
SELECT COUNT(*) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata
WHERE fare_amount = 0

-- Question 4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
-- Partition by lpep_pickup_datetime Cluster on PUlocationID

CREATE OR REPLACE TABLE `dtc-de-course-412223.ny_taxi.green_taxi_tripdata_partitioned`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `dtc-de-course-412223.ny_taxi.green_taxi_tripdata`;

-- Question 5: Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive). Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are these values?

SELECT DISTINCT(PULocationID) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata_nonpartitoned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT(PULocationID) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata_partitioned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

-- (Bonus: Not worth points) Question 8:
-- No Points: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?

SELECT COUNT (*) FROM dtc-de-course-412223.ny_taxi.green_taxi_tripdata_nonpartitoned
