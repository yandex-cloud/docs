---
title: Calculating log-based metrics
description: 'Log-based metrics: continuous calculation of statistics based on log data with results recorded as metrics in {{ monium-name }}.'
---

# Calculating log-based metrics {#aggregates}

{% include [logs-aggregates-preview](../../_includes/monium/logs-aggregates-preview.md) %}

_Log-based metrics_ means continuous calculation of statistics based on log data to create metrics in {{ monium-name }}.

Here are some examples of metrics you can calculate based on logs:

* Number of logs with an error message in the `message` field.
* Number of unique error recipients, grouped using the API method.
* Maximum query execution time.

## Getting started with log-based metrics {#quick-start}

Address for logging via the API: `{{ api-host-monium }}:443`.

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  To create a log-based metric:

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select one of the following sections on the left:
     * ![alt](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**. Click **{{ ui-key.yacloud_monitoring.logs.logs-metrics.title }}**.
     * ![alt](../../_assets/console-icons/box.svg) **Delivery and storage** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs-metrics.title }}**.
  1. At the top right, click **Create**.
  1. Optionally, enter a name for the metric.
  1. Enter the metric **ID** (metric name value). Usually, it is `name`, but you can also use another label, e.g., `sensor` or `signal`. This name is specified in the shard settings. For more information, see [{#T}](../concepts/querying.md).
  1. Under **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**, enter a query by selecting labels from the list or in text mode. Your query determines which log entries to use to calculate the metric.
  1. Under **Calculation rule**, specify:
     * **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`, `sum`, `min`, `max`, `avg`, `unique`, or `uniqueNewfound`.
     * **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.window }}**: `1 minute` or `5 minutes`.
  1. If you need to break the metric down by attribute values, enter the attribute name under **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**.
  1. Under **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**, check the automatically generated query and, optionally, update the values of the `cluster` and `service` labels.
  1. Click **Create**.

  To create a metric based on a previously built log chart:

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **Overview** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
  1. Enter your query and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
  1. In the **Statistics** tab next to the chart, click **{{ ui-key.yacloud_monitoring.logs.logs-metrics.create }}**.
  1. Specify the metric parameters and, optionally, update your query.
  1. Click **Create**.

{% endlist %}

## Examples of log-based metrics {#quick-examples}

Below are some examples of metrics you can set up based on logs: The project, service, and cluster values are for illustration only. Use your environment values for your metrics.

### Number of events {#example-count}

Calculation of the API query frequency:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project = "logging", service = "query", cluster = "production", message = "*started"}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`
* **Aggregation attribute**: —
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: —
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.window }}**: `1 minute`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, cluster=production, service=logging_aggregates, name=query_got_reqs_1m}`


### Amount of logs read in bytes {#example-bytes}

Bytes read by the service in response to user queries in five minutes:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project='logging', service='query', cluster='production', meta.ch.profile.bytes='*'}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `sum`
* **Aggregation attribute**: `meta.ch.profile.bytes`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: —
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.window }}**: `5 minutes`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, cluster=production, service=logging_aggregates, name=query_bytes_read_5m}`

### Number of unique users with a breakdown by the API method {#example-unique-users}

