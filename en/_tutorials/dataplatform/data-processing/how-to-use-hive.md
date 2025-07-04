# Running Apache Hive jobs

[Hive](https://hive.apache.org/) is a tool for accessing data storage in the Hadoop ecosystem. It allows you to work with data in different formats and DBMS's using an SQL-like query language. It is mainly used for working with data in HDFS, HBase, S3-compatible storage, and relational DBMS’s.

You can run Hive jobs from the [{{ yandex-cloud }} CLI](#run-hive-job-cli) and directly on the server using the [Hive CLI](#hive-shell).

{% include [get-logs-info](../../../_includes/data-processing/note-info-get-logs.md) %}

## Working with jobs in the {{ yandex-cloud }} CLI {#run-hive-job-cli}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../../_includes/data-processing/cli-job-intro.md) %}

There are two ways to send an SQL query to Hive:

* [In the job run command](#sql-in-cli).
* [In the {{ objstorage-name }} object](#sql-from-objstorage) the {{ dataproc-name }} cluster service account has read access to.

The query execution result is saved to an {{ objstorage-full-name }} bucket linked to the cluster together with the service output.

### Getting started {#before-you-begin-yc-cli}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. {% include [tutorials-basic-before-buckets](../../../_includes/data-processing/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `HIVE`
        * `MAPREDUCE`
        * `SPARK`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the service account you created earlier.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select a bucket for the processing results.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**: Enable this option to access hosts of all subclusters.

### Providing an SQL query in the job run command {#sql-in-cli}

1. Create an external table for the data from the example in Parquet format. The table will contain a list of flights between US cities in 2018. Run the following query using the {{ yandex-cloud }} CLI:

    ```bash
    yc dataproc job create-hive \
       --cluster-id=<cluster_ID> \
       --name=task-one \
       --query-list="CREATE EXTERNAL TABLE flights (
         Year bigint,
         Month bigint,
         FlightDate string,
         Flight_Number_Reporting_Airline bigint,
         OriginAirportID bigint,
         DestAirportID bigint)
         STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';"
    ```

    {% cut "Example of a response to a query" %}

    ```bash
    done (14s)
    id: c9qloj5crovu********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T03:51:03.285819Z"
    started_at: "2024-12-04T03:51:15.884426Z"
    finished_at: "2024-12-04T03:51:15.884426Z"
    name: task-one
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_list:
        queries:
          - CREATE EXTERNAL TABLE flights (Year bigint, Month bigint, FlightDate string, Flight_Number_Reporting_Airline bigint, OriginAirportID bigint, DestAirportID bigint) STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
    application_info: {}
    ```

    {% endcut %}

1. Make sure the table was successfully created by querying the number of flights by month:

    ```bash
    {{ yc-dp }} job create-hive \
       --cluster-id=<cluster_ID> \
       --name=task-two \
       --query-list="SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
    ```

    {% cut "Example of a response to a query" %}

    ```bash
    done (34s)
    id: c9quejacclo3********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T05:15:38.436203Z"
    started_at: "2024-12-04T05:16:11.608422Z"
    finished_at: "2024-12-04T05:16:11.608422Z"
    name: task-two
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_list:
        queries:
          - SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    application_info: {}
    ```

    {% endcut %}

1. In the processing results bucket, go to the following folder:

    ```
    dataproc/clusters/<cluster_ID>/jobs/<Hive_job_ID>
    ```

    You can find the job ID in the YC CLI job execution command output and in the API response to the job execution.

1. Download the `driveroutput.000000000` file containing the response to your query.

    {% cut "Example of a response to a query" %}

    ```bash
    Init job c9quejacclo3******** at Wed Dec  4 05:15:40 UTC 2024
    ...
    Connecting to jdbc:hive2://localhost:10000
    Connected to: Apache Hive (version 3.1.2)
    Driver: Hive JDBC (version 3.1.2)
    Transaction isolation: TRANSACTION_REPEATABLE_READ
    0: jdbc:hive2://localhost:10000> SELECT Month, COUNT(*) FROM flights GROUP BY Month;;
    +--------+---------+
    | month  |   _c1   |
    +--------+---------+
    | 1      | 570118  |
    | 2      | 520731  |
    | 3      | 611987  |
    | 4      | 596046  |
    | 5      | 616529  |
    | 6      | 626193  |
    | 7      | 645299  |
    | 8      | 644673  |
    | 9      | 585749  |
    | 10     | 616101  |
    | 11     | 586178  |
    | 12     | 593842  |
    +--------+---------+
    12 rows selected (27.532 seconds)
    0: jdbc:hive2://localhost:10000>
    0: jdbc:hive2://localhost:10000> Closing: 0: jdbc:hive2://localhost:10000
    ```

    {% endcut %}

    If the query runs with errors, the `driveroutput.000000000` file will contain this information as well.

### Providing an SQL query in an {{ objstorage-name }} object {#sql-from-objstorage}

1. Create a file named `create-table.sql` and put an SQL query into it to create an external table for the example data in Parquet format. The table will contain a list of flights between US cities in 2018. Your SQL query will look as follows:

    ```sql
    CREATE EXTERNAL TABLE flights (
        Year bigint,
        Month bigint,
        FlightDate string,
        Flight_Number_Reporting_Airline bigint,
        OriginAirportID bigint,
        DestAirportID bigint)
        STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
    ```

1. [Upload](../../../storage/operations/objects/upload.md) the `create-table.sql` file to the input data bucket.

1. Run this command:

    ```bash
    yc dataproc job create-hive \
      --cluster-id=<cluster_ID> \
      --name=task-one \
      --query-file-uri="s3a://<input_data_bucket_name>/create-table.sql"
    ```

    {% cut "Example of a response to a query" %}

    ```bash
    done (8s)
    id: c9qhpt6334qs********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T04:21:20.062704Z"
    started_at: "2024-12-04T04:21:27.702644Z"
    finished_at: "2024-12-04T04:21:27.702644Z"
    name: task-one
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_file_uri: s3a://<input_data_bucket_name>/create-table.sql
    application_info: {}
    ```

    {% endcut %}

1. Create a file named `get-data.sql` and put an SQL query into it for the number of flights by month:

    ```sql
    SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    ```

1. Upload the `get-data.sql` file to the input data bucket.
1. Run this command:

    ```bash
    yc dataproc job create-hive \
      --cluster-id=<cluster_ID> \
      --name=task-two \
      --query-file-uri="s3a://<input_data_bucket_name>/get-data.sql"
    ```

    {% cut "Example of a response to a query" %}

    ```bash
    done (37s)
    id: c9q2srq817cu********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T04:24:58.480468Z"
    started_at: "2024-12-04T04:25:34.613549Z"
    finished_at: "2024-12-04T04:25:34.613549Z"
    name: task-two
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_file_uri: s3a://<input_data_bucket_name>/get-data.sql
    application_info: {}
    ```

    {% endcut %}

1. In the processing results bucket, go to the following folder:

    ```
    dataproc/clusters/<cluster_ID>/jobs/<Hive_job_ID>
    ```

    You can find the job ID in the YC CLI job execution command output and in the API response to the job execution.

1. Download the `driveroutput.000000000` file containing the response to your query.

    {% cut "Example of a response to a query" %}

    ```bash
    Init job c9q2gha5hocg******** at Wed Dec  4 06:56:45 UTC 2024
    ...
    Connecting to jdbc:hive2://localhost:10000
    Connected to: Apache Hive (version 3.1.2)
    Driver: Hive JDBC (version 3.1.2)
    Transaction isolation: TRANSACTION_REPEATABLE_READ
    0: jdbc:hive2://localhost:10000> SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    +--------+---------+
    | month  |   _c1   |
    +--------+---------+
    | 1      | 570118  |
    | 2      | 520731  |
    | 3      | 611987  |
    | 4      | 596046  |
    | 5      | 616529  |
    | 6      | 626193  |
    | 7      | 645299  |
    | 8      | 644673  |
    | 9      | 585749  |
    | 10     | 616101  |
    | 11     | 586178  |
    | 12     | 593842  |
    +--------+---------+
    12 rows selected (28.801 seconds)
    0: jdbc:hive2://localhost:10000> Closing: 0: jdbc:hive2://localhost:10000
    ```

    {% endcut %}

    If the query runs with errors, the `driveroutput.000000000` file will contain this information as well.

## Working with jobs in the Hive CLI {#hive-shell}

### Getting started {#before-you-begin-hive-shell}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. [Create a {{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `HIVE`
        * `SPARK`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the service account you created earlier.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**: Enable this option to access hosts of all subclusters.

### Running jobs using the Hive CLI {#run-job-hive-shell}

1. [Connect to the master host](../../../data-proc/operations/connect.md#data-proc-ssh) over SSH and run the `hive` command.

1. Test Hive by running the `select 1;` command. The correct result looks like this:

   ```text
   OK
   1
   Time taken: 0.077 seconds, Fetched: 1 row(s)
   ```

1. Create an external table for the data from the example in Parquet format. The table will contain a list of flights between US cities in 2018. Run the following query in the Hive CLI:

    ```sql
    CREATE EXTERNAL TABLE flights (
        Year bigint,
        Month bigint,
        FlightDate string,
        Flight_Number_Reporting_Airline bigint,
        OriginAirportID bigint,
        DestAirportID bigint)
        STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
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

1. Query the number of flights by month:

    ```sql
    SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    ```

    {% cut "Example of a response to a query" %}

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

    {% endcut %}
