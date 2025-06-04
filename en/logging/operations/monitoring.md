# Viewing log group monitoring charts

You can monitor how records are added to a log group with the monitoring tools in the management console. These tools display diagnostic information as charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the log group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group whose monitoring charts you want to view.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. The following charts will appear on the page:
      * **Records successfully ingested**: Number of records delivered to the {{ cloud-logging-name }} system. This only includes user logs.
      * **Records saved**: Number of records saved to the {{ cloud-logging-name }} system. This includes both service and user logs.
      * **Records read**: Number of records read.
      * **Records ingest errors**: Number of errors when adding records.
      * **Records save lag**: Difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.
      * **Records read errors**: Number of read errors.
      * **Ingest requests**: Number of successful API requests to deliver logs to the system.
      * **Ingest requests errors**: Number of failed API requests to deliver logs to the system.
      * **Ingest requests duration**: Duration of API requests to deliver logs to the system.

      You can select a time period for which you want to display information on the graph. It can be an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}