How many unique users have used specific API methods in one minute:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project='logging', service='query', cluster='production', origin.login='*', func='AutocompleteKeys|AutocompleteValues|SearchLogs'}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `unique`
* **Aggregation attribute**: `origin.login`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: `func`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.window }}**: `1 minute`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, cluster=production, service=logging_aggregates, name=query_unique_users_by_func_1m}`

## How it works {#how-it-works}

### Log-based metric parameters {#rules}

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: Logs to select.
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: Function that calculates the metric value: `count`, `min`, `max`, `avg`, `sum`, `unique`, or `uniqueNewfound`.
* **Aggregation attribute** for `min`, `max`, `avg`, `sum`, `unique`, and `uniqueNewfound`: Name of the attribute whose value is used as a function argument.
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: Attribute used for creating separate aggregates for each value.
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.window }}**: Time range for the calculation of the aggregation function. Supported ranges: `1 minute` and `5 minutes`.
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: Selector to write the metric to {{ monium-name }} with.

### Log selector (query) {#selector}

A _log selector_ is a filter in [query language](../concepts/querying.md) which determines which log entries to use to calculate the metrics. To create metrics, you add to the selector environment labels (`project`, `cluster`, and `service`) and log entry labels (logging level, message text, `meta.*` value, and other attributes).

Environment labels:

{% include [application-labels](../../_includes/monium/application-labels.md) %}

{% note info %}

The `project` value must match the project you are creating the metric in. A metric in the `my_shop` project can only process logs from `project=my_shop`.

{% endnote %}

Selector examples:

```
{project='my_project', service='metabase', level >= 'ERROR', message='*LEAK*', logger='io.netty.util.ResourceLeakDetector'}
{project='my_project', service='journald', cluster='production', meta.systemd_unit='alerting.service', message=*'terminating on uncaught exception;'}
{project='ci', service='api', cluster='stable', message=*'vtail.api.query.Query/SearchLogsStreaming', message=*'DEADLINE_EXCEEDED'}
{project='my_agent', service='telemetry'}
```

### Aggregation function {#aggregation-function}

Once logs are selected using the selector, they are used to calculate a numeric value:

#|
|| **Function** | **Requires an attribute** | **Description** | **Example** ||
|| `count` | No | Number of entries in the selection | Number of logs with a code error, e.g., when `message` contains `panic` ||
|| `min` | Yes | Minimum attribute value | Minimum `meta.cpu_limit` value ||
|| `max` | Yes | Maximum attribute value | Maximum `meta.memory_usage` value ||
|| `avg` | Yes | Average attribute value | Average `meta.event_duration` value ||
|| `sum` | Yes | Sum of attribute values | Sum of `meta.bytes_read` ||
|| `unique` | Yes | Number of unique attribute values | Number of unique `meta.user_id` values ||
|| `uniqueNewfound` | Yes | Number of new unique attribute values compared to previous 48 hours | Number of new error messages (`message`) not registered over the last 48 hours. ||
|#

For the `min`, `max`, `avg`, and `sum` functions, the attribute value is automatically converted to a [floating-point number](https://en.wikipedia.org/wiki/Double-precision_floating-point_format). The maximum supported [accuracy](https://en.wikipedia.org/wiki/Double-precision_floating-point_format#Precision_limitations_on_integer_values) for integer values is `2^53`.

### Grouping {#group-by}

You can additionally specify a grouping attribute. Its values will be used to create separate metrics. For example, if you choose to specify `api_method` as the grouping attribute, its logs containing the `Export`, `Update`, and `Delete` values, three metrics will be created instead of one:

* `api_method=Export`
* `api_method=Update`
* `api_method=Delete`

The grouping attribute is automatically added to the [metric selector](#metrics-selector). There is no need to specify it separately in the final metric.

### Calculation (aggregation) window {#aggregation-window}

Logs for the calculation are selected for a fixed time period: **1 minute** or **5 minutes**.

For example, when counting the number of entries per minute:

#|
|| **Timestamp (ts)** | **Value** | **Description** ||
|| 2025-03-20 11:03:00 | 193 | Log entries for `[11:03:00; 11:04:00)` ||
|| 2025-03-20 11:04:00 | 371 | Log entries for `[11:04:00; 11:05:00)` ||
|| 2025-03-20 11:05:00 | 237 | Log entries for `[11:05:00; 11:06:00)` ||
|#

### Final metric (metric selector) {#metrics-selector}

The selector must have the required labels, i.e., `project`, `cluster`, `service`, and the metric `ID` (the last one denoting the metric name in the project or specified shard). Usually, it is `name`, but you can also use `sensor`, `signal`, or any other label name. For more information, see [{#T}](../concepts/querying.md). Here is an example:

`{project='shop', cluster='production', service='logging_aggregates', name='unique_users_5m'}`

If a grouping attribute is specified, it gets added to the metric automatically. For example, for the `{project='logging', cluster='production', service='logging_aggregates', name='api_errors'}` metric selector and the `api_method` grouping attribute, the following metrics will be created:

#|
|| **Timestamp (ts)** | **Labels** | **Value** ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', api_method=Export}` | 100 ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', api_method=ListEntries}` | 4 ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', api_method=Delete}` | 82 ||
|| ... | ... | ... ||
|#

Grouping attribute values can be used in substitutions. For example, if the grouping uses `api_method`, you can specify the following in the metric selector:

`{project='logging', cluster='production', service='logging_aggregates', endpoint=grpc.not_var{{api_method}}, name='api_errors'}`

As a result, the `api_method` label is not added automatically and the value is substituted to the `endpoint` label:

#|
|| **Timestamp (ts)** | **Labels** | **Value** ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', endpoint=grpc.Export}` | 100 ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', endpoint=grpc.ListEntries}` | 4 ||
|| 2025-02-13 17:03:00 | `{..., name='api_errors', endpoint=grpc.Delete}` | 82 ||
|| ... | ... | ... ||
|#

