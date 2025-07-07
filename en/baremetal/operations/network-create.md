---
title: How to create a VRF in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a virtual routing and forwarding (VRF) segment in {{ baremetal-full-name }}.
---

# Creating a VRF

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [VRF](../concepts/network.md#vrf-segment).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your VRF name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a VRF **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}
