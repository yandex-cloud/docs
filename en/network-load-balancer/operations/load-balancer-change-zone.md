---
title: "How to move a VM to a target group in a new availability zone"
description: "Follow this guide to move VMs behind a {{ network-load-balancer-full-name }} network load balancer to a target group in a different availability zone."
---

# Moving a VM to a target group in a new availability zone


{% note info %}

{% include [zone-c-deprecation](../../_includes/vpc/zone-c-deprecation.md) %}

{% endnote %}

To move VMs behind a network load balancer to a target group in a different [availability zone](../../overview/concepts/geo-scope.md):

1. [Move](../../compute/operations/vm-control/vm-change-zone.md) your VMs to the new availability zone.
1. Replace [targets](../concepts/target-resources.md) in the target group:

   {% include [replace-targets](../../_includes/network-load-balancer/replace-targets.md) %}

1. If you have an [internal network load balancer](../concepts/specifics.md#nlb-int-routing) and need to move it to a subnet in the new availability zone for your VMs:

   1. [Remove](./listener-remove.md) your load balancer's existing traffic listener.
   1. [Add](./listener-add.md) a new traffic listener for the new availability zone.

   This will change the network load balancer's IP address.

1. [Make sure](../../network-load-balancer/operations/check-resource-health.md) the targets of the target group in the new availability zone have passed a [health check](../concepts/health-check.md) and their current status is `HEALTHY`.

   If the new VMs remain in the `UNHEALTHY` status for a long time, check if they have security groups linked that allow [health check](../concepts/health-check.md#target-statuses) traffic.
