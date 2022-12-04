# Monitoring in {{ cloud-logging-name }}

You can monitor how records are added to a log group using monitoring tools in the management console. These tools display diagnostic information in the form of charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
   1. Select **{{ cloud-logging-name }}**.
   1. Select a log group to view its monitoring charts.
   1. Go to the **Monitoring** tab.
   1. The following charts open on the page:
      * **Records successfully ingested**: The number of records delivered to the {{ cloud-logging-name }} system. Only user logs are counted.
      * **Records saved**: The number of records saved to the {{ cloud-logging-name }} system. Service and user logs are counted.
      * **Records read**: The number of records read.
      * **Records ingest errors**: The number of errors when adding records.
      * **Records save lag**: The difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.
      * **Records read errors**: Number of read errors.
      * **Ingest requests**: Number of successful API requests to deliver logs to the system.
      * **Ingest requests errors**: Number of failed API requests to deliver logs to the system.
      * **Ingest requests duration**: Time to execute API requests to deliver logs to the system.

      You can select the period to display information for: an hour, three hours, a day, week, month, or a custom interval.

{% endlist %}