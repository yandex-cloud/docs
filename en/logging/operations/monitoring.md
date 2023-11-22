# Viewing log group monitoring charts

You can monitor how records are added to a log group using monitoring tools in the management console. These tools display diagnostic information as charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. Select a log group to view its monitoring charts.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. The following charts will open on the page:
      * **Records successfully ingested**: Number of records delivered to the {{ cloud-logging-name }} system. Only user logs are counted.
      * **Records saved**: Number of records saved to the {{ cloud-logging-name }} system. Service and user logs are counted.
      * **Records read**: Number of records read.
      * **Records ingest errors**: Number of errors when adding records.
      * **Records save lag**: Difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.
      * **Records read errors**: Number of read errors.
      * **Ingest requests**: Number of successful API requests to deliver logs to the system.
      * **Ingest requests errors**: Number of failed API requests to deliver logs to the system.
      * **Ingest requests duration**: Time to execute API requests to deliver logs to the system.

      You can select the period to display information for: an hour, three hours, a day, week, month, or a custom interval.

{% endlist %}