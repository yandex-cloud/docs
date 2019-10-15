# Creating static routes

{% note info %}

The default static route (`0.0.0.0/0`) is used for VMs with public IPs. If you need to [create a NAT instance](../../solutions/routing/nat-instance.md), create it in a separate subnet.

{% endnote %}

{% list tabs %}

- Management console

  To create a route table and add [static routes](../concepts/static-routes.md):

  1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.

  1. Select the network to create the route table in.

  1. Click ![image](../../_assets/plus.svg)**Create route table**.

  1. Enter a name for the route table.

     {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Add route**.

  1. In the window that opens, enter the prefix of the destination subnet in CIDR notation.

  1. Specify the **next hop**, which is an IP address from the [allowed ranges](../concepts/network.md#subnet).

  1. Click **Add**.

  1. Click **Create route table**.

  To use static routes, link the route table to a subnet:
  1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
  1. In the menu that opens, select **Link route table**.
  1. In the window that opens, select the created table from the list.
  1. Click **Add**.

- CLI

  To create a route table and add [static routes](../concepts/static-routes.md):

  1. View a description of the CLI command for creating routing tables:

     ```
     $ yc vpc route-table create --help
     ```

  1. Get the IDs of cloud networks in your cloud:

     ```
     $ yc vpc network list
     +----------------------+-----------------+
     |          ID          |      NAME       |
     +----------------------+-----------------+
     | enp34hbpj8dqebn3621l | yc-auto-subnet  |
     | enp846vf5fus0nt3lu83 | routes-test     |
     +----------------------+-----------------+
     ```

  1. Create a routing table in one of the networks. Use the following flags:
     * `name` — The name of the route table.
     * `network-id` — The ID of the network where the tables will be created.
     * `route` — The route settings with two parameters:
        * `destination` — The destination subnet prefix in CIDR notation.
        * `next-hop` — The internal IP address of the VM from the [allowed ranges](../concepts/network.md#subnet) that traffic is sent through.

     ```
     $ yc vpc route-table create --name=test-route-table --network-id=enp846vf5fus0nt3lu83 --route destination=0.0.0.0/0,next-hop=192.168.1.5
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
     $ yc vpc subnet list
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     |          ID          |       NAME       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     | b0cf2b0u7nhl75gp1c9t | subnet-1         | enp846vf5fus0nt3lu83 |                | ru-central1-c | [192.168.0.0/24] |
     | e2llnffvbakqu18hr170 | subnet-2         | enp846vf5fus0nt3lu83 |                | ru-central1-b | [192.168.1.0/24] |
     +----------------------+------------------+----------------------+----------------+---------------+------------------+
     ```

  1. Link the routing table to one of the subnets:

     ```
     $ yc vpc subnet update b0cf2b0u7nhl75gp1c9t --route-table-id enp1sdveovdpdhaao5dq
     ..done
     id: b0cf2b0u7nhl75gp1c9t
     folder_id: b1gqs1teo2q2a4vnmi2t
     created_at: "2019-03-12T13:27:22Z"
     name: subnet-1
     network_id: enp846vf5fus0nt3lu83
     zone_id: ru-central1-c
     v4_cidr_blocks:
     - 192.168.0.0/24
     route_table_id: enp1sdveovdpdhaao5dq
     ```

{% endlist %}

