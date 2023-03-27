# Sample analysis of data from {{ objstorage-full-name }}

{{ yq-full-name }} lets you access data stored in {{ objstorage-full-name }} by making queries in an SQL-like language called [YQL](https://ydb.tech/en/docs/yql/reference/syntax/).

In this example, we will build a frequency distribution of trip duration vs. trip number as a histogram. For this purpose, we will connect to bucket data and run an analytical query.

The dataset used in the example includes information about taxi trips in New York in 2019-2021. The data was uploaded to {{ objstorage-full-name }} and stored in a public bucket named `yq-sample-data`, in the `tutorial` folder.

To execute the example:

1. [Get started](#before-you-begin).
1. [Create a connection](#create-binding).
1. [Run the query](#run-query).
1. [Review the result](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Getting started {#before-you-begin}

1. Sign in or sign up to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../../resource-manager/operations/folder/create.md).

## Create a connection {#create-binding}

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

## Run the query {#run-query}

1. In the query editor in the {{ yq-full-name }} interface, click **New analytics query**.
1. Enter the query text in the text field:

   ```sql
   $data =
   SELECT
       *
   FROM
       bindings.`tutorial-analytics`;

   $ride_time =
   SELECT
       DateTime::ToMinutes(tpep_dropoff_datetime-tpep_pickup_datetime) as ride_time
   FROM
       $data;

   SELECT
       Histogram::Print(histogram(ride_time))
   FROM
       $ride_time;
   ```

1. Click **Run**.

## Review the result {#check-result}

Once the query is completed, you'll see the following results: distribution of the taxi trip duration by number of trips.

```text
Kind: AdaptiveWard Bins: 100 WeightsSum: 140151844.000 Min: -531231.000 Max: 43648.000
░░░░░░░░░░░░░░░░░░░░░░░░ P:   -5706.500 F:       4.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:   -4177.000 F:       3.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:   -2905.625 F:       8.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:   -1156.556 F:       9.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:     -43.545 F:    1685.000
█████████░░░░░░░░░░░░░░░░ P:       0.523 F: 3205072.000
███████████░░░░░░░░░░░░░░ P:       2.000 F: 3974384.000
█████████████████░░░░░░░░ P:       3.000 F: 6216464.000
██████████████████████░░░ P:       4.000 F: 7799899.000
████████████████████████░ P:       5.000 F: 8431504.000
█████████████████████████ P:       6.000 F: 8637705.000
████████████████████████░ P:       7.000 F: 8461147.000
███████████████████████░░ P:       8.000 F: 8122270.000
██████████████████████░░░ P:       9.000 F: 7643893.000
████████████████████░░░░░ P:      10.000 F: 7143245.000
██████████████████░░░░░░░ P:      11.000 F: 6549030.000
█████████████████░░░░░░░░ P:      12.000 F: 6013493.000
███████████████░░░░░░░░░░ P:      13.000 F: 5452450.000
██████████████░░░░░░░░░░░ P:      14.000 F: 4955050.000
████████████░░░░░░░░░░░░░ P:      15.000 F: 4470485.000
███████████░░░░░░░░░░░░░░ P:      16.000 F: 4047062.000
███████████████████░░░░░░ P:      17.474 F: 6886725.000
████████████████░░░░░░░░░ P:      19.475 F: 5569891.000
█████████████░░░░░░░░░░░░ P:      21.474 F: 4499806.000
██████████░░░░░░░░░░░░░░░ P:      23.475 F: 3646437.000
████████░░░░░░░░░░░░░░░░░ P:      25.475 F: 2962072.000
██████░░░░░░░░░░░░░░░░░░░ P:      27.476 F: 2414497.000
█████░░░░░░░░░░░░░░░░░░░░ P:      29.476 F: 1962886.000
████░░░░░░░░░░░░░░░░░░░░░ P:      31.535 F: 1676489.000
███░░░░░░░░░░░░░░░░░░░░░░ P:      33.542 F: 1301808.000
████░░░░░░░░░░░░░░░░░░░░░ P:      35.855 F: 1408697.000
███░░░░░░░░░░░░░░░░░░░░░░ P:      38.569 F: 1206848.000
███░░░░░░░░░░░░░░░░░░░░░░ P:      41.900 F: 1264922.000
██░░░░░░░░░░░░░░░░░░░░░░░ P:      45.386 F:  745821.000
█░░░░░░░░░░░░░░░░░░░░░░░░ P:      48.358 F:  597152.000
█░░░░░░░░░░░░░░░░░░░░░░░░ P:      51.440 F:  521645.000
█░░░░░░░░░░░░░░░░░░░░░░░░ P:      54.776 F:  442015.000
█░░░░░░░░░░░░░░░░░░░░░░░░ P:      58.505 F:  443528.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:      62.515 F:  344650.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:      67.911 F:  308517.000
░░░░░░░░░░░░░░░░░░░░░░░░░ P:     115.984 F:   22039.000
```

#### See also {#see-also}

* [Named expressions. YQL syntax]({{ ydb.docs }}yql/reference/syntax/expressions#named-nodes)
* [HISTOGRAM. Built-in YQL functions]({{ ydb.docs }}yql/reference/builtins/aggregation#histogram)
* [SQL expression format](../sources-and-sinks/object-storage-binding.md#model-dannyh)
* [{#T}](../concepts/batch-processing.md)
