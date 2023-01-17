# Running Apache Hive jobs

[Hive](https://hive.apache.org/) is a tool for accessing data storage in the Hadoop ecosystem. It lets you work with data in different formats and DBMS using an SQL-like query language. It's mainly used for working with data in HDFS, HBase, S3-compatible storage, and relational databases.

You can run Hive jobs from the [{{ yandex-cloud }} CLI](#run-hive-job-cli) and directly on the server using the [Hive CLI](#run-job-hive-shell).

## Running jobs using the {{ yandex-cloud }} CLI {#run-hive-job-cli}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

The calculation result is saved in the {{objstorage-full-name}} bucket along with the service output.

There are two ways to send an SQL query to Hive:

* In the run job command:

   ```bash
   {{ yc-dp }} job create-hive \
      --cluster-id=<cluster ID> \
      --name=<job name> \
      --query-list="SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
   ```

* In the {{objstorage-name}} object that the {{dataproc-name}} cluster service account has read access to:

   ```bash
   {{ yc-dp }} job create-hive \
      --cluster-id=<cluster ID> \
      --name=<job name> \
      --query-file-uri="s3a://<your bucket>/hive-query.sql"
   ```

You can find the query execution results and additional diagnostic information in the {{objstorage-name}} bucket that you specified when creating the cluster: `s3://<your bucket>/dataproc/clusters/<cluster ID>/jobs/<job ID>/`.

The job ID is contained in the YC CLI job execution command output and in the {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %} response to the job execution.


## Running jobs using the Hive CLI {#run-job-hive-shell}

To run the Apache Hive command shell (CLI), connect to the master host over {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} and run the `hive` command.

Then run a Hive health check by executing the `select 1;` command. The correct result looks like this:

```text
OK
1
Time taken: 0.077 seconds, Fetched: 1 row(s)
```

1. Create an external table for the data from the example in parquet format. The table will contain a list of flights between US cities in 2018. Run the following query in the Hive CLI:

   ```sql
   CREATE EXTERNAL TABLE flights (Year bigint, Month bigint, FlightDate string, Flight_Number_Reporting_Airline bigint, OriginAirportID bigint, DestAirportID bigint) STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
   ```

1. Check the list of tables:

   ```sql
   show tables;
   ```

1. The list of tables should look like this:

   ```text
   OK
   flights
   Time taken: 0.043 seconds, Fetched: 1 row(s)
   ```

1. Request the number of flights by month:

   ```sql
   SELECT Month, COUNT(*) FROM flights GROUP BY Month;
   ```

1. Example of the query results:

   ```text
   Query ID = root_20200119195338_28049b67-4de9-4568-a4c4-3bbe500b78a1
   Total jobs = 1
   Launching Job 1 out of 1
   Status: Running (Executing on YARN cluster with App id application_1579251575762_0013)

   ----------------------------------------------------------------------------------------------
           VERTICES      MODE        STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  KILLED
   ----------------------------------------------------------------------------------------------
   Map 1 .......... container     SUCCEEDED      6          6        0        0       0       0
   Reducer 2 ...... container     SUCCEEDED      1          1        0        0       0       0
   ----------------------------------------------------------------------------------------------
   VERTICES: 02/02  [==========================>>] 100%  ELAPSED TIME: 11.52 s
   ----------------------------------------------------------------------------------------------
   OK
   1       570118
   2       520731
   3       611987
   4       596046
   5       616529
   6       626193
   7       645299
   8       644673
   9       585749
   10      616101
   11      586178
   12      593842
   Time taken: 12.137 seconds, Fetched: 12 row(s)
   ```
