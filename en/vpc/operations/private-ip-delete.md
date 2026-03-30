---
title: Deleting a reserved internal IP address
description: Follow this guide to release a reserved internal IP address.
---

# Deleting an internal IP address

Before deleting a reserved IP address, you should release it by deleting the resource it is assigned to.

If deletion protection is enabled for the address, disable it before deleting the address.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder containing the address.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Select the subnet containing the reserved address.
   1. Navigate to the ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** tab.
   1. Next to the IP address you want to delete, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}