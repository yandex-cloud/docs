# Monitoring the transfer status

Transfer status details are available in the management console. You can view them on the **Monitoring** tab of the {% if audience != "internal" %} transfer management page or in [{{ monitoring-full-name }}](../../monitoring/concepts/index.md){% endif %}.

Diagnostic information about the transfer status is presented as charts.

{% if audience != "internal" %}

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about transfer failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you'll receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).

{% endif %}

## Monitoring the transfer status {#monitoring}

To view information about the transfer status:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click on the name of the transfer and open the **Monitoring** tab.
   1. To get started with {{ monitoring-full-name }} metrics, dashboards, or alerts, click **Open in Monitoring** on the top panel.

{% endlist %}

The following charts open on the page:

### Data upload lag (histogram by seconds) {sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

Histogram showing the difference between the time records appear on the target and the time they appear on the source (in seconds). The histogram is broken down into `bins`.

Let us assume, the histogram is showing two `bins` for 45 and 60 at a given point in time, with each containing a value equal to 50%. This means that half the records being transferred at the time had a delay of between 30 and 45 seconds, and the other half of between 45 and 60 seconds.

### Successfully pushed rows {sinker.pusher.data.row_events_pushed}
`sinker.pusher.data.row_events_pushed`

   * For table-based DBMS systems, table row insert performance.
   * For non-relational DBMS systems, transfer performance for objects stored in collections (objects per second).

### Maximum lag on delivery {sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Maximum data lag (in seconds).

### Successfully pushed rows by tables (top-50 tables) {sinker.table.rows}
`sinker.table.rows`

Top 50 tables with the maximum number of rows written to the target.

### Read buffer size {publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

The size, in bytes, of the buffer or write ahead log (when supported) in the source.

### Read bytes from source (top-50 workers) {`publisher.data.bytes`}
`publisher.data.bytes`

The amount of data read from the source (in bytes).

### Sink response time (histogram by seconds) {sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Time to complete a full data transfer including preprocessing (in seconds).

### Read rows (parsed/unparsed) {publisher.data.*parsed_rows}
`publisher.data.*parsed_rows`

The number of rows read from the source.

### Snapshot task progress (top-50 tables) {task.snapshot.remainder.table}
`task.snapshot.remainder.table`

The number of rows awaiting transfer.

### Snapshot task status {task.status}
`task.status`

The operation in progress (increment if `0`, and snapshot if `1` ).

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up alerts for transfer status indicators:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the transfer you wish to set up alerts for.
   1. In the list of services, select **Monitoring**.
   1. Under **Service dashboards**, select **{{ data-transfer-name }}**.
   1. In the desired chart with metrics, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there is more than one metric on the chart, create a data query to generate a metric.{% if audience == "external" %} For more information about the query language, [see the {{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md). {% endif %}
   1. Set the `Alarm` and `Warning` notification threshold values.
   1. Click **Create alert**.

{% endlist %}

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
|---------------------------------------|:------------------------------------:|:-------:|:-------------------------------------------------------------------------------------:|
| Maximum data transfer delay | `sinker.pusher.time.row_max_lag_sec` | `15` | — |
| Buffer size in the source | `publisher.consumer.log_usage_bytes` | — | Not less than the maximum amount of data received by the source within a single transaction |
|                                       |                                      |         |                                                                                       |
