---
title: How to order a dedicated public subnet in {{ baremetal-full-name }}
description: Follow this guide to order a dedicated public subnet in {{ baremetal-full-name }}.
---

# Ordering a dedicated public subnet

A [dedicated public subnet](../concepts/network.md#public-subnet) is a public subnet made up of an IP address range that will be available to your servers in the selected [pools](../concepts/servers.md#server-pools).

You can lease a new dedicated public subnet or convert an existing [ephemeral public subnet](../concepts/network.md#ephemeral-public-subnet) to a dedicated one.

## Leasing a new dedicated public subnet {#reserve-new-subnet}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to reserve a [dedicated public subnet](../concepts/network.md#public-subnet).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-zone }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where the subnet will be available.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. Select the size of the subnet you want to order.
  
      In the management console, you can only order subnets of size `/29` (six available IP addresses) and `/28` (14 available IP addresses). If you need a larger public subnet, [contact]({{ link-console-support }}/tickets/create) support to request it.
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}

## Converting an ephemeral public subnet to a dedicated one {#transform-ephemeral-to-dedicated}

{% note info %}

You can only convert an ephemeral public subnet to a dedicated public subnet of size `/31`.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the ephemeral public subnet you want to convert to a dedicated one.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. In the list of public subnets that opens, in the ephemeral subnet row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.action_dedicate-ephemeral-subnet }}**.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}