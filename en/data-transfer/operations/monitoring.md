# Monitoring transfer status

Transfer status details are available in the management console:

* You can find the summary on the timeline in the **{{ ui-key.yacloud.common.overview }}** section for the selected transfer in [{{ data-transfer-name }}]({{ link-console-main }}/link/data-transfer/). At the top right of the timeline, you can select the viewing interval: hour, day, or week. The interval is segmented. Hover the cursor over the segment to find out how many bytes and rows were transferred over the relevant period or to view error messages.
* Detailed diagnostic information is presented as charts. You can view them on the **{{ ui-key.yacloud.data-transfer.label_monitoring }}** tab of the transfer management page or in [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about transfer failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you will receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).


You can also use the {{ yandex-cloud }} [mobile app](/mobile-app) to monitor transfer statuses and get their logs.



## Monitoring the transfer status {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click the name of the transfer you need and open the ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.data-transfer.label_monitoring }}** tab.
   1. To get started with {{ monitoring-full-name }} metrics, dashboards, or alerts, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** in the top panel.

{% endlist %}

The following charts open on the page:

### Number of source events {#publisher.data.changeitems}
`publisher.data.changeitems`

Number of source events generated for a transfer (apart from the data to transfer, these events may include housekeeping operations).

### Number of target events {#sinker.pusher.data.changeitems}
`sinker.pusher.data.changeitems`

Number of events written to the target (apart from the data to transfer, these events may include housekeeping operations).

### Maximum data transfer delay {#sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Maximum data lag (in seconds).

### Reads {#publisher.data.bytes}
`publisher.data.bytes`

The amount of data read from the source (in bytes).

### Data transfer delay {#sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

Time difference between when the records appear on the target and when they appear on the source (in seconds). The histogram is divided into `bins`. Let us assume, the histogram is showing two `bins` for 45 and 60 at a given point in time, with each containing a value equal to 50%. This means that half the records being transferred at the time had a delay of between 30 and 45 seconds, and the other half of between 45 and 60 seconds.

### Source buffer size {#publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

The size, in bytes, of the buffer or write ahead log (when supported) in the source.

### Rows written to target, by table {#sinker.table.rows}
`sinker.table.rows`

50 tables with the maximum number of rows written to the target.

### Target response time {#sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Full time it takes to write a batch to the target, including data preprocessing (in seconds).

### Rows awaiting transfer, by table {#task.snapshot.remainder.table}
`task.snapshot.remainder.table`

The number of rows awaiting transfer.

### Operation status {#task.status}
`task.status`

Type of the operation in progress: `1`, meaning the task is active.


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the transfer you want to set up alerts for.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select **{{ ui-key.yacloud.iam.folder.dashboard.value_data-transfer }}**.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If there are multiple metrics on a chart, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

## Recommended alerts

### Number of source events {#source-change-items}

Alert triggering means that the source base generated no replicated {{ data-transfer-name }} events (individual data elements) during the evaluation window.

Possible causes include:

* The source base is not available over the network for {{ data-transfer-name }}, e.g., due to revoked accesses or a source base failure.
* The source base has no data to replicate.

Alert parameters:

* Metrics:

   ![image](../../_assets/console-icons/chart-line.svg) `<cloud_name> > <folder_name>` `service = data-transfer` `name = publisher.data.changeitems`

   ![image](../../_assets/console-icons/function.svg) `derivative()` (in the **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}** section)

* Alert settings:

   * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}: `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}: `0`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}: `-`

   You can additionally set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` triggering condition for the situations when the number of replicated operations is below the expected value.

   Additional settings:

   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}**: `5 minutes`. If the source database changes less frequently than once every five minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

### Number of target events {#target-change-items}

When an alert is triggered, it means that the target database recorded no replicated {{ data-transfer-name }} events during the evaluation window.

Possible causes include:

* The source or target base is not available over the network for {{ data-transfer-name }}, e.g., due to revoked accesses or a source/target base failure.
* The source base has no data to replicate.
* The data from the source database cannot be replicated to the target one, e.g., due to the target data type limitations in the target database.

Alert parameters:

* Metrics:

   ![image](../../_assets/console-icons/chart-line.svg) `<cloud_name> > <folder_name>` `service = data-transfer` `name = sinker.pusher.data.changeitems`
   ![image](../../_assets/console-icons/function.svg) `derivative()` (in the **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}** section)

* Alert settings:

   * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}: `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}: `0`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}: `-`

   You can additionally set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` triggering condition for the situations when the number of replicated operations is below the expected value.

   Additional settings:

   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}**: `5 minutes`. If the source database changes less frequently than once every five minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

### Maximum data transfer delay {#row-max-lag}

Alert triggering means that the time difference between execution of the operation with rows in the source and the target has exceeded the specified threshold during the evaluation window.

Possible causes include:

* The target database is not available over the network for {{ data-transfer-name }}, e.g., due to revoked accesses or a target database failure.
* Not enough resources for replication. For example, the load on the source database exceeds the capacity of the VM instance the {{ data-transfer-name }} replication is running on.
* The data from the source database cannot be replicated to the target one, e.g., due to the target data type limitations in the target database.

Alert parameters:

* Metrics:

   ![image](../../_assets/console-icons/chart-line.svg) `<cloud_name> > <folder_name>` `service = data-transfer` `name = sinker.pusher.time.row_max_lag_sec`

* Alert settings:

   * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}`.
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}: `15`. If the target database is slow, or large blocks of data are being replicated at a time, set the maximum possible value.
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}: `-`.

   Additional settings:

   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}`.
   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}**: `1 minute`.

### Reads {#reading}

Alert triggering means that no bytes of data were read from the source during the evaluation window.

Possible causes include:

* The source base is not available over the network for {{ data-transfer-name }}, e.g., due to revoked accesses or a source base failure.
* The source base has no data to replicate.

Alert parameters:

* Metrics:

   ![image](../../_assets/console-icons/chart-line.svg) `<cloud_name> > <folder_name>` `service = data-transfer` `name = publisher.data.bytes`
   ![image](../../_assets/console-icons/function.svg) `derivative()` (in the **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}** section)

* Alert settings:

   * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}: `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}: `0`
   * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}: `-`

   Additional settings:

   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
   * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}**: `15 minutes`. If the source database changes less frequently than once every 15 minutes, increase the evaluation window to the maximum allowable interval between two DML operations with data in the source.

## Specifics of working with alerts {#alert-specifics}

* To determine the causes of the transfer failure, check all available alerts. Information about which alerts worked and which did not will enable you to determine the cause more accurately. For example, if the [{#T}](#source-change-items) alert is fired, and the [{#T}](#target-change-items) alert is not fired, the problem is probably not on the source.
