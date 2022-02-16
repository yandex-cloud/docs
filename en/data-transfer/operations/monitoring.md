# Monitoring the transfer status

Transfer status details are available in the management console. You can view them on the **Monitoring** tab of the transfer management page or in [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Diagnostic information about the transfer status is presented as charts.

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about transfer failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you'll receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).

## Monitoring the transfer status {#monitoring}

To view information about the transfer status:

1. Go to the folder page and select **{{ data-transfer-name }}**.
1. Select the **Transfers** tab.
1. Click on the name of the transfer and open the **Monitoring** tab.
1. To get started with {{ monitoring-full-name }} metrics, dashboards, or alerts, click **Open in Monitoring** in the top panel.

The following charts open on the page:

* **Data upload lag (histogram by seconds)**: Data lag (in seconds).
* **Successfully pushed rows**: The number of rows written to the target.
* **Maximum lag on delivery**: Maximum data lag (in seconds).
* **Successfully pushed rows by tables (top-50 tables)**: Top 50 tables with the maximum number of rows written to the target.
* **Read buffer size**: The size, in bytes, of the buffer or write ahead log (when supported) in the source.
* **Read bytes from source**: The amount of data read from the source (in bytes).
* **Sink response time (histogram by seconds)**: Target response time (in seconds).
* **Read rows (parsed/unparsed)**: The number of rows read from the source.
* **Snapshot task progress (top-50 tables)**: The number of rows awaiting transfer.
* **Snapshot task status**: The operation in progress (replication if`0`, and copying if `1` ).

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up alerts for transfer status indicators:

1. In the management console, select the folder with the transfer you wish to set up alerts for.
1. In the list of services, select **Monitoring**.
1. Under **Service dashboards**, select **{{ data-transfer-name }}**.
1. On the desired metrics chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
1. If there is more than one metric on the chart, create a data query to generate a metric.{% if audience == "external" %} For more information about the query language, [see the {{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).{% endif %}
1. Set the `Alarm` and `Warning` notification threshold values.
1. Click **Create alert**.

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
| --------------------------------------- | :------------------------------------: | :-------: | :-------------------------------------------------------------------------------------: |
| Maximum data transfer delay | `sinker.pusher.time.row_max_lag_sec` | `15` | — |
| Buffer size in the source | `publisher.consumer.log_usage_bytes` | — | Not less than the maximum amount of data received by the source within a single transaction |
|  |  |  |  |

