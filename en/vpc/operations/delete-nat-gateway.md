# Deleting a NAT gateway

If you no longer need a NAT gateway, you can [delete it](#delete-nat-gateway). Before deleting a NAT gateway, [detach it](#unlink-nat-gateway) from all route tables that use it.

## Detaching a NAT gateway from a route table {#unlink-nat-gateway}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to detach a NAT gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. In the list that opens, find the route table with the NAT gateway listed in its **Static routes** column.
   1. In the line with the appropriate table, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Edit**.
   1. In the window that opens, click ![image](../../_assets/console-icons/xmark.svg) in the line with the NAT gateway name.
   1. Click **Save**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To detach a NAT gateway from a route table:

   1. View the description of the CLI command for editing a route table:

      ```bash
      yc vpc route-table update --help
      ```

   1. Get the name or ID of the route table the NAT gateway is attached to:

      ```bash
      yc vpc route-table list
      ```
      Result:
      ```text
      +----------------------+----------------------+-------------+----------------------+
      |          ID          |         NAME         | DESCRIPTION |      NETWORK-ID      |
      +----------------------+----------------------+-------------+----------------------+
      | enpcaaqahk3c******** | test-table           |             | enptgj64mv2r******** |
      +----------------------+----------------------+-------------+----------------------+
      ```

   1. Detach the NAT gateway:
      ```bash
      yc vpc route-table update <route_table_name_or_ID> --clear-routes
      ```
      Use either the `--id` or `--name` parameter.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   To detach a NAT gateway from a route table created using {{ TF }}:

   1. Open the {{ TF }} configuration file and find the section with the description of the route table the NAT gateway is attached to:

      {% cut "Example of a table description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_vpc_route_table" "routetable" {
        folder_id  = "<user_folder_ID>"
        name       = "<route_table_name>"
        network_id = "<network_ID>"
        static_route {
          destination_prefix = "0.0.0.0/0"
          gateway_id         = <gateway_ID>
        }
      }
      ...
      ```

      {% endcut %}

   1. Delete the `static_route` object.

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

      ```bash
      yc vpc route-table get <route_table_name_or_ID>
      ```
      Use either the `--id` or `--name` parameter.

- API {#api}

   To detach a NAT gateway from a route table, delete the static route with that NAT gateway from the route table. To do this, use the [update](../api-ref/RouteTable/update.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Update](../api-ref/grpc/route_table_service.md#Update) gRPC API call. In your request, provide a list of static routes without the route you want to delete under:
   * `staticRoutes` for REST API
   * `static_routes` for gRPC API

   If the list contained a single static route, provide an empty list.

   To get a list of static routes, use the [get](../api-ref/RouteTable/get.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Get](../api-ref/grpc/route_table_service.md#Get) gRPC API call. In your request, provide the route table ID in this parameter:
   * `routeTableId` for REST API
   * `route_table_id` for gRPC API

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a NAT gateway {#delete-nat-gateway}

{% note warning %}

Before deleting a NAT gateway, [detach it](#unlink-route-table) from all route tables it is attached to.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a NAT gateway:
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a NAT gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/gateways.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the line with the appropriate NAT gateway name and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a route table:

   1. View the description of the CLI command for deleting a NAT gateway:

      ```bash
      yc vpc gateway delete --help
      ```

   1. Get the name or ID of the NAT gateway to delete:

      ```bash
      yc vpc gateway list
      ```
      Result:
      ```text
      +----------------------+-----------+-------------+
      |          ID          |   NAME    | DESCRIPTION |
      +----------------------+-----------+-------------+
      | enpkq171u4gb******** | gateway-1 |             |
      +----------------------+-----------+-------------+
      ```
   1. Delete the NAT gateway:
      ```bash
      yc vpc gateway delete <gateway_name_or_ID>
      ```
      Use either the `--id` or `--name` parameter.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   To delete a NAT gateway created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the section with the NAT gateway description.

      {% cut "Example of a NAT gateway description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_vpc_gateway" "natgateway" {
        folder_id      = "<folder_ID>"
        name = "<gateway_name>"
        shared_egress_gateway {}
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc vpc gateway list
      ```

- API {#api}

   To delete a NAT gateway, use the [delete](../api-ref/Gateway/delete.md) REST API method for the [Gateway](../api-ref/Gateway/index.md) resource or the [GatewayService/Delete](../api-ref/grpc/gateway_service.md#Delete) gRPC API call. In your request, provide the ID of the NAT gateway you want to delete in this parameter:
   * `gatewayId` for REST API
   * `gateway_id` for gRPC API

   To get the NAT gateway ID, use the [list](../api-ref/Gateway/list.md) REST API method for the [Gateway](../api-ref/Gateway/index.md) resource or the [GatewayService/List](../api-ref/grpc/gateway_service.md#List) gRPC API call. In your request, provide the folder ID in this parameter:
   * `folderId` for REST API
   * `folder_id` for gRPC API

{% endlist %}
