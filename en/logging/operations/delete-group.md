---
title: "How to delete a log group in {{ cloud-logging-name }}"
description: "In this tutorial, you will learn how to delete a log group in {{ cloud-logging-name }}."
---

# Deleting a log group

{% note info %}

The name of the [default log group](../concepts/log-group.md) is `default`. The group can be deleted. However, if a service or application writes logs and the folder ID is indicated as the destination, it will be automatically recreated.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [log group](../concepts/log-group.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. In the log group row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

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
   created_at: "2023-06-24T09:56:38.970Z"
   name: group
   status: ACTIVE
   retention_period: 3600s
   ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc logging group list
      ```

- API

   To delete a custom log group, use the [delete](../api-ref/LogGroup/delete.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Delete](../api-ref/grpc/log_group_service.md#Delete) gRPC API call.

   
   **Sample request**

   The example below uses the `grpcurl` utility. To use the example, [authenticate](../api-ref/authentication.md) in the API and clone the [cloudapi](https://github.com/yandex-cloud/cloudapi) repository.

   Run the following query:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer $(yc iam create-token)" \
      -d '{"log_group_id": "<log_group_ID>"}' \
      -import-path ~/cloudapi/ \
      -import-path ~/cloudapi/third_party/googleapis/ \
      -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
   logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Delete
   ```

   Response:

   ```text
   {
     "id": "e23omac87b3a********",
     "description": "Delete log group",
     "createdAt": "2023-03-25T05:48:01.626155032Z",
     "createdBy": "ajego134p5h1********",
     "modifiedAt": "2023-03-25T05:48:01.626155032Z",
     "metadata": {
       "@type": "type.googleapis.com/yandex.cloud.logging.v1.DeleteLogGroupMetadata",
       "logGroupId": "e23ff0on5amv********"
     }
   }
   ```


{% endlist %}
