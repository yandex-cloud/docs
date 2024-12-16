# Running Apache Hive jobs

[Hive](https://hive.apache.org/) is a tool for accessing data storage in the Hadoop ecosystem. It allows you to work with data in different formats and DBMS's using an SQL-like query language. It is mainly used for working with data in HDFS, HBase, S3-compatible storage, and relational databases.

You can run Hive jobs from the [{{ yandex-cloud }} CLI](#run-hive-job-cli) and directly on the server using the [Hive CLI](#run-job-hive-shell).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. {% include [tutorials-basic-before-buckets](../../_includes/data-processing/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following settings:

   * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
      * `HDFS`
      * `SPARK`
      * `HIVE`
   * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the service account you previously created.
   * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select a bucket to hold the processing results.
   * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**: Select this option to grant access to hosts in all subclusters.

## Running jobs using the {{ yandex-cloud }} CLI {#run-hive-job-cli}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-processing/cli-job-intro.md) %}

The calculation result is saved in the {{ objstorage-full-name }} bucket along with the service output.

There are two ways to send an SQL query to Hive:

* In the run job command:

   ```bash
   {{ yc-dp }} job create-hive \
      --cluster-id=<cluster_ID> \
      --name=<job_name> \
      --query-list="SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
   ```

* In the {{ objstorage-name }} object that the {{ dataproc-name }} cluster service account has read access to:

   ```bash
   {{ yc-dp }} job create-hive \
      --cluster-id=<cluster_ID> \
      --name=<job_name> \
      --query-file-uri="s3a://<bucket>/hive-query.sql"
   ```

You can find the query execution results and additional diagnostic information in the {{ objstorage-name }} bucket that you specified when creating the cluster: `s3://<bucket>/dataproc/clusters/<cluster_ID>/jobs/<job_ID>/`.

The job ID is contained in the YC CLI job execution command output and in the API response to the job execution.

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Running jobs using the Hive CLI {#run-job-hive-shell}

1. Connect to the master host over SSH and run the `hive` command.

1. Run a Hive health check by executing the `select 1;` command. The correct result looks like this:

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
   Query ID = root_20200119195338_28049b67-4de9-4568-a4c4-3bbe********
   Total jobs = 1
   Launching Job 1 out of 1
   Status: Running (Executing on YARN cluster with App id application_157925157****_****)

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

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}
