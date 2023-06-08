# Set up logging and analyze performance

The guide in this checklist item will help you set up operations with logs and analyze performance.

## Create a log group {#log-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your [log group](../../logging/concepts/log-group.md).
   1. Open **{{ cloud-logging-name }}**.
   1. Click **Create group**.
   1. (optional) Enter a name and description for the log group using the following format:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Set the log group record retention period. The maximum record retention period is 3 days, the minimum is 1 hour.
   1. Click **Create group**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% note info %}

   The record retention period can only be specified in hours, minutes, or seconds. For example, `1h` or `1440m`.

   {% endnote %}

   To create a log group, run the command:

   ```
   yc logging group create --name=group --retention-period=1h
   ```

   * `--name`: Name of the log group.
   * `--retention-period`: Log group record retention period. This is an optional parameter. The maximum record retention period is 3 days, the minimum is 1 hour. By default, the retention period is 3 days.

   Result:

   ```
   done (1s)
   id: af3flf29t8**********
   folder_id: aoek6qrs8t**********
   cloud_id: aoegtvhtp8**********
   created_at: "2021-06-24T09:56:38.970Z"
   name: group
   status: ACTIVE
   retention_period: 3600s
   ```

- API

   You can create a custom log group using the [create](../../logging/api-ref/LogGroup/create.md) API method.

{% endlist %}

## View charts

1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
1. Open **{{ cloud-logging-name }}**.
1. Select a log group.
1. Go to the **Monitoring** tab.
1. The following charts open on the page:
* **Records successfully ingested**: The number of records delivered to the {{ cloud-logging-name }} system. Only user logs are counted.
* **Records saved**: The number of records saved to the {{ cloud-logging-name }} system. Service and user logs are counted.
* **Records read**: The number of records read.
* **Records ingest errors**: The number of errors when adding records.
* **Records save lag**: The difference between the time of record delivery and its saving to the {{ cloud-logging-name }} system.

