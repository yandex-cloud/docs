---
title: Reading data from {{ monitoring-full-name }} via {{ yq-full-name }} connections
description: In this article, you will learn how to set up a connection and read metrics from {{ monitoring-name }} using {{ yq-full-name }}.
---

# Reading data from {{ monitoring-name }} via {{ yq-name }} connections

{% include [public-preview](../../_includes/preview-pp.md) %}

[{{ monitoring-name }}](../../monitoring/concepts/index.md) is a service that collects, stores, and presents metrics on dashboards. The data in {{ monitoring-name }} contains the measured values ​​(metrics) and labels describing them.

For example, to count app failures, you can use _failure count during time interval_ as the metric. _Host name_ and _application version at the time of failure_ are labels. In the {{ monitoring-name }} interface, you can aggregate metrics by labels.

Query example for reading metrics from {{ monitoring-name }}:

```sql
SELECT
    *
FROM
    monitoring.ydb
WITH (
    program = @@max{method="DescribeTable"}@@,

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z"
);
```

## Setting up a connection {#setup-connection}

To set up metric reading from {{ monitoring-name }}:

1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify the {{ monitoring-name }} connection name in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** field, select `{{ ui-key.yql.yq-connection.action_monitoring }}`.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select the service account you will use to read metrics or create a new one and assign the [`monitoring.viewer`](../../monitoring/security/index.md#monitoring-viewer) role for the cloud to it.

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Data model {#data-model}

To read metrics from {{ monitoring-name }}, use the following SQL statement:

```sql
SELECT
    *
FROM
    <connection>.<service>
WITH (
    (selectors|program) = "<query>",
    labels = "<labels>",
    from = "<from_time>",
    to = "<to_time>",
    <downsampling_parameters>
)
```

Where:

- `<connection>`: Name of the {{ monitoring-name }} connection created in the previous step.
- `<service>`: {{ monitoring-name }}.
- `<query>`: Query in the {{ monitoring-name }} [query language](../../monitoring/concepts/querying.md).
- `<labels>`: List of label names whose values must be returned in separate columns.
- `<from_time>`: Time interval start time in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format.
- `<to_time>`: Time interval end time in ISO 8601 format.

This query will return all data points of all `<service>` metrics matching the `<query>` and falling within the time interval between `<time_from>` and `<time_to>`. The query result will contain the following columns:

| Name | Data type | Description |
| --- | --- | --- |
| `ts` | `Datetime` | Metric data point timestamp |
| `value` | `Double?` | Metric data point value corresponding to the time in the `ts` column |
| `type` | `String` | Metric type |
| `labels` | `YQL Dict` | Metric labels. This column will be omitted if you specified the `labels` parameter in the query |
| `<label>` | `String` | Metric `<label>` value |

{% note info %}

A query with the `selectors` parameter has no limits on the number of metrics, but is constrained to using only a set of selectors provided as input. If you need to include query language [functions](../../monitoring/concepts/querying.md#functions), use the `program` parameter.

{% endnote %}

{% note info %}

You do not need to specify the `folderId` and `service` labels in the list of selectors. 

{% endnote %}

### Query parameter format {#parameters-format}

| Parameter name | Format | Example |
| --- | --- | --- |
| `selectors` | `["sensor_name"]{[label_name1 = "label_value1", label_name2 = "label_value2", ...]}` | `{name = "api.grpc.request.bytes", method="DescribeTable"}` |
| `program` | Query in the {{ monitoring-name }} [query language](../../monitoring/concepts/querying.md) | `series_sum{method="DescribeTable"}` |
| `labels` | `"label1 [as alias1], label2 [as alias2], ..."` | `"database.dedicated as db, database_path, api_service as api"` |
| `from / to` | Time in ISO 8601 format | `"2025-05-20T12:00:00Z"` |

### Downsampling parameters {#downsampling-parameters}

{{ yq-full-name }} supports the following [downsampling parameters](../../monitoring/concepts/decimation.md#decimation-methods):

| Parameter name | Description | Valid values | Default value |
| --- | --- | --- | --- |
| `downsampling.disabled` | If `true`, the response data will not be downsampled | `true`, `false` | `false` |
| `downsampling.aggregation` | Downsampling aggregation function | `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT` | `AVG` |
| `downsampling.fill` | Data gap-filling settings | `NULL`, `NONE`, `PREVIOUS` | `PREVIOUS` |
| `downsampling.grid_interval` | Downsampling window size, in seconds | Integer | `15` |

## Metric reading example {#example}

Query example for reading metrics from {{ monitoring-name }}:

```sql
SELECT
    *
FROM
    monitoring.compute
WITH (
    selectors = @@"cpu_utilization"{resource_type="vm"}@@,

    labels = "cpu_name as cpu, resource_id",

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z",

    `downsampling.aggregation` = "AVG",
    `downsampling.fill` = "PREVIOUS",
    `downsampling.grid_interval` = "15"
);
```

Where:

* `monitoring`: {{ monitoring-name }} connection name.
* `compute`: Target service for search.
* `cpu_name as cpu, resource_id`: List of labels whose values will be returned in separate columns. The system will return the `cpu_name` label value in the `cpu` column, and the `resource_id` in the `resource_id` column.
* `[2025-03-12T14:00:00Z – 2025-03-12T15:00:00Z)`: Search time interval.
