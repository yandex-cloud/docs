---
title: Load balancer target groups in {{ managed-k8s-full-name }}
description: Learn how {{ managed-k8s-name }} manages network load balancer target groups and how to reduce the number of health-checked nodes in a large cluster.
---

# Load balancer target groups

{% include [load-balancer-target-groups-intro](../../_includes/managed-kubernetes/load-balancer-target-groups-intro.md) %}

{% include [load-balancer-v2-availability](../../_includes/managed-kubernetes/load-balancer-v2-availability.md) %}

To enable the `v2` mode for a new or existing network load balancer, follow the steps in [{#T}](../operations/configure-load-balancer-target-groups.md).

## Management mode and policy combinations {#management-modes}

The target group composition depends on the combination of the management mode and traffic policy.

#|
|| **Management mode** | **Traffic policy** | **Target group composition** ||
|| `legacy` | `Local` or `Cluster` | Shared group with all cluster nodes ||
|| `v2` | `Local` | Dedicated group with the nodes hosting the application’s pods ||
|| `v2` | `Cluster` | Shared group with all cluster nodes ||
|#

Consider the following:

* You can only reduce the target group size when the `Local` policy is on.
* If the service pods are distributed across all nodes, enabling the `Local` policy may not scale down the target group.
* A separate group is created for each service that uses the `Local` policy. Check the [{{ network-load-balancer-name }} quotas and limits](../../network-load-balancer/concepts/limits.md) for groups and targets.
* The `v2` mode does not increase [{{ managed-k8s-name }} quotas](limits.md), address space, or master resources.
* If there is no annotation or the value is invalid, the `legacy` mode is used.

## Updating a target group {#target-group-updates}

In `v2` mode with the `Local` policy, the controller uses `EndpointSlice` objects to discover nodes hosting the application pods. If a pod of your application appears on a new node, the controller adds the node to the group. When a node no longer hosts any pods, the controller removes it from the group.

[Health checks](../../network-load-balancer/concepts/health-check.md) of target group nodes are handled by {{ network-load-balancer-name }}. Just because a node belongs to a group does not mean it is actually healthy. The controller decides which nodes to include in the group, while health checks confirm availability of individual nodes.

`EndpointSlice` changes, cloud resource updates, and health checks are performed asynchronously. The group composition may not immediately reflect the new pod placement.

Do not manually edit the composition of groups managed by the controller. To switch modes, use the `Service` object annotation.

## Use cases {#examples}

Let’s assume there is a hundred node cluster where an application runs three pods across three nodes. In `legacy` mode, the load balancer's target group includes all hundred nodes, but only the three ones hosting the application pods pass the health checks. In `v2` mode, the load balancer's target group contains three nodes.

This mode is useful for large clusters running multiple applications, where each app only sits on a small handful of nodes. When you add new nodes for other applications, this app’s target group will not scale until its pods appear on the new nodes.

#### Useful links {#see-also}

* [{#T}](../operations/configure-load-balancer-target-groups.md)
* [{#T}](../operations/create-load-balancer.md)
* [{#T}](../nlb-ref/service.md)
