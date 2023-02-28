# Monitoring the transfer status

Transfer status details are available in the management console. {% if audience != "internal" %}You can view them on the **Monitoring** tab of the transfer management page or in [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).{% else %}To view the details, select a transfer, and under **General information**, click the **Dashboard link**.{% endif %}

Diagnostic information about the transfer status is presented as charts.

{% if audience != "internal" %}

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about transfer failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you'll receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).

{% else %}

You can configure alerts in {{ monitoring-full-name }} to receive notifications about transfer failures. Two internal services can be used to configure alerts:
* Solomon: Stores {{ data-transfer-short-name }} process metrics.
* Juggler: Tracks a collection of events and notifies of events using different methods.

See detailed information about alerts on the service's [wiki page](https://wiki.yandex-team.ru/transfer-manager/replication/monitoring/alerts/).

{% endif %}

{% if audience != "internal" %}

## Monitoring the transfer status {#monitoring}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
{% if audience != "internal" %}
   1. Click the name of the desired transfer and open the ![image](../../_assets/monitoring.svg) **Monitoring** tab.
{% else %}
   1. Click the name of the desired transfer and under **General information**, click the **Link to dashboard**.
{% endif %}
   1. To get started with {{ monitoring-full-name }} metrics, dashboards, or alerts, click **Open in Monitoring** in the top panel.

{% endlist %}

The following charts open on the page:

### Data upload lag (histogram by seconds) {sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

The time difference between when the records appear on the target and when they appear on the source (in seconds). The histogram is divided into `bins`. Let us assume, the histogram is showing two `bins` for 45 and 60 at a given point in time, with each containing a value equal to 50%. This means that half the records being transferred at the time had a delay of between 30 and 45 seconds, and the other half of between 45 and 60 seconds.

### Successfully pushed rows {sinker.pusher.data.row_events_pushed}
`sinker.pusher.data.row_events_pushed`

For table-based DBMS, table row insert speed. For non-relational DBMS, this is the transfer speed for objects stored in collections (objects per second).

### Maximum lag on delivery {sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Maximum data lag (in seconds).

### Successfully pushed rows by tables (top-50 tables) {sinker.table.rows}
`sinker.table.rows`

50 tables with the maximum number of rows written to the target.

### Read buffer size {publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

The size, in bytes, of the buffer or write ahead log (when supported) in the source.

### Read bytes from source (top-50 workers) {publisher.data.bytes}
`publisher.data.bytes`

The amount of data read from the source (in bytes).

### Sink response time (histogram by seconds) {sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Full time it takes to write a batch to the target, including data preprocessing (in seconds).

### Read rows (parsed/unparsed) {publisher.data.*parsed_rows}
`publisher.data.*parsed_rows`

The number of rows read from the source.

### Snapshot task progress (top-50 tables) {task.snapshot.remainder.table}
`task.snapshot.remainder.table`

The number of rows awaiting transfer.

### Snapshot task status {task.status}
`task.status`

The operation in progress: `0` is replication, `1` is a snapshot.

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the transfer you wish to set up alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select **{{ data-transfer-name }}**.
   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. {% if audience == "external" %}For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).{% endif %}
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

## Recommended alerts

### Number of source events {#source-change-items}

Alert triggering means that the source base generated no replicated {{ data-transfer-name }} events (individual data elements) during the evaluation window.

Possible causes:

* The source base is not available over the network for {{ data-transfer-name }}. For example, due to revoked accesses or a source base failure.
* The source base has no data to replicate.

Alert parameters:

* Metrics:

   ![image](../../_assets/monitoring/chart-lines2.svg) `<cloud name> > <folder name>` `service = data-transfer` `name = publisher.data.changeitems` `resource_type = -`

   ![image](../../_assets/monitoring/function.svg) `derivative()` (in the **Transformation** section)

* Alert settings:

   * Triggering condition: `Less than or equal to`.
   * Alarm: `0`.
   * Warning: `-`.

   You can additionally set the `Warning` triggering condition for the situations when the number of replicated operations is below the expected value.

   Additional settings:

   * **Aggregation function**: `Maximum`.
   * **Evaluation window**: `5 minutes`. If the source base changes less frequently than once every 5 minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

### Number of target events {#target-change-items}

Alert triggering means that the target base recorded no replicated {{ data-transfer-name }} events during the evaluation window.

Possible causes:

* The source or target base is not available over the network for {{ data-transfer-name }}. For example, due to revoked accesses or a source/target base failure.
* The source base has no data to replicate.
* Data from the source base cannot be replicated to the target base. For example, due to target data type limitations in the target base.

Alert parameters:

* Metrics:

   ![image](../../_assets/monitoring/chart-lines2.svg) `<cloud name> > <folder name>` `service = data-transfer` `name = sinker.pusher.data.changeitems` `resource_type = -`
   ![image](../../_assets/monitoring/function.svg) `derivative()` (in the **Transformation** section)

* Alert settings:

   * Triggering condition: `Less than or equal to`.
   * Alarm: `0`.
   * Warning: `-`.

   You can additionally set the `Warning` triggering condition for the situations when the number of replicated operations is below the expected value.

   Additional settings:

   * **Aggregation function**: `Maximum`.
   * **Evaluation window**: `5 minutes`. If the source base changes less frequently than once every 5 minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

### Maximum data transfer delay {#row-max-lag}

Alert triggering means that the time difference between execution of the operation with rows in the source and the target has exceeded the specified threshold during the evaluation window.

Possible causes:

* The target base is not available over the network for {{ data-transfer-name }}. For example, due to revoked accesses or a target base failure.
* Not enough resources for replication. For example, the load on the source database exceeds the capacity of the {% if lang == "ru" and audience != "internal" %}[VM instance](../../glossary/vm.md){% else %}VM instance{% endif %} that {{ data-transfer-name }} replication is running on.
* Data from the source base cannot be replicated to the target base. For example, due to target data type limitations in the target base.

Alert parameters:

* Metrics:

   ![image](../../_assets/monitoring/chart-lines2.svg) `<cloud name> > <folder name>` `service = data-transfer` `name = sinker.pusher.time.row_max_lag_sec` `resource_type = -`

* Alert settings:

   * Triggering condition: `More than or equal to`.
   * Alarm: `15`. If the target base is slow, or large blocks of data are being replicated at a time, set the maximum possible value.
   * Warning: `-`.

   Additional settings:

   * **Aggregation function**: `Minimum`.
   * **Evaluation window**: `1 minute`.

### Reads {#reading}

Alert triggering means that no bytes of data were read from the source during the evaluation window.

Possible causes:

* The source base is not available over the network for {{ data-transfer-name }}. For example, due to revoked accesses or a source base failure.
* The source base has no data to replicate.

Alert parameters:

* Metrics:

   ![image](../../_assets/monitoring/chart-lines2.svg) `<cloud name> > <folder name>` `service = data-transfer` `name = publisher.data.bytes` `resource_type = -`
   ![image](../../_assets/monitoring/function.svg) `derivative()` (in the **Transformation** section)

* Alert settings:

   * Trigger condition: `Equal`.
   * Alarm: `0`.
   * Warning: `-`.

   Additional settings:

   * **Aggregation function**: `Maximum`.
   * **Evaluation window**: `15 minutes`. If the source base changes less frequently than once every 15 minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

## Specifics of working with alerts {#alert-specifics}

* To determine the causes of the transfer failure, check all available alerts. Information about which alerts worked and which did not will enable you to determine the cause more accurately. For example, if alert [{#T}](#source-change-items) is triggered, and alert[{#T}](#target-change-items) is not triggered, the problem is probably not on the source.

{% endif %}