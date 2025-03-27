---
title: How to get information about a bus
description: Follow this guide to get information about a {{ er-full-name }} bus.
---

# Getting information about a bus

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select a bus. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the bus.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view information about a [bus](../../../concepts/eventrouter/bus.md):

     ```bash
     yc serverless eventrouter bus get --help
     ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}

  1. Get detailed information about a bus by specifying its name or ID:

     ```bash
     yc serverless eventrouter bus get <bus_ID>
     ```

     Result:

     ```text
     id: f66ngs9760f1********
     folder_id: b1go3el0d8fs********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-18T13:23:45.126870Z"
     name: my-bus
     status: ACTIVE
     ```

- {{ TF }}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  1. Add the `data` and `output` sections to the Terraform configuration file:

      ```hcl
      data "yandex_serverless_eventrouter_bus" "my-bus" {
        bus_id = "<bus_ID>"
      }

      output "bus-folder" {
        value = data.yandex_serverless_eventrouter_bus.my-bus.folder_id
      }
      ```

      Where:

      * `data "yandex_serverless_eventrouter_bus"`: Description of the bus as a data source:
         * `resource_id`: Bus ID.
      * `output "bus-folder"`: Output variable with information about the folder housing the bus (`folder_id`):
         * `value`: Returned value.

     You can replace `folder_id` with any other parameter to get the information you need. For more information about the `yandex_serverless_eventrouter_bus` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/serverless_eventrouter_bus).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      bus-folder = "b1geoelk7fld********"
      ```

- API {#api}

  To get detailed information about a [bus](../../../concepts/eventrouter/bus.md), use the [get](../../../../serverless-integrations/eventrouter/api-ref/Bus/get.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/get.md) gRPC API call.

{% endlist %}