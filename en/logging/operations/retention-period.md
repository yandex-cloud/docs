# Updating the record retention period

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the [log group](../concepts/log-group.md) is located.
  1. Open **{{ cloud-logging-name }}**.
  1. In the line with the log group, click ![image](../../_assets/horizontal-ellipsis.svg).
  1. In the menu that opens, click **Edit**.
  1. Update the log group record retention period. The maximum retention period is 7 days and the minimum is 1 hour.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To access a log group, use its name or unique ID. To find them, [get](./list.md) a list of log groups in the folder.

  {% note info %}

  The record retention period can only be specified in hours, minutes, or seconds. For example, `1h` or `1440m`.

  {% endnote %}

  To update the period for retaining records in a [log group](../concepts/log-group.md), run the command:

  ```
  yc logging group update --name=default --retention-period=24h
  ```

  * `--name`: Name of the log group whose record retention period you want to update.
  * `--retention-period`: New record retention period.

  Result:

  ```
  id: af3mu6hnd0**********
  folder_id: aoek6qrs8t**********
  cloud_id: aoegtvhtp8**********
  created_at: "2021-06-22T09:51:43.614Z"
  name: default
  status: ACTIVE
  retention_period: 86400s
  ```

{% endlist %}
