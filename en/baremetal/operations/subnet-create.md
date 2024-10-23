---
title: How to create a private subnet in {{ baremetal-full-name }}
description: Follow this guide to create a private subnet for your servers in {{ baremetal-full-name }}.
---

# Creating a private subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a [private subnet](../concepts/index.md#private-subnet) in.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. At the top right, click **Create subnet**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter a name for your subnet. The naming requirements are as follows:

     * It must be 2 to 63 characters long.
     * It may contain lowercase Latin letters, numbers, and hyphens.
     * It must start with a letter and cannot end with a hyphen.

  1. Optionally, add a **{{ ui-key.yacloud.baremetal.field_description }}** for the subnet.
  1. Optionally, add labels.
  1. Optionally, set up routing for working with servers from other [pools](../concepts/index.md#server-pools):

     1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select [VRF](../concepts/index.md#vrf). Make sure to create it in advance.
     1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, enter the subnet IP address and mask.
     1. Click **Create subnet**.

{% endlist %}
