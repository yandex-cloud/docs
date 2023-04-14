# Sample analysis of streaming data

{{ yq-full-name }} can run [streaming processing](../concepts/stream-processing.md) of data in an SQL-like language called [YQL](https://ydb.tech/en/docs/yql/reference/syntax/).

In this example, we'll use a ready-made dataset on New York City taxi trips. As a result, we will calculate the count and total cost of the first trips. For this, we will create a [data stream](../../data-streams/concepts/glossary.md) and write data to it using a generator. Then we'll run a YQL query to get the count of trips and their cost.

To execute the example:

1. [Get started](#before-you-begin).
1. [Create a data stream](#create-datastream).
1. [Set up data generation](#configure-generation).
1. [Run the query](#run-query).
1. [Review the result](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Getting started {#before-you-begin}

1. Sign in or sign up to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../../resource-manager/operations/folder/create.md).
1. We will connect to our data stream using a [service account](../../iam/concepts/users/service-accounts.md). Thus, you will need to [create](../../iam/operations/sa/create.md#create-sa) a service account with the `datastream-connection-account` name and the `ydb.editor` role.
1. Data streams use {{ ydb-full-name }}. [Create](../../ydb/quickstart.md#serverless) a serverless database.

## Create a data stream {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

## Set up data generation {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Data generation to the `yellow-taxi` stream will start. Use the **Stop** and **Start** buttons to control the data generator.


## Run the query {#run-query}

1. In the query editor in the {{ yq-full-name }} interface, click **New streaming query**.
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

1. Click **Run**.

## Review the result {#check-result}

Once the query is completed, you'll see the following results: the number of trips and the total cost of the first trips made after running the query.

| # | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1 | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

#### See also {#see-also}

* [HOP. Window parameters in streamed data processing](../concepts/stream-processing-windows.md)
* [Aggregate functions. YQL syntax]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [SQL expression format](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/stream-processing.md)
