# Monitoring

You can monitor how records are added to a log group using monitoring tools in the management console. These tools display diagnostic information in the form of charts.

The chart update period is 15 seconds.

## Viewing charts

1. In the [management console]({{ link-console-main }}), go to the folder where the log group is located.
1. Open **{{ cloud-logging-name }}**.
1. Select a log group.
1. Go to the **Monitoring** tab.
1. The following charts open on the page:
	* **Records successfully ingested**: The number of records delivered to the {{ cloud-logging-name }} system. Only user logs are counted.
	* **Records saved**: The number of records saved to the {{ cloud-logging-name }} system. Service and user logs are counted.
	* **Records read**: The number of records read.
	* **Records ingest errors**: The number of errors when adding records.
	* **Records save lag**: The difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.
