---
title: How to create a log group in {{ cloud-logging-name }}
description: In this tutorial, you will learn how to create a log group in {{ cloud-logging-name }}.
---

# Creating a log group

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your [log group](../concepts/log-group.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. (Optional) Enter a name and description for the log group. Use the following name format:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Set the log group record retention period.

    1. (Optional) Select a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) or create a new one to redirect records added to the log group to.


    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a [log group](../concepts/log-group.md), run this command:

    ```
    yc logging group create \
      --name=group \
      --retention-period=1h \
      --data-stream=<stream_ID>
    ```

    Where:
    * `--name`: Log group name.
    * `--retention-period`: Retention period for log group records. This is an optional parameter.

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

    * `--data-stream`: {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) ID. This is an optional parameter. Records added to the log group will be automatically redirected to the specified stream. A stream ID consists of an availability zone, folder ID, {{ ydb-full-name }} database ID, and stream name.

        >For example, your stream ID will appear as `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream` if:
        >* `aws_stream`: Stream name.
        >* `{{ region-id }}`: Availability zone.
        >* `aoeu1kuk2dht********`: Folder ID.
        >* `cc8029jgtuab********`: {{ ydb-full-name }} database ID.


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
    data_stream: /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

     * `name`: [Log group](../concepts/log-group.md) name. This is an optional parameter. Use the following name format:

          {% include [name-format](../../_includes/name-format.md) %}

     * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.

     * `retention_period`: Retention period for log group records. This is an optional parameter.

         {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

     Here is the configuration file example:

     ```hcl
     provider "yandex" {
       token     = "<OAuth_token>"
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_logging_group" "group1" {
       name             = "<log_group_name>"
       folder_id        = "<folder_ID>"
       retention_period = "5h"
     }
     ```

     For more information about the `yandex_logging_group` parameters in {{ TF }}, see the [relevant {{ TF }} article]({{ tf-provider-resources-link }}/logging_group).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. When asked to confirm the changes, type `yes` and press **Enter**.

      {{ TF }} will create your resources in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```
        yc logging group list
        ```

- API {#api}

  To create a [log group](../concepts/log-group.md), use the [create](../api-ref/LogGroup/create.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Create](../api-ref/grpc/LogGroup/create.md) gRPC API call.

  **Request example**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

  Create a file named `payload.json`:

  ```json
  {
     "folder_id": "<folder_ID>",
     "name": "new-group",
     "description": "Description of a log group created using grpcurl",
     "labels": {
       "compute": "instance-logging"
     }
  }
  ```

  Run this request:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d @ \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.Create < payload.json
  ```

  Response:

  ```text
  {
    "id": "e23nitus5cg9********",
    "description": "Create log group",
    "createdAt": "2023-11-23T14:54:23.077532292Z",
    "createdBy": "ajeugsk5ubk6********",
    "modifiedAt": "2023-11-23T14:54:23.077532292Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.logging.v1.CreateLogGroupMetadata",
      "logGroupId": "e23pjn86385t********"
    }
  }
  ```

{% endlist %}
