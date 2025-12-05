# Reading data from {{ monitoring-name }} using {{ yq-name }} connections

{% include [public-preview](../../_includes/preview-pp.md) %}

[{{ monitoring-name }}](../../monitoring/concepts/index.md) allows you to collect and store metrics and display them as charts on dashboards. Data sent to {{ monitoring-name }} consists of measured values (`metrics`) and `labels` that describe them. 

For example, to track the number of application failures, you can use the failure count per time interval as a metric. Data describing a failure, e.g., a host name or application version, serves as labels. The {{ monitoring-name }} interface allows you to aggregate metrics by label.

Example of reading metrics from {{ monitoring-name }}:

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

To read metrics from {{ monitoring-name }}, do the following:
1. Go to **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** in the {{ yq-full-name }} interface and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify a name for a connection to {{ monitoring-name }} in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the drop-down list under **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**, select `{{ ui-key.yql.yq-connection.action_monitoring }}`.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select a service account for metric reads or create a new one with the [`monitoring.viewer`](../../monitoring/security/index.md#monitoring-viewer) role for the cloud.

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.

## Data model {#data-model}

To read metrics from {{ monitoring-name }}, use this SQL statement:

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
- `<labels>`: List of label names for which values must be returned in separate columns.
- `<from_time>`: Left boundary of the required time interval in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format.
- `<to_time>`: Right boundary of the required time interval in ISO 8601 format.

This query will return all `<service>` metric points meeting the `<query>` criteria and within the `[<time_from>, <time_to>)` interval. The query result will include the following columns:

| Name | Data type | Description |
| --- | --- | --- |
| `ts` | `Datetime` | Time of the metric point |
| `value` | `Double?` | Metric point value mapped to the time value from `ts` |
| `type` | `String` | Type of the metric with the point |
| `labels` | `YQL Dict` | Labels of the metric with the point. This column will be missing if you specified the `labels` parameter in the query. |
| `<label>` | `String` | `<label>` value of the metric with the point |

{% note info %}

A query with the `selectors` parameter has no limitations on the number of metrics but only accepts a list of selectors as input. If you need to include query language [functions](../../monitoring/concepts/querying.md#functions), use the `program` parameter.

{% endnote %}

{% note info %}

You do not need to specify the `folderId` and `service` labels in the list of selectors. 

{% endnote %}

### Query parameter format {#parameters_format}

| Parameter name | Format | Example |
| --- | --- | --- |
| `selectors` | `["sensor_name"]{[label_name1 = "label_value1", label_name2 = "label_value2", ...]}` | `{name = "api.grpc.request.bytes", method="DescribeTable"}` |
| `program` | Query in the {{ monitoring-name }} [query language](../../monitoring/concepts/querying.md) | `series_sum{method="DescribeTable"}` |
| `labels` | `"label1 [as alias1], label2 [as alias2], ..."` | `"database.dedicated as db, database_path, api_service as api"` |
| `from / to` | Time in ISO 8601 format | `"2025-05-20T12:00:00Z"` |

### Downsampling parameters {#downsampling_parameters}

{{ yq-full-name }} supports the following [downsampling parameters](../../monitoring/concepts/decimation.md#decimation-methods):

| Parameter name | Description | Possible values | Default value |
| --- | --- | --- | --- |
| `downsampling.disabled` | If `true`, indicates that the response data will not be downsampled | `true`, `false` | `false` |
| `downsampling.aggregation` | Downsampling aggregation function | `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT` | `AVG` |
| `downsampling.fill` | Parameters for filling in missing data | `NULL`, `NONE`, `PREVIOUS` | `PREVIOUS` |
| `downsampling.grid_interval` | Downsampling time window, i.e., grid, size in seconds | Integer | `15` |

## Example of reading metrics {#example}

Example of a query to read metrics from {{ monitoring-name }}:

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

* `monitoring`: Name of the connection to {{ monitoring-name }}.
* `compute`: Service to search within.
* `cpu_name as cpu, resource_id`: List of labels to return values for in separate columns. The value of the `cpu_name` label will be returned in the `cpu` column, and the `resource_id` value, in the `resource_id` column.
* `[2025-03-12T14:00:00Z – 2025-03-12T15:00:00Z)`: Time interval for the search.
