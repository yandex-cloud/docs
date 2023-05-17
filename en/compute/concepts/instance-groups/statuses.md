# Statuses

This section lists possible [instance group statuses](#group-statuses) and [statuses of instances](#vm-statuses) in groups.

{% note info %}

The statuses of instances in groups differ from the [statuses of instances](../vm-statuses.md) in {{ compute-name }}.

{% endnote %}


## Group statuses {#group-statuses}

| Status | Description |
| ----- | ----- |
| `STARTING` | The instance group is created or started.<br>Allowed actions with the instance group: [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). |
| `ACTIVE` | The instance group is running. [Auto-healing](autohealing.md) and [scaling](scale.md) will run in groups with this status if they were previously activated in the settings.<br>Allowed actions with the group: [update](../../operations/instance-groups/update.md), [pause](../../operations/instance-groups/pause-processes.md), [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). |
| `PAUSED` | The group's virtual machines are running, but updates, auto-healing, and scaling is paused.<br>Allowed actions with the instance group: [resume processes](../../operations/instance-groups/resume-processes.md), [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as re-sizing the group or re-configuring instances, will not be applied until processes are resumed. |
| `STOPPING` | Virtual machines and processes in the instance group are stopped.<br>Allowed actions with the instance group: [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as re-sizing the group or re-configuring instances, are only applied after the group starts. |
| `STOPPED` | Virtual machines and processes in the instance group are stopped.<br>Allowed actions with the instance group: [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as re-sizing the group or re-configuring instances, are only applied after the group starts. |
| `DELETING` | The instance group is deleted. First, the instances in the group are deleted, then the [network load balancer target group](../../../network-load-balancer/concepts/target-resources.md) is deleted (if specified). Finally, the instance group itself is deleted.<br>Allowed actions with the group: [update](../../operations/instance-groups/update.md), if you need to specify a new service account ID. |

## Statuses of instances in the group {#vm-statuses}

| Status | Description |
| ----- | ----- |
| `CREATING_INSTANCE` | Instance is being created and started. {{ ig-name }} will wait until the instance in {{ compute-name }} changes its [status](../vm-statuses.md) to `RUNNING`. |
| `AWAITING_STARTUP_DURATION` | Instance has been created and is waiting for the user application to start for the specified startup period. Network traffic is not being sent to the instance. For [automatic scaling](scale.md), instances with this status are not taken into account. |
| `CHECKING_HEALTH` | {{ ig-name }} is waiting for the results from the [health check](autohealing.md#auto-healthcheck) of the instance. |
| `OPENING_TRAFFIC` | When the instance's [health check status](../../../network-load-balancer/concepts/health-check.md) switches to `HEALTHY`, it is added to the load balancer's target group. This means the instance is ready to receive network traffic from the load balancer. |
| `AWAITING_WARMUP_DURATION` | Instance receives traffic, but no metrics for [automatic scaling](scale.md) are read from it during the specified time interval. |
| `RUNNING_ACTUAL` | Instance is running and receiving network traffic. User applications are running. |
| `RUNNING_OUTDATED` | Instance is running but will soon be updated or deleted. |
| `CLOSING_TRAFFIC` | The instance is being removed from the network load balancer's target group. Network traffic from the load balancer to the instance is stopped. |
| `STOPPING_INSTANCE` | Instance is being stopped. |
| `STOPPED` | The instance was stopped. You aren't charged for instances with this status. |
| `STARTING_INSTANCE` | Instance is being started. {{ ig-name }} waits until the instance in {{ compute-name }} changes its [status](../vm-statuses.md) to `RUNNING`. |
| `UPDATING_INSTANCE` | The basic parameters or metadata of the instance are being updated. |
| `DELETING_INSTANCE` | The instance is being deleted. |
| `PREPARING_RESOURCES` | The instance is being prepared for use with new instances. For example, renaming or changing disk volumes. |
| `DELETED` | The instance was deleted. All the data and resources associated with this instance are saved for later use. |

## Lifecycle of instances in a group {#life-cycle-instance}

The diagram shows how the instance status changes during the lifecycle:

- ![dot-yellow](../../../_assets/dot-yellow.png): {{ ig-name }} performs an action on the instance.
- ![dot-green](../../../_assets/dot-green.png): The instance expects an action from {{ ig-name }}.

![life cycle instance](../../../_assets/life-cycle-instance.svg =495x697)