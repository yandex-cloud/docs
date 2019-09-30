# Creating a static route

{% note info %}

The default static route (`0.0.0.0/0`) affects VMs with public IPs. If you need to [create a NAT instance](../../solutions/routing/nat-instance.md), connect it to a different subnet.

{% endnote %}

{% list tabs %}

- Management console

  To create a route table and add to it [static routes](../concepts/static-routes.md):

  1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.

  1. Select the network to create the route table in.

  1. Click ![image](../../_assets/plus.svg)**Create route table**.

  1. Enter a name for the route table.

     {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Add route**.

  1. In the window that opens, enter the destination subnet's prefix in CIDR notation.

  1. Specify the next hop, which is an IP address from the [allowed ranges](../concepts/network.md#subnet).

  1. Click **Add**.

  1. Click **Create route table**.

  To use static routes, link the route table to a subnet. To do this:

  1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
  1. In the menu that opens, select **Link route table**.
  1. In the window that opens, select the created table from the list.
  1. Click **Add**.

{% endlist %}

