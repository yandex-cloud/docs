---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Statuses

This section lists possible [instance group statuses](#group-statuses) and [statuses of instances](#vm-statuses) in groups.

{% note info %}

The statuses of instances in groups differ from the [statuses of instances](../vm-statuses.md) in {{ compute-name }}.

{% endnote %}

## Instance group status {#group-statuses}

| Status | Description |
| ----- | ----- |
| `STARTING` | The instance group is created or started.<br>Allowed actions with the instance group: [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). |
| `ACTIVE` | The instance group is running. For groups with this status, [automatic recovery](autohealing.md) and [automatic scaling](scale.md#auto-scale) are running, provided they were enabled in the settings.<br>Allowed actions with the group: [update](../../operations/instance-groups/update.md), [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). |
| `STOPPING` | Instances in the group are stopped.<br>Allowed actions with the group: [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as re-sizing the group or re-configuring instances, are only applied after the group starts. |
| `STOPPED` | All instances in the group are stopped.<br>Allowed actions with the group: [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as re-sizing the group or re-configuring instances, are only applied after the group starts. |
| `DELETING` | The instance group is deleted. First, the instances in the group are deleted, then the [network load balancer target group](../../../network-load-balancer/concepts/target-resources.md) is deleted (if specified). Finally, the instance group itself is deleted.<br>Allowed actions with the group: [update](../../operations/instance-groups/update.md), if you need to specify a new service account ID. |

## Statuses of instances in the group {#vm-statuses}

| Status | Description |
| ----- | ----- |
| `CREATING_INSTANCE` | An instance is created and started. {{ ig-name }} waits until the instance in {{ compute-name }} changes its [status to](../vm-statuses.md) `RUNNING`. |
| `AWAITING_STARTUP_DURATION` | The instance has been created and is waiting for the user application to start for the specified startup period. Network traffic is not sent to the instance. For [automatic scaling](scale.md), instances with this status are not taken into account. |
| `CHECKING_HEALTH` | {{ ig-name }} expects the results from the [health check](autohealing.md#auto-healthcheck) of the instance. |
| `OPENING_TRAFFIC` | When the instance changes its state to [condition](../../../network-load-balancer/concepts/health-check.md) `HEALTHY`, it's added to the network load balancer's target group. The instance is ready to receive network traffic from the load balancer. |
| `AWAITING_WARMUP_DURATION` | The instance receives traffic, but no metrics for [automatic scaling](scale.md) are read from it during the specified time interval. |
| `RUNNING_ACTUAL` | The instance is running and receives network traffic. User applications are running. |
| `RUNNING_OUTDATED` | The instance is running but will soon be updated or deleted. |
| `CLOSING_TRAFFIC` | The instance is removed from the network load balancer's target group. Network traffic from the load balancer to the instance is stopped. |
| `STOPPING_INSTANCE` | Instance is being stopped. |
| `STOPPED` | The instance was stopped. You aren't charged for instances with this status. |
| `STARTING_INSTANCE` | An instance is started. {{ ig-name }} waits until the instance in {{ compute-name }} changes its [status to](../vm-statuses.md) `RUNNING`. |
| `UPDATING_INSTANCE` | The basic parameters or metadata of the instance are being updated. |
| `DELETING_INSTANCE` | The instance is being deleted. |
| `PREPARING_RESOURCES` | The instance is being prepared for use with new instances. For example, renaming or changing disk volumes. |
| `DELETED` | The instance was deleted. All the data and resources associated with this instance are saved for later use. |

## Lifecycle of instances in a group {#life-cycle-instance}

The diagram shows how the instance status changes during the lifecycle:

- ![dot-yellow](../../../_assets/dot-yellow.png): {{ ig-name }} performs an action on the instance.
- ![dot-green](../../../_assets/dot-green.png): The instance expects an action from {{ ig-name }}.

![life cycle instance](../../../_assets/life-cycle-instance.svg =495x697)

