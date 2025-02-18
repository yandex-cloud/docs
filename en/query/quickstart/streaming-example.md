# Processing of data streams from {{ yds-full-name }}

In this example, you will [process a data stream](../concepts/stream-processing.md) on New York City taxi rides. Data for the example will be written by a generator to a dedicated [{{ yds-full-name }}](../../data-streams/index.yaml) stream.

As a result, you will get the total cost of the first ten rides since the stream data processing began.

To run this example:

1. [Get started](#before-you-begin).
1. [Create a data stream](#create-datastream).
1. [Set up data generation](#configure-generation).
1. [Run the query](#run-query).
1. [Review the result](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Get started {#before-you-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).
1. We will connect to our data stream using a [service account](../../iam/concepts/users/service-accounts.md). [Create](../../iam/operations/sa/create.md#create-sa) a service account named `datastream-connection-account` with the `ydb.editor` role.
1. Data streams use {{ ydb-full-name }}. You will need to [create](../../ydb/quickstart.md#serverless) a serverless database.

## Create a data stream {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

## Set up data generation {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Data generation to the `yellow-taxi` stream will start. Use the **{{ ui-key.yql.yq-tutorial.stop-stream.button-label }}** and **{{ ui-key.yql.yq-tutorial.run-stream.button-label }}** buttons to control the data generator.

## Run the query {#run-query}

1. In the query editor in the {{ yq-name }} interface, click **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
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

## Review the result {#check-result}

Once the query is completed, you will see the result with the total cost (`total_amount`) of the first 10 rides taken after running the query.

| #  | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1  | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

## See also {#see-also}

* [HOP. Window parameters in streamed data processing](../concepts/stream-processing-windows.md)
* [Aggregate functions. YQL syntax]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [SQL expression format](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/stream-processing.md)
