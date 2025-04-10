---
title: How to create a private subnet in {{ baremetal-full-name }}
description: Follow this guide to create a private subnet for your servers in {{ baremetal-full-name }}.
---

# Creating a private subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a [private subnet](../concepts/network.md#private-subnet) in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-zone }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) the server will be leased in.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the [pool](../concepts/servers.md#server-pools) the server will be leased from.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter a name for your subnet. Follow these naming requirements:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, add a **{{ ui-key.yacloud.baremetal.field_description }}** for the subnet.
  1. Optionally, add labels.
  1. Optionally, set up routing for working with servers from other [pools](../concepts/servers.md#server-pools):

     1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select an existing [VRF](../concepts/network.md#vrf-segment) or create a new one.
     1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify the subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
     1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, specify the IP address of the gateway for traffic from the subnet to other subnets connected to the VRF.
     
         By default, this is the first address from the specified subnet range CIDR.
     1. (Optional) Enable **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** to for network interfaces connected to the private subnet to receive IP addresses via DHCP.
     1. If you have enabled **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, specify a range from which to assign IP addresses to the server network interfaces.
     
         By default, it matches the range specified for the subnet CIDR.

  1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}
