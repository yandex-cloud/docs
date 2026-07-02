# Analytical processing of {{ objstorage-full-name }} data

In this example, you will run [analytical processing](../concepts/batch-processing.md) on New York City taxi ride data. The data for this example has been pre-loaded in the [{{ objstorage-full-name }}](../../storage/index.yaml) bucket in [Parquet](https://parquet.apache.org/docs/file-format/) files.

The output will be a histogram showing the frequency distribution of ride duration by number of rides.

To run this example:

1. [Make the necessary preparations](#before-you-begin).
1. [Connect to the data source](#create-binding).
1. [Run the query](#run-query).
1. [Check the result](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Make the necessary preparations {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up if you have not already. If you have not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have an `ACTIVE` or `TRIAL_ACTIVE` [billing account](../../billing/concepts/billing-account.md). If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).

## Connect to the data source {#create-binding}

 {% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

## Run the query {#run-query}

1. In the query editor within the {{ yq-name }} interface, click **{{ ui-key.yql.yq-ide-header.new-analytics-query.button-text }}**.
1. Enter the query text in the text field:

   ```sql
   $data =
   SELECT
       *
   FROM
       `tutorial-analytics`;

   $ride_time =
   SELECT
       DateTime::ToMinutes(tpep_dropoff_datetime-tpep_pickup_datetime) AS ride_time
   FROM
       $data;

   SELECT
       Histogram::Print(histogram(ride_time))
   FROM
       $ride_time;
   ```

1. Click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

## Check the result {#check-result}

Once executed, the query will return the distribution of taxi ride duration by number of rides.

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

## See also {#see-also}

* [Named expressions in YQL]({{ ydb.docs }}yql/reference/syntax/expressions#named-nodes)
* [HISTOGRAM. Built-in YQL functions]({{ ydb.docs }}yql/reference/builtins/aggregation#histogram)
* [SQL syntax](../sources-and-sinks/object-storage-binding.md#model-dannyh)
* [{#T}](../concepts/batch-processing.md)
