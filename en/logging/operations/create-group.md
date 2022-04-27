# Creating a log group

{% note info %}

Name of the [default log group](../concepts/log-group.md): `default`. The group is automatically created when a service or application writes logs and the folder ID is indicated as the destination. You can manually create a log group with the name `default`. It will then be the default log group for the folder where it was created.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your [log group](../concepts/log-group.md).
   1. Select **{{ cloud-logging-name }}**.
   1. Click **Create group**.
   1. (optional) Enter a name and description for the log group. Name format:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Set the log group record retention period. The maximum record retention period is 3 days, and the minimum is 1 hour.
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

   Where:
   * `--name`: Name of the log group.
   * `--retention-period`: Log group record retention period. Optional. The maximum record retention period is 3 days, the minimum is 1 hour. By default, the retention period is 3 days.

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

   You can create a custom log group using the [create](../api-ref/LogGroup/create.md) API method.

{% endlist %}