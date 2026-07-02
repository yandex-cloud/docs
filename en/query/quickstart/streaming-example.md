# {{ yds-full-name }} streaming data processing

In this example, you will run [streaming data processing](../concepts/stream-processing.md) on New York City taxi ride data. Data for the example will be written to a dedicated [{{ yds-full-name }}](../../data-streams/index.yaml) stream by a generator.

The result will be the total fare of the first ten rides written to the stream after processing started.

To run this example:

1. [Make the necessary preparations](#before-you-begin).
1. [Create a data stream](#create-datastream).
1. [Set up data generation](#configure-generation).
1. [Run the query](#run-query).
1. [Check the result](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Make the necessary preparations {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up if you have not already. If you have not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have an `ACTIVE` or `TRIAL_ACTIVE` [billing account](../../billing/concepts/billing-account.md). If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).
1. We will connect to the data stream using a [service account](../../iam/concepts/users/service-accounts.md). [Create](../../iam/operations/sa/create.md#create-sa) a service account named `datastream-connection-account` and assign it the `ydb.editor` role.
1. Data streams use {{ ydb-full-name }}. You will need to [create](../../ydb/quickstart.md#serverless) a serverless database.

## Create a data stream {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

## Set up data generation {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

The generator will start writing data to the `yellow-taxi` stream. You can control the generator using the **{{ ui-key.yql.yq-tutorial.stop-stream.button-label }}** and **{{ ui-key.yql.yq-tutorial.run-stream.button-label }}** buttons.

## Run the query {#run-query}

1. In the query editor within the {{ yq-name }} interface, click **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
1. Enter the query text in the text field:

   ```sql
   $data = 
   SELECT 
       *
   FROM
       bindings.`tutorial-streaming` LIMIT 10;

   SELECT
       HOP_END() AS time,
       COUNT(*) AS ride_count,
       SUM(total_amount) AS total_amount
   FROM 
       $data
   GROUP BY 
       HOP(CAST(tpep_pickup_datetime AS Timestamp), "PT1M", "PT1M", "PT1M");
   ```

1. Click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

## Check the result {#check-result}

Once completed, the query returns the total fare (`total_amount`) of the first 10 rides written to the stream after processing started.

| #  | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1  | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

## See also {#see-also}

* [HOP operator and window parameters in streaming data processing](../concepts/stream-processing-windows.md)
* [Aggregate functions in YQL]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [SQL syntax](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/stream-processing.md)
