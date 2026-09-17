# Monitoring event logging to a log group

Monitoring specific log group metrics helps you spot potential issues early and prevent data loss.

Each log group includes predefined monitoring charts with the following information:

* **Records**: Group of charts showing record processing:
  * **Records successfully ingested**: Number of successfully ingested records.
  * **Records saved**: Number of saved records.
  * **Records read**: Number of read records.
  * **Records ingest errors**: Number of record ingestion errors.
  * **Records save lag**: Delay between ingesting and saving records.
  * **Records read errors**: Number of record read errors.

* **Requests**: Group of charts for data ingestion requests:
  * **Ingest requests**: Number of data ingestion requests.
  * **Ingest requests errors**: Number of data ingestion request errors.
  * **Ingest requests duration**: Average duration of data ingestion requests.

To monitor log group metrics along with other relevant indicators, e.g., [{{ at-name }}](../../audit-trails/tutorials/alerts-monitoring.md) events, display all of them on a single {{ monitoring-name }} dashboard.

Add a chart for the `group.service.ingested_records_per_second` [metric](../../monitoring/metrics-ref/logging-ref.md) to the dashboard to display the actual rate of log ingestion into the log group. Comparing this value with the `Maximum write speed` [quota](../../logging/concepts/limits.md#logging-quotas) helps determine whether the log stream is hitting its limit. The additional `group.service.ingest_requests_per_second` chart filtered by `ERROR` status enables detecting write errors promptly.

{% list tabs group=instructions %}

- {{ monitoring-short-name }} UI {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. On the right side of the dashboard row, click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.component.entities-list.action_edit }}**.
  1. In the top-right corner, click ![image](../../_assets/console-icons/plus.svg) → ![image](../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
  1. Create a query to monitor storage usage:

      1. In the query editor, select the following in the ![image](../../_assets/monitoring/chart.svg) **{{ ui-key.yacloud_monitoring.querystring.tokens.placeholder.service }}** line:
          * `service` → `logging`.
          * `name` → `group.service.ingested_records_per_second`.
          * `group` → log group you want to create a chart for.
      
  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and follow the same steps to create a query to show the maximum bucket size:
      * `name` → `group.ingest_requests_per_second`.
      * `level` → `ERROR`.
  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** to check the chart display.
  1. Name the chart and add a threshold:

      1. In the chart area, click ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.wizard.settings }}**.
      1. In the panel that opens, expand **{{ ui-key.yacloud_monitoring.wizard.tab.general }}**.
      1. In the **{{ ui-key.yacloud_monitoring.wizard.general.name }}** field, specify a chart name, e.g., `Bucket Used Space`.
      1. Expand **{{ ui-key.yacloud_monitoring.wizard.tab.thresholds }}**.
      1. Click **{{ ui-key.yacloud_monitoring.wizard.thresholds.add }}**.
      1. Specify `Maximum write speed quota` for the threshold name and select a color.
      1. Close the chart settings panel.

  1. At the top right, click ![image](../../_assets/console-icons/floppy-disk.svg).

{% endlist %}