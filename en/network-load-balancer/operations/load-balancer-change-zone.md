---
title: How to move an NLB backend VM to a target group in a new availability zone
description: Follow this guide to move {{ network-load-balancer-full-name }} backend VMs to a target group in a different availability zone.
---

# Moving a VM to a target group in a new availability zone


To move NLB backend VMs to a target group in a different [availability zone](../../overview/concepts/geo-scope.md):

1. [Move](../../compute/operations/vm-control/vm-change-zone.md) your VMs to the new availability zone.
1. Replace [targets](../concepts/target-resources.md) in the target group:

    {% include [replace-targets](../../_includes/network-load-balancer/replace-targets.md) %}

1. If you are using an [internal network load balancer](../concepts/specifics.md#nlb-int-routing) and need to move it to a subnet in the new availability zone that will host your VMs:

    1. [Delete](./listener-remove.md) the current listener of your load balancer.
    1. [Add](./listener-add.md) a new listener for the new availability zone.

    This will change the network load balancer IP address.

1. [Make sure](../../network-load-balancer/operations/check-resource-health.md) the target group VMs in the new availability zone have passed [health checks](../concepts/health-check.md) and got the `HEALTHY` status.

    If the new VMs remain `UNHEALTHY` for too long, make sure their security groups are configured to allow [health check](../concepts/health-check.md#target-statuses) traffic.
