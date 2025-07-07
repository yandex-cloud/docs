---
title: How to create a private subnet in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a private subnet and connect your {{ baremetal-full-name }} servers to it.
---

# Creating a private subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [private subnet](../concepts/network.md#private-subnet).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-zone }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where your server will be located.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the [pool](../concepts/servers.md#server-pools) containing available servers for leasing.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your subnet name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a subnet **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Optionally, configure routing to allow communication with servers from other [pools](../concepts/servers.md#server-pools):

     1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select an existing [VRF](../concepts/network.md#vrf-segment) or create a new one.
     1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify the subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
     1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, specify the gateway IP address for routing traffic from this subnet to other VRF-connected subnets.
     
         By default, the gateway IP address is the first available address in the specified subnet CIDR range.
     1. Optionally, enable **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** to allow network interfaces on the private subnet to obtain IP addresses automatically.
     1. If you have enabled **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, specify an IP address range for assigning addresses to server network interfaces.
     
         By default, the assigned range matches the subnet’s CIDR block.

  1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}
