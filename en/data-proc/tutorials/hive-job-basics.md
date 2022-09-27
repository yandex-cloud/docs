# Working with Hive jobs

[Apache Hive](https://hive.apache.org/) is a system for managing large distributed datasets that is built on Hadoop and uses the SQL query language.

In this article, a simple example demonstrates how Hive is used in {{ dataproc-name }} for data analysis. In the example below, we use Hive to analyze the population of the largest cities in  Russia.  

## Before you begin {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `mdb.dataproc.agent` role.

1. {% include [tutorials-basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following settings:

   * **Services**:
      * `HDFS`
      * `SPARK`
      * `HIVE`
   * **Service account**: Select the service account with the `mdb.dataproc.agent` role you created earlier.
   * **Bucket name**: Select a bucket to hold the processing output.

## Create a Hive job {#create-job}

1. In the input data bucket, [create a folder](../../storage/operations/objects/upload.md) named `cities` and upload the `cities.csv` file to it for processing:

   
   {% cut "cities.csv" %}

   ```text
   Moscow,12655000
   Saint Petersburg,5384000
   Novosibirsk,1620000
   Yekaterinburg,1495000
   Kazan,1257000
   Nizhny Novgorod,1244000
   Chelyabinsk,1188000
   Samara,1145000
   Omsk,1140000
   Rostov-on-Don,1138000
   Ufa,1126000
   Krasnoyarsk,1093000
   Voronezh,1051000
   Perm,1049000
   Volgograd,1005000
   ```

   {% endcut %}

   The file shows the population of Russia's largest cities with over a million inhabitants based on 2021 estimates (rounded).



1. Create a file with SQL queries named `cities.sql` and upload it to the input data bucket:

   {% cut "cities.sql" %}

   ```sql
   -- create an external table with the data contained in the CSV files
   CREATE EXTERNAL TABLE IF NOT EXISTS cities
   (city_name string, population decimal)
   ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
   STORED AS TEXTFILE
   LOCATION 's3a://<input data bucket>/cities';

   -- show the number of cities and their total population
   SELECT COUNT(*) num_cities, SUM(population) sum_populataion FROM cities;

   -- show the minimum and maximum number of inhabitants
   SELECT MIN(population) min_population, MAX(population) max_population FROM cities;
   ```

   {% endcut %}

1. [Create a Hive job](../operations/jobs-hive#create) with the following parameters:

   * **Driver**: `File`
   * **Query file**: `s3a://<input data bucket name>/cities.sql`

1. Wait for the [job status](../operations/jobs-spark.md#get-info) to change to `Done`.


1. [Open the job logs](../operations/jobs-hive#get-logs) and view the output:

   {% cut "Logs" %}

   ```text
   ...
   OK
   15  33590000
   Time taken: 21.104 seconds, Fetched: 1 row(s)
   ...
   OK
   1005000 12655000
   Time taken: 3.393 seconds, Fetched: 1 row(s)
   ```

   {% endcut %}


## Delete the resources you created {#clear-out}

{% include [tutorials-basic-clear-out.md](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