### Grouping and substitution scenarios {#groupby-scenarios}

#### Automatic substitution of grouping values {#auto-substitution}

If grouping by the `origin.login` attribute and this metric selector:

`{project=logging, service=logs_to_metrics, cluster=production, name=reqs_by_login}`

the following label will be added to the metric selector automatically:

`{project=logging, service=logs_to_metrics, cluster=production, name=reqs_by_login, origin.login=not_var{{origin.login}}`

If a log entry contains `origin.login=ivan_petrov`, the metric will be written based on these labels:

`{project=logging, service=logs_to_metrics, cluster=production, name=reqs_by_login, origin.login=ivan_petrov}`

#### Automatic substitution of several values {#auto-substitution-multiple}

If grouping by several attributes, e.g., `host` and `component`, they will be added to the metric automatically:

`{project=logging, service=logs_to_metrics, cluster=production, name=cnt, host='not_var{{host}}', component='not_var{{component}}'}`

#### Manual substitution setup {#explicit-substitution}

In addition to automatic substitution, you can set up substitution manually. The following metric selectors yield the same result:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project=logging, service=query, cluster=production, host=*}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: `host`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }} 1**: `{project=logging, service=logs_to_metrics, cluster=production, name=cnt}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }} 2**: `{project=logging, service=logs_to_metrics, cluster=production, name=cnt, host='not_var{{host}}'}`

In such substitutions, you can replace both the key and the value. Here is an example:

`{project=logging, service=logs_to_metrics, cluster=production, name=errors, host='query-not_var{{host}}', context='query_not_var{{host}}_not_var{{component}}_production'}`


#### Grouping by cluster {#group-by-cluster}

There are several supported options for grouping by `cluster`:

Option 1. Cluster as the `cluster` label value:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project=logging, service=query}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: `cluster`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, service=logs_to_metrics, cluster='not_var{{cluster}}', name=cnt}`

