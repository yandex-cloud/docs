---
title: How to delete a log group in {{ cloud-logging-name }}
description: In this guide, you will learn how to delete a log group in {{ cloud-logging-name }}.
sourcePath: en/logging_includes/operations/delete-group.md
---

# Deleting a log group

{% note info %}

The name of the [default log group](../concepts/log-group.md) is `default`. You can delete it. However, the system will automatically recreate it if a service or application writes logs targeting the folder ID.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [log group](../concepts/log-group.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Next to the log group, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To access a log group, use its name or unique ID. To find them out, [get](./list.md) a list of log groups in the folder.

    To delete a log group, run this command:

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a log group created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section describing the log group.
     
     {% cut "Example of a log group description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_logging_group" "group1" {
       name      = "test-logging-group"
       folder_id = "${data.yandex_resourcemanager_folder.test_folder.id}"
     }
     ...
     ```

     {% endcut %}

  1. In the command line, navigate to the directory with the {{ TF }} configuration file.

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
  
     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.

  1. Apply the changes:

     ```
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm changes.

     You can check updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc logging group list
     ```

- API {#api}

  To delete a custom log group, use the [delete](../api-ref/LogGroup/delete.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Delete](../api-ref/grpc/LogGroup/delete.md) gRPC API call.

  **Request example**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

  Run this query:
  
  ```bash
  grpcurl -rpc-header "Authorization: Bearer $(yc iam create-token)" \
     -d '{"log_group_id": "<log_group_ID>"}' \
     -import-path ~/cloudapi/ \
     -import-path ~/cloudapi/third_party/googleapis/ \
     -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.Delete
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