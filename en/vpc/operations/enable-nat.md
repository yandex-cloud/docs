# Enabling NAT to the internet

{% note info %}

The feature is obsolete. If you disable NAT to the internet in a subnet, you can't enable it again and have to use a [NAT gateway](../concepts/gateways.md#nat-gateway) instead.

{% endnote %}

With NAT to the internet, cloud resources connected to a subnet can access the internet without using public IPs.

To enable NAT to the internet:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder with the subnet whose cloud resources need to access the internet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Select the network with the appropriate subnet.
   1. Under **Subnets**, click ![options](../../_assets/options.svg) in the line of the subnet.
   1. In the menu that opens, select **Enable NAT to the internet**.

{% endlist %}