Option 2. Cluster as the custom `user_cluster` label value:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project=logging, service=query}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: `cluster`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, service=logs_to_metrics, cluster=production, name=cnt, user_cluster='not_var{{cluster}}'}`

#### Grouping by service {#group-by-service}

Grouping by service is only supported when the values are listed explicitly:

* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.log-selector }}**: `{project=logging, service=query|collector}`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.row.aggregate-function-key-value }}**: `count`
* **{{ ui-key.yacloud_monitoring.logs-metrics.form.block.group-by }}**: `service`
* **{{ ui-key.yacloud_monitoring.logs-metrics.view.field.output-metric }}**: `{project=logging, service='not_var{{service}}', cluster=production, name=cnt}`

## Quotas and limits {#quota}

Each project is allocated a certain amount of CPU and RAM resources for calculation of log-based metrics. The maximum number of metrics per project is 1,000.

To increase the quota, contact [support]({{ link-console-support }}).

### How to reduce resource consumption {#usage-optimizations}

* Use exact values in selectors. Avoid using regular and wildcard expressions as they increase the CPU load.
 
  Not recommended:
  ```
  {..., api_endpoint="*Export*", ...}
  ```

  Recommended:
  ```
  {..., api_endpoint="/api/v1/Export", ...}
  ```

* Move costly comparisons to the end of the selector. If you cannot avoid using wildcard expressions, put them after exact conditions.

  Not recommended:
  ```
  {..., message = "*panic*", error_code="500", ...}
  ```

  Recommended:
  ```
  {..., error_code="500", message = "*panic*"}
  ```

  This way, most of the logs will get filtered out when checking the `error_code` attribute.

* To reduce RAM usage, set the `5 minutes` aggregation window.

## Calculation specifics {#guarantees}

* The log-based metric value appears with a delay which depends on the aggregation window duration. The maximum delay is `3 minutes` after the end of the window. For example, for the `1m` window, the value for the `17:07:00`–`17:08:00` interval will be available no later than `17:11:00`.
* You can get different values from raw logs and log-based metrics. For example, log search may return `X` entries for a selector, while the `count` metric may return `Y` for the same selector.
* The `unique` function returns an approximate number of unique items. Read more in [HyperLogLog](https://en.wikipedia.org/wiki/HyperLogLog).
* Resent log entries are counted again; there is no deduplication.
* Numeric values of attributes are converted to [floating-point numbers](https://en.wikipedia.org/wiki/Double-precision_floating-point_format). The maximum supported [accuracy](https://en.wikipedia.org/wiki/Double-precision_floating-point_format#Precision_limitations_on_integer_values) for integer values is `2^53`.

### Quota exhaustion {#guarantees-quota-overflow}

When the quota for log-based metrics is exceeded:

* Logging continues.
* Metric values may be incomplete.
* New metrics may be created if [grouping](#group-by) is configured for a log-based metric.

### Writing to the past {#backfill}

A metric value may be recalculated for logs written up to **30 minutes** into the past.

Let’s look into the following example:

* We have set up a log-based metric for per-minute `count` of `{project, cluster, service, message=*'failed'}`.
* The current time is `17:29:17`.

If {{ monium-name }} receives these two log entries, the following operations take place:

#|
|| **Timestamp (ts)** | **Log** | **What happens to the metric** ||
|| 16:59:00 | `message=failed to exec request ...` | The log entry is written, the value for this minute will not be recalculated ||
|| 17:00:00 | `message=failed to load data from ...` | The log entry is written, the value for 17:00:00 will be recalculated ||
|#

## Metric display specifics {#display}

{% note info %}

We recommend displaying log-based metrics as [columns](../metrics/metric-explorer.md#set-graph). This shows that every point is an aggregated value over a time interval, not a current value.

{% endnote %}

* All metrics are written with the [DGAUGE](../concepts/data-model.md#metric-types) type.
* Each point on the chart shows a value over the aggregation window, not per second. For example, in a metric counting the number of API requests per minute, the point shows the number of requests **per minute**.
* If during the aggregation window no logs that match the selection were received, the value for that period is not sent resulting in a gap on the chart.
* When [decimating metrics](../metrics/metric-explorer.md#set-graph), specify an interval equal to the aggregation window: `1 minute` or `5 minutes`.
* Log-based metrics with the `unique`, `uniqueNewfound`, and `avg` functions are incompatible with decimation, so you should disable it when viewing large time ranges.
* Metric points for the last 30 minutes can be recalculated and resent to {{ monium-name }}. If metric-based aggregation is set up in the shard, this may cause values to be displayed incorrectly.

### Decimation and compatibility with aggregation functions {#downsampling}

{% note info %}

When viewing metrics, specify a decimation interval equal to the calculation window: `1 minute` or `5 minutes`.

{% endnote %}

When you view metrics over a large time interval, {{ monium-name }} turns on [decimation](../concepts/decimation.md): out of several points, one is calculated using the aggregation function. For example, if a log-based metric is calculated once per minute, and the chart covers 24 hours, each point will represent an average of a set of points.

Recommendations on configuring decimation for different functions:

#|
|| **Aggregation function** | **Recommendation** ||
|| `min` | In the [chart settings](../metrics/metric-explorer.md#set-graph), go to the decimation section and select the `min` aggregation function. ||
|| `max` | Select the `max` aggregation function. ||
|| `sum` | Select the `sum` aggregation function. ||
|| `count` | Select the `sum` or `avg` aggregation function depending on the metric type (counter or rate). ||
|| `avg`, `unique`, `uniqueNewfound` | Decimation is not supported. Correct values are available only for individual points prior to decimation. ||
|#

The `avg`, `unique`, and `uniqueNewfound` functions are incompatible with aggregation in {{ monium-name }} metrics, e.g., for `unique`:

* The API is alternately accessed by two users, `user1` and `user2`, once a minute.
* The log-based metric with the `unique` function writes `1` once a minute.
* If viewed on a 24-hour scale, none of the decimation functions will return a correct value:
  * `sum` will count `60`.
  * `min` and `max` will count `1`.
  * `avg` will count `1`.
  * The correct value is `2` (two unique users during the hour).
