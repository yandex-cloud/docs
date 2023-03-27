# Sample unified analysis of streaming and analytical data

{{ yq-full-name }} is designed using the concept of [unified streaming and analytical computations](../concepts/unified-processing.md). This lets you use a single query to process both streaming and analytical data.

In this example, we will use a single request to calculate the number and cost of taxi rides in certain locations.

We will use a ready-made dataset on New York City taxi trips:
* Using a streaming data generator.
* Using the analytical data uploaded to {{ objstorage-full-name }} and stored in a public bucket named `yq-sample-data` in the `tutorial` folder.

In both cases, we use a reference stored in {{ objstorage-full-name }} to filter our query data.

To run this example:
1. [Get started](#before-you-begin).
1. [Analyze the data from {{ objstorage-full-name }}](#analyze-data).
1. [Analyze the streaming data](#analyze-streaming).
1. [Make conclusions](#conclusions).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Getting started {#before-you-begin}

1. Sign in or sign up to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../../resource-manager/operations/folder/create.md).
1. We will connect to our data stream using a [service account](../../iam/concepts/users/service-accounts.md). Thus, you will need to [create](../../iam/operations/sa/create.md#create-sa) a service account with the `datastream-connection-account` name and the `ydb.editor` role.
1. Data streams use {{ ydb-full-name }}. You will need to [create](../../ydb/quickstart.md#serverless) a serverless database.

## Analyze the data from {{ objstorage-full-name }} {#analyze-data}

### Create a connection for analytical data processing {#create-binding}

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

### Run the query {#run-query-analytics}

1. In the query editor in the {{ yq-full-name }} interface, click **New analytics query**.
1. Enter the query text in the text field:

   ```sql
   $data =
   SELECT
       *
   FROM
       `bindings`.`tutorial-analytics`;

   $locations =
   SELECT
       PULocationID
   FROM
       `tutorial-analytics`.`nyc_taxi_sample/example_locations.csv`
   WITH
   (
       format=csv_with_names,
       SCHEMA
       (
           PULocationID String
       )
   );

   $time =
   SELECT
       HOP_END() AS time,
       rides.PULocationID AS PULocationID,
       SUM(total_amount) AS total_amount    
   FROM $data AS rides
   INNER JOIN $locations AS locations
       ON rides.PULocationID=locations.PULocationID
   GROUP BY
       HOP(cast(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
       rides.PULocationID;

   SELECT
       *
   FROM
       $time;
   ```
1. Click **Run**.

### Review the result {#check-result-analytics}

Once the analytical query is complete, you will see the result, which in our case will be distribution of the taxi trip duration by the number of trips.

| # | time | PULocationID | total_amount |
| --- | --- | --- | --- |
| 1 | 2017-12-31T22:24:00.000000Z | 120 | 7.54 |
| 2 | 2018-01-01T00:13:00.000000Z | 120 | 48.8 |
| 3 | 2018-01-01T03:25:00.000000Z | 120 | 30.8 |
| 4 | 2018-01-01T11:29:00.000000Z | 120 | 32.88 |
| 5 | 2018-01-01T15:13:00.000000Z | 120 | 9.8 |
| 6 | 2018-01-01T22:03:00.000000Z | 120 | 14.8 |
| 7 | 2018-01-02T19:28:00.000000Z | 120 | 7.3 |
| 8 | 2018-01-03T10:17:00.000000Z | 120 | 81.3 |

## Analyze the streaming data {#analyze-streaming}

### Create a data stream {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

### Set up data generation {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Data generation to the `yellow-taxi` stream will start. Use the **Stop** and **Start** buttons to control the data generator.

### Run the query {#run-query-streaming}

1. In the query editor in the {{ yq-full-name }} interface, click **New streaming query**.
1. Enter the query text in the text field:

   ```sql
   $data =
   SELECT
       *
   FROM bindings.`tutorial-streaming`;

   $locations =
   SELECT
       PULocationID
   FROM
       `tutorial-analytics`.`nyc_taxi_sample/example_locations.csv`
   WITH
   (
       format=csv_with_names,
       SCHEMA
       (
           PULocationID String
       )
   );

   $time =
   SELECT
       HOP_END() AS time,
       rides.PULocationID AS PULocationID,
       SUM(total_amount) AS total_amount    
   FROM $data AS rides
   INNER JOIN $locations AS locations
       ON rides.PULocationID=locations.PULocationID
   GROUP BY
       HOP(cast(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
       rides.PULocationID;

   SELECT
       *
   FROM
       $time;
   ```
1. Click **Run**.

### Review the result {#check-result-streaming}

Once the query to the streaming data is complete, you will see the result, which in our case will be the number and total cost of the trips made in specific locations after the query was run.

| # | PULocationID | time | total_amount |
| --- | --- | --- | --- |
| 1 | 125 | 2022-02-15T12:03:00.000000Z | 1275.4084 |
| 2 | 129 | 2022-02-15T12:03:00.000000Z | 1073.0449 |
| 3 | 126 | 2022-02-15T12:03:00.000000Z | 202.85883 |
| 4 | 121 | 2022-02-15T12:03:00.000000Z | 636.8784 |
| 5 | 124 | 2022-02-15T12:03:00.000000Z | 923.87805 |
| 6 | 127 | 2022-02-15T12:04:00.000000Z | 2105.3125 |

## Conclusions {#conclusions}

The example above used a unified query for analyzing data from {{ objstorage-full-name }}, as well as for streaming data. The text of SQL queries used for data analysis is the same. The queries only differ in data connections: the first query accesses {{ objstorage-full-name }}, while the second one accesses {{ yds-full-name }}.
