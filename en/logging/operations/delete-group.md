# Deleting a group

{% note info %}

Name of the [default log group](../concepts/log-group.md): `default`. The group can be deleted. However, if a service or application writes logs and the folder ID is indicated as the destination, it will be automatically re-created.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to delete a [log group](../concepts/log-group.md).
   1. Select **{{ cloud-logging-name }}**.
   1. In the log group's line, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To access a log group, use its name or unique ID. To find them, [get](./list.md) a list of log groups in the folder.

   To delete a log group, run the command:

   ```
   yc logging group delete --name=group
   ```

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

   You can [delete](../api-ref/LogGroup/delete.md) a custom log group using the delete API method.

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a log group created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the section with the log group description.

      {% cut "Example log group description in {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_logging_group" "group1" {
        name      = "test-logging-group"
        folder_id = "${data.yandex_resourcemanager_folder.test_folder.id}"
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc logging group list
      ```

{% endlist %}
