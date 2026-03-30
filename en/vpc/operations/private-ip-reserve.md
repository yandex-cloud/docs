---
title: Reserving an internal IP address
description: Follow this guide to reserve an internal IP address.
---

# Reserving an internal IP address

You can reserve an [internal IP address](../concepts/address.md#internal-addresses) and use it for data transfer between cloud resources.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to reserve an IP address.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Select the subnet where you want to reserve the address.
   1. Navigate to the ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** tab.
   1. Click **{{ ui-key.yacloud.vpc.Subnetwork.SubnetUsedAddressesList.button_create_sPV4s }}**.  
   1. In the window that opens:
       * Enter a name and description for the internal address.
       * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, enter the address you would like to reserve.
       * Optionally, enable **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
       * Optionally, specify [labels](../../resource-manager/concepts/labels.md).
   1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}