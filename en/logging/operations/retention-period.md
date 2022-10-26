# Updating the record retention period

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your [log group](../concepts/log-group.md).
   1. Select **{{ cloud-logging-name }}**.
   1. In the line with the log group, click ![image](../../_assets/horizontal-ellipsis.svg).
   1. In the menu that opens, click **Edit**.
   1. Update the log group record retention period.
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

   Where:

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

- API

   You can edit a log group's record retention period using the API [update](../api-ref/LogGroup/update.md) method.

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To edit the record retention time in a log group created with {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the value of the `retention_period` parameter in the log group description:

      ```hcl
      ...
      resource "yandex_logging_group" "group1" {
        name      = "test-logging-group"
        folder_id = "<folder ID>"
        retention_period = "5h"
      }
      ...
      ```

      Where:

      * `name`: Name of the log group. Optional.
      * `folder_id`: ID of the folder. Optional. By default, the value specified in the provider settings is used.
      * `retention_period`: Record retention period in the log group. Optional. By default, the retention period is 3 days.

      For more detailed information about the parameters of the `yandex_logging_group` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/logging_group).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the log group has been updated in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```
      yc logging group get <log group name>
      ```

{% endlist %}
