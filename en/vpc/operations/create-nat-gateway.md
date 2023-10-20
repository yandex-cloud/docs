# Setting up a NAT gateway

To create and set up a NAT gateway:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Enter a name for the gateway. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. (Optional) Add a gateway description.
   1. The default gateway type is `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
   1. Click **{{ ui-key.yacloud.common.save }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** to add a new table, or select an existing one.
   1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
   1. In the window that opens, select `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}` in the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field.
   1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will be propagated automatically.
   1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.edit.button_edit }}**.

   Next, link the route table to a subnet to route traffic from it via the NAT gateway:

   1. In the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the required subnet row, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create gateway command:

      ```bash
      yc vpc gateway create --help
      ```

   1. Create a gateway in the default folder:

      ```bash
      yc vpc gateway create \
         --name test-gateway
      ```
   1. Get the gateway ID:

      ```bash
      yc vpc gateway list
      ```

      Command result:

      ```text
      +----------------------+--------------+-------------+
      |          ID          |     NAME     | DESCRIPTION |
      +----------------------+--------------+-------------+
      | enpkq1v2e7p0cmr7e2s0 | test-gateway |             |
      +----------------------+--------------+-------------+
      ```

   1. Create a route table with the gateway as the next hop and the `0.0.0.0/0` destination prefix:

      ```bash
      yc vpc route-table create \
        --name=test-route-table \
        --network-name=<name of the network the table is created in> \
        --route destination=0.0.0.0/0,`
                gateway-id=enpkq1v2e7p0cmr7e2s0
      ```

   1. Link the table to the subnet:

      ```bash
      yc vpc subnet update <subnet name> \
        --route-table-name=test-route-table
      ```

- API

   Use the [create](../api-ref/Gateway/create.md) REST API method for the [Gateway](../api-ref/Gateway/index.md) resource or the [GatewayService/Create](../api-ref/grpc/gateway_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a NAT gateway, specify it as the next hop in the [route](../concepts/static-routes.md) table, and link the table to the subnet, use the following configuration:

   ```hcl
   data "yandex_vpc_network" "net" {
     folder_id = "<folder ID>"
     name      = "<cloud network name>"
   }

   resource "yandex_vpc_subnet" "subnet" {
     folder_id      = "<name of the folder where the subnet is located>"
     name           = "<subnet name>"
     v4_cidr_blocks = "10.20.30.0/24"
     zone           = {{ region-id }}-a
     network_id     = data.yandex_vpc_network.net.id
     route_table_id = yandex_vpc_route_table.rt.id
   }

   resource "yandex_vpc_gateway" "nat_gateway" {
     name = "test-gateway"
     shared_egress_gateway {}
   }

   resource "yandex_vpc_route_table" "rt" {
     name       = test-route-table
     network_id = "<network ID>"

     static_route {
       destination_prefix = "0.0.0.0/0"
       gateway_id         = yandex_vpc_gateway.nat_gateway.id
     }
   }
   ```

{% endlist %}
