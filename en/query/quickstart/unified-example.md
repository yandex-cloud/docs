---
title: Unified analysis of streaming and analytical data using the example of calculating the cost of taxi rides
description: "In this example, you will calculate the cost of taxi rides in specific locations\_using a single query against analytical and streaming data."
---

# Unified analysis of streaming and analytical data

In this example, you will calculate the cost of taxi rides in specific locations using a single query against [analytical](../concepts/batch-processing.md) and [streaming](../concepts/stream-processing.md) data.

The text of the SQL query used to process both data types is the same: only the [connections](../concepts/glossary.md#connection) and [data bindings](../concepts/glossary.md#binding) for the bucket and stream are different.

Data for analytical processing was placed in the [{{ objstorage-full-name }}](../../storage/index.yaml) bucket, in [Parquet](https://parquet.apache.org/docs/file-format/) files. Stream data will be written by a generator to a dedicated [{{ yds-full-name }}](../../data-streams/index.yaml) stream.

In both cases, we use a reference stored in {{ objstorage-name }} to filter our query data.

To run this example:

1. [Get ready](#before-you-begin).
1. [Analyze the data from {{ objstorage-name }}](#batch).
1. [Analyze the streaming data from {{ yds-name }}](#stream).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Get started {#before-you-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).
1. We will connect to our data stream using a [service account](../../iam/concepts/users/service-accounts.md). [Create](../../iam/operations/sa/create.md#create-sa) a service account named `datastream-connection-account` with the `ydb.editor` role.
1. Data streams use {{ ydb-full-name }}. You will need to [create](../../ydb/quickstart.md#serverless) a serverless database.

## Analyze the data from {{ objstorage-name }} {#batch}

### Connect to analytical data {#batch-create-binding}

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

### Run a query {#batch-run-query}

1. In the query editor in the {{ yq-name }} interface, click **{{ ui-key.yql.yq-ide-header.new-analytics-query.button-text }}**.
1. Enter the query text in the text field:

   ```sql
   $data =
   SELECT
       *
   FROM
       `tutorial-analytics`;

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
       HOP(CAST(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
       rides.PULocationID;

   SELECT
       *
   FROM
       $time;
   ```

1. Click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

### Review the result {#batch-check-result}

Once the analytical query is complete, you will see the result: distribution of taxi ride costs in specific locations.

| #  | time | PULocationID | total_amount |
| --- | --- | --- | --- |
| 1  | 2017-12-31T22:24:00.000000Z | 120 | 7.54  |
| 2  | 2018-01-01T00:13:00.000000Z | 120 | 48.8  |
| 3  | 2018-01-01T03:25:00.000000Z | 120 | 30.8  |
| 4  | 2018-01-01T11:29:00.000000Z | 120 | 32.88 |
| 5  | 2018-01-01T15:13:00.000000Z | 120 | 9.8   |
| 6  | 2018-01-01T22:03:00.000000Z | 120 | 14.8  |
| 7  | 2018-01-02T19:28:00.000000Z | 120 | 7.3   |
| 8  | 2018-01-03T10:17:00.000000Z | 120 | 81.3  |

## Analyze the {{ yds-name }} streaming data {#stream}

### Create a data stream {#stream-create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

### Set up data generation {#stream-configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Data generation to the `yellow-taxi` stream will start. Use the **{{ ui-key.yql.yq-tutorial.stop-stream.button-label }}** and **{{ ui-key.yql.yq-tutorial.run-stream.button-label }}** buttons to control the data generator.

### Run a query {#stream-run-query}

1. In the query editor in the {{ yq-name }} interface, click **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
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

1. Click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

### Review the result {#stream-check-result}

Once you run the query to the streaming data, you will see the result with the total cost of rides (`total_amount`) in specific `PULocationID` locations taken after running the query.

| #  | PULocationID | time | total_amount |
| --- | --- | --- | --- |
| 1  | 125 | 2022-02-15T12:03:00.000000Z | 1275.4084 |
| 2  | 129 | 2022-02-15T12:03:00.000000Z | 1073.0449 |
| 3  | 126 | 2022-02-15T12:03:00.000000Z | 202.85883 |
| 4  | 121 | 2022-02-15T12:03:00.000000Z | 636.8784  |
| 5  | 124 | 2022-02-15T12:03:00.000000Z | 923.87805 |
| 6  | 127 | 2022-02-15T12:04:00.000000Z | 2105.3125 |
| ... |

## See also {#see-also}

* [HOP. Window parameters in streamed data processing](../concepts/stream-processing-windows.md)
* [Aggregate functions. YQL syntax]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [SQL expression format](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/batch-processing.md)
* [{#T}](../concepts/stream-processing.md)
