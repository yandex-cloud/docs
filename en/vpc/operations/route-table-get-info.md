---
title: "Getting information about a route table in {{ vpc-full-name }}"
---

# Getting information about a route table

{% list tabs %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [route table](../concepts/static-routes.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.switch_route-tables }}**.
   1. Select the route table you need.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the route table.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command to get information about a [route table](../concepts/static-routes.md):

      ```bash
      yc vpc route-table get --help
      ```

   1. Get information about your route table by specifying its name or ID:

      ```bash
      yc vpc route-table get <route_table_name>
      ```

      Result:

      ```text
      id: enpmgov0n4ah********
      folder_id: b1go3el0d8fs********
      created_at: "2023-09-20T13:56:58Z"
      name: my-routing
      network_id: enpols3n07b8********
      static_routes:
        - destination_prefix: 0.0.0.0/0
          gateway_id: enpkq1ujbgrs********
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [route table](../concepts/static-routes.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_vpc_route_table" "my-rt" {
        route_table_id = "<route_table_ID>"
      }

      output "route-table" {
        value = data.yandex_vpc_route_table.my-rt.static_route
      }
      ```

      Where:
      * `data "yandex_vpc_route_table"`: Description of the route table as a data source:
         * `route_table_id`: Route table ID.
      * `output "route-table"`: Output variable that contains information about static routes of the route table:
         * `value`: Returned value.

      You can replace `static_route` with any other parameter to get the information you need. For more information about the `yandex_vpc_route_table` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_vpc_route_table).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      route-table = toset([
        {
          "destination_prefix" = "0.0.0.0/0"
          "gateway_id" = "enpkq1ujbgrs********"
          "next_hop_address" = ""
        },
      ])
      ```

- API {#api}

   To get detailed information about a [route table](../concepts/static-routes.md), use the [get](../api-ref/RouteTable/get.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Get](../api-ref/grpc/route_table_service.md#Get) gRPC API call.

{% endlist %}