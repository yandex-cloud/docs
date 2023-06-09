---
title: "How to create a log group in {{ cloud-logging-name }}"
description: "In this tutorial, you will learn how to create a log group in {{ cloud-logging-name }}."
---

# Creating a log group

{% note info %}

Name of the [default log group](../concepts/log-group.md): `default`. The group is automatically created when a service or application writes logs and the folder ID is indicated as the destination. You can manually create a log group with the name `default`. It will then be the default log group for the folder where it was created.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your [log group](../concepts/log-group.md).
   1. Select **{{ cloud-logging-name }}**.
   1. Click **Create group**.
   1. (optional) Enter a name and description for the log group using the following format:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Set the log group record retention period.
   1. Click **Create group**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a log group, run the command:

   
   ```
   yc logging group create \
     --name=group \
     --retention-period=1h \
     --data-stream=<stream_ID>
   ```



   Where:
   * `--name`: Name of the log group.
   * `--retention-period`: Log group record retention period. This is an optional parameter.

      {% include [retention-period](../../_includes/logging/retention-period.md) %}

      {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

   
   * `data-stream`: {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) ID. This is an optional parameter. Records added to the log group will be automatically redirected to the specified stream. A stream ID consists of an availability zone, folder ID, {{ ydb-full-name }} database ID, and stream name.

      > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
      > * `aws_stream`: Stream name.
      > * `{{ region-id }}`: Availability zone.
      > * `aoeu1kuk2dhtaupdb1es`: Folder ID.
      > * `cc8029jgtuabequtgtbv`: {{ ydb-full-name }} database ID.


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
   data_stream: /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
   ```


- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Name of the log group. This is an optional parameter. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.

      * `retention_period`: Record retention period in the log group. This is an optional parameter.

         {% include [retention-period](../../_includes/logging/retention-period.md) %}

         {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

      Example of the configuration file structure:

      
      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_logging_group" "group1" {
        name      = "<log group name>"
        folder_id = "<folder ID>"
        retention_period = "5h"
      }
      ```



      For more detailed information about the `yandex_logging_group` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/logging_group).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc logging group list
      ```

- API

   To create a log group, use the [create](../api-ref/LogGroup/create.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Create](../api-ref/grpc/log_group_service.md#Create) gRPC API call.

{% endlist %}
