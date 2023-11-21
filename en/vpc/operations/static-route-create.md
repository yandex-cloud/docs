---
title: "How to create static routes {{ vpc-short-name }}"
description: "The default static route (0.0.0.0/0) is used for VMs with public IPs. If you need to create a NAT instance, create it in a separate subnet. To create a route table and add static routes to it, open the {{ vpc-name }} section in the folder to create a static route in. Select the network to create the route table in. Click Create route table."
---

# Creating static routes

{% note info %}

The default static route (`0.0.0.0/0`) is used for VMs with public IPs. If you need to [create a NAT instance](../../tutorials/routing/nat-instance.md), create it in a separate subnet.

{% endnote %}

{% list tabs %}

- Management console

   To create a route table and add [static routes](../concepts/static-routes.md):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a static route.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Enter a name for the route table. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. (Optional) Add a description of a route table.
   1. Select the network to create the route table in.
   1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
   1. In the window that opens, enter the prefix of the destination subnet in CIDR notation.
   1. Specify the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}**, which is an IP address from the [allowed ranges](../concepts/network.md#subnet).
   1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

   To use static routes, link the route table to a subnet:

   1. In the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the required subnet row, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- CLI

   To create a route table and add [static routes](../concepts/static-routes.md):
   1. View a description of the CLI command for creating routing tables:

      ```
      yc vpc route-table create --help
      ```

   1. Get the IDs of cloud networks in your cloud:

      ```
      yc vpc network list
      ```

      Result:
      ```
      +----------------------+-----------------+
      |          ID          |      NAME       |
      +----------------------+-----------------+
      | enp34hbpj8dqebn3621l | yc-auto-subnet  |
      | enp846vf5fus0nt3lu83 | routes-test     |
      +----------------------+-----------------+
      ```

   1. Create a route table in one of the networks:

      ```
      yc vpc route-table create \
        --name=test-route-table \
        --network-id=enp846vf5fus0nt3lu83 \
        --route destination=0.0.0.0/0,next-hop=192.168.1.5
      ```

      Where:

      * `name`: Name of the route table.
      * `network-id`: ID of the network where the table will be created.
      * `route`: Route settings with two parameters:
         * `destination`: Destination subnet prefix in CIDR notation.
         * `next-hop`: Internal IP address of the VM from the [allowed ranges](../concepts/network.md#subnet) the traffic will be sent through.

      Result:
      ```
      ...done
      id: enpsi6b08q2vfdmppsnb
      folder_id: b1gqs1teo2q2a4vnmi2t
      created_at: "2019-06-24T09:57:54Z"
      name: test-route-table
      network_id: enp846vf5fus0nt3lu83
      static_routes:
      - destination_prefix: 0.0.0.0/0
        next_hop_address: 192.168.1.5
      ```

   To use static routes, link the route table to a subnet:

   1. Get a list of subnets in your cloud:

      ```
      yc vpc subnet list
      ```

      Result:
      ```
      +----------------------+------------------+----------------------+----------------+---------------+------------------+
      |          ID          |       NAME       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+------------------+----------------------+----------------+---------------+------------------+
      | b0cf2b0u7nhl75gp1c9t | subnet-1         | enp846vf5fus0nt3lu83 |                | {{ region-id }}-a | [192.168.0.0/24] |
      | e2llnffvbakqu18hr170 | subnet-2         | enp846vf5fus0nt3lu83 |                | {{ region-id }}-b | [192.168.1.0/24] |
      +----------------------+------------------+----------------------+----------------+---------------+------------------+
      ```

   1. Link the routing table to one of the subnets:

      ```
      yc vpc subnet update b0cf2b0u7nhl75gp1c9t --route-table-id enp1sdveovdpdhaao5dq
      ```

      Result:
      ```
      ..done
      id: b0cf2b0u7nhl75gp1c9t
      folder_id: b1gqs1teo2q2a4vnmi2t
      created_at: "2019-03-12T13:27:22Z"
      name: subnet-1
      network_id: enp846vf5fus0nt3lu83
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.0.0/24
      route_table_id: enp1sdveovdpdhaao5dq
      ```

- API

   To create a route table and add [static routes](../concepts/static-routes.md) to it, use the [create](../api-ref/RouteTable/create.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Create](../api-ref/grpc/route_table_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a route table and add [static routes](../concepts/static-routes.md):

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Name of the route table. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `network-id`: ID of the network where the table will be created.
      * `static_route`: Static route description:
         * `destination_prefix`: Destination subnet prefix in CIDR notation.
         * `next_hop_address`: Internal IP address of the VM from the [allowed ranges](../concepts/network.md#subnet) the traffic will be sent through.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_vpc_route_table" "lab-rt-a" {
        name       = "<route table name>"
        network_id = "<network ID>"
        static_route {
          destination_prefix = "10.2.0.0/16"
          next_hop_address   = "172.16.10.10"
        }
      }
      ```

      To add, update, or delete a route table, use the `yandex_vpc_route_table` resource and specify the network in the `netword id` field (such as `network_id = "${yandex_vpc_network.lab-net.id}"`).

      For more information about the `yandex_vpc_route_table` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_route_table).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc route-table list
         ```

{% endlist %}
