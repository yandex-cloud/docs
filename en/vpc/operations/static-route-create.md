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
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **Route tables**.
   1. Click **Create**.
   1. Enter a name for the route table.

      {% include [name-format](../../_includes/name-format.md) %}

   1. (optional) Add a description of a route table.
   1. Select the network to create the route table in.
   1. Click **Add route**.
   1. In the window that opens, enter the prefix of the destination subnet in CIDR notation.
   1. Specify the **next hop**, which is an IP address from the [allowed ranges](../concepts/network.md#subnet).
   1. Click **Add**.
   1. Click **Create route table**.

   To use static routes, link the route table to a subnet:

   1. On the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
   1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **Link route table**.
   1. In the window that opens, select the created table from the list.
   1. Click **Link**.

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

      * `name`: The name of the route table.
      * `network-id`: The ID of the network where the table will be created.
      * `route`: The route settings with two parameters:
         * `destination`: The destination subnet prefix in CIDR notation.
         * `next-hop`: The internal IP address of the VM from the [allowed ranges](../concepts/network.md#subnet) that traffic is sent through.

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

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a route table and add [static routes](../concepts/static-routes.md):

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `name`: The name of the route table. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `network-id`: The ID of the network where the table will be created.
      * `static_route`: Static route description:
         * `destination_prefix`: The destination subnet prefix in CIDR notation.
         * `next_hop_address`: The internal IP address of the VM from the [allowed ranges](../concepts/network.md#subnet) that traffic is sent through.

      Example configuration file structure:

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

      For more information about the `yandex_vpc_route_table` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_route_table).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc route-table list
         ```

{% endlist %}
