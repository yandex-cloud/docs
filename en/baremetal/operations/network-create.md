---
title: How to create a VRF in {{ baremetal-full-name }}
description: Follow this guide to create a virtual routing and forwarding segment (VRF) in {{ baremetal-full-name }}.
---

# Creating a VRF

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [VRF](../concepts/index.md#vrf).
  1. In the list of services, select **{{ baremetal-name }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. At the top right, click **Create VRF**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify a name for your VRF. The naming requirements are as follows:

     * It must be 2 to 63 characters long.
     * It may contain lowercase Latin letters, numbers, and hyphens.
     * It must start with a letter and cannot end with a hyphen.

  1. Optionally, add a VRF **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, add labels.
  1. Click **Create VRF**.

{% endlist %}
