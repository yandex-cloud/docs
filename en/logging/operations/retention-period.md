---
title: Updating a log group
description: Follow this guide to update a log group.
---

# Updating a log group

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your [log group](../concepts/log-group.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Next to the log group, click ![image](../../_assets/console-icons/ellipsis.svg).
    1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
    1. Update the log group settings.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To access a log group, use its name or unique ID. To find them out, [get](./list.md) a list of log groups in the folder.

    To update [log group](../concepts/log-group.md) settings, such as the record retention period, run this command:

    ```
    yc logging group update --name=default --retention-period=24h
    ```

    Where:

    * `--name`: Name of the log group whose record retention period you want to update.
    * `--retention-period`: New retention period for log group records.

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

    Result:

    ```
    id: af3mu6hnd0**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2023-06-22T09:51:43.614Z"
    name: default
    status: ACTIVE
    retention_period: 86400s
    ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To update the settings of a [log group](../concepts/log-group.md) created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the setting, such as the record retention period, in the log group description as needed:

     ```hcl
     ...
     resource "yandex_logging_group" "group1" {
       name             = "test-logging-group"
       folder_id        = "<folder_ID>"
       retention_period = "5h"
     }
     ...
     ```

     Where:

     * `name`: Log group name. This is an optional setting.
     * `folder_id`: Folder ID. This is an optional setting. It defaults to the value defined by the provider.
     * `retention_period`: New retention period for log group records.

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

     For more information about the `yandex_logging_group` settings, see [this {{ TF }} article]({{ tf-provider-resources-link }}/logging_group).

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
  
     You will see a detailed list of resources. No changes will be made at this step. {{ TF }} will show any errors found in the configuration.

  1. Apply the changes:

     ```
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

     You can check the log group update in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc logging group get <log_group_name>
     ```

- API {#api}

  To update a log group, use the [update](../api-ref/LogGroup/update.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Update](../api-ref/grpc/LogGroup/update.md) gRPC API call.

  **Request example**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

  In our example, we are updating the record retention period.
  
  Create a file named `payload.json`:

  ```json
  {
     "log_group_id": "<log_group_ID>",
     "retention_period": "24h",
     "update_mask": {
        "paths": ["retention_period"]
     }
  }
  ```

  Send this request:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d @ \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.Update < payload.json
  ```

  Response:

  ```text
  {
    "id": "e23omac87b3a********",
    "description": "Update log group",
    "createdAt": "2023-03-25T05:39:24.058608338Z",
    "createdBy": "ajego134p5h1********",
    "modifiedAt": "2023-03-25T05:39:24.058608338Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.logging.v1.UpdateLogGroupMetadata",
      "logGroupId": "e23ff0on5amv********"
    }
  }
  ```

{% endlist %}