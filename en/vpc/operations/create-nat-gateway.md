# Setting up a NAT gateway

To create and set up a NAT gateway:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a gateway.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select **Gateways**.
   1. Click **Create**.
   1. Enter a name for the gateway:

      {% include [name-format](../../_includes/name-format.md) %}

   1. (optional) Add a gateway description.
   1. The default gateway type is **NAT gateway**.
   1. Click **Create**.
   1. On the left-hand panel, select **Route tables**.
   1. Click **Create** to create a new table or select an existing one.
   1. Click **Add route**.
   1. In the window that opens, select **Gateway** in the **Next hop** field.
   1. In the **Gateway** field, select the NAT gateway you created. The destination prefix is set automatically.
   1. Click **Add**.
   1. Click **Save**.

   Next, link the route table to a subnet to route traffic from it via the NAT gateway:

   1. On the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
   1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **Link route table**.
   1. In the window that opens, select the created table from the list.
   1. Click **Link**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create gateway command:

      ```
      yc vpc gateway create --help
      ```

   1. Create a gateway in the default folder:

      ```
      yc vpc gateway create --name test-gateway
      ```
   1. Get the gateway ID:

      ```
      yc vpc gateway list
      ```

      Command result:

      ```
      +----------------------+--------------+-------------+
      |          ID          |     NAME     | DESCRIPTION |
      +----------------------+--------------+-------------+
      | enpkq1v2e7p0cmr7e2s0 | test-gateway |             |
      +----------------------+--------------+-------------+
      ```

   1. Create a route table with the gateway as the next hop and the `0.0.0.0/0` destination prefix:

      ```
      yc vpc route-table create --name=test-route-table --network-name=<name of the network the table is created in> --route destination=0.0.0.0/0,gateway-id=enpkq1v2e7p0cmr7e2s0
      ```

   1. Link the table to the subnet:

      ```
      yc vpc subnet update <subnet name> --route-table-name=test-route-table

      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a NAT gateway, specify it as the next hop in the [route](../concepts/static-routes.md) table, and link the table to the subnet, use the following configuration:

   ```
   data "yandex_vpc_network" "net" {
     folder_id = "<folder ID>"
     name      = "<cloud network name>"
   }

   resource "yandex_vpc_subnet" "subnet" {
     folder_id      = "<name of the folder where the subnet is located>"
     name           = "<subnet name>"
     v4_cidr_blocks = "10.20.30.0/24"
     zone           = ru-central1-a
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
