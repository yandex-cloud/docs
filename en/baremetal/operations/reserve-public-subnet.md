---
title: How to order a public subnet in {{ baremetal-full-name }}
description: Follow this guide to order a public subnet in {{ baremetal-full-name }}.
---

# Ordering a public subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to reserve a [public subnet](../concepts/network.md#public-subnet).
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-zone }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where the subnet will be available.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the [pools](../concepts/servers.md#server-pools) where the subnet will be available.

      You can link a public subnet to multiple pools simultaneously. 
  1. Select the size of the subnet you want to order.

      In the management console, you can only order subnets of size `/29` (six available IP addresses) and `/28` (14 available IP addresses). If you need a larger public subnet, [contact]({{ link-console-support }}/tickets/create) support to request it.
  1. Under **{{ ui-key.yacloud.baremetal.title_common-info }}**:

      1. In the **{{ ui-key.yacloud.baremetal.field_subnetwork-name }}** field, enter the name of the public subnet.
      1. (Optional) In the **{{ ui-key.yacloud.baremetal.field_description }}** field, add a subnet description.
      1. (Optional) In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, set the [labels](../../resource-manager/concepts/labels.md).
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}
