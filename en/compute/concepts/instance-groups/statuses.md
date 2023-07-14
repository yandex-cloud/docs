# Statuses

This section lists the statuses [instance groups](#group-statuses) and [instances (VMs)](#vm-statuses) may have.

{% note info %}

The statuses of instances in groups differ from [those of instances (VMs)](../vm-statuses.md) in {{ compute-name }}.

{% endnote %}


## Group statuses {#group-statuses}

| Status | Description |
----- | -----
| `STARTING` | Instance group is being created or started.<br>The allowed actions with the instance group are: [stop](../../operations/instance-groups/stop.md) and [delete](../../operations/instance-groups/delete.md). |
| `ACTIVE` | Instance group is running. [Auto-healing](autohealing.md) and [scaling](scale.md) will run in groups with this status if they were previously activated in the settings.<br>The allowed actions with the group are [update](../../operations/instance-groups/update.md), [pause](../../operations/instance-groups/pause-processes.md), [stop](../../operations/instance-groups/stop.md), and [delete](../../operations/instance-groups/delete.md). |
| `PAUSED` | Instances in the group are running, but updates, auto-healing, and scaling are paused.<br>The allowed actions with the instance group are [resume processes](../../operations/instance-groups/resume-processes.md) and [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as resizing the group or reconfiguring instances, will not be applied until the processes are resumed. |
| `STOPPING` | Virtual machines and processes in the instance group are being stopped.<br>The allowed actions with the instance group are [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), and [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as resizing the group or reconfiguring instances, will only be applied after the group starts. |
| `STOPPED` | Virtual machines and processes in the instance group have been stopped.<br>The allowed actions with the instance group are [start](../../operations/instance-groups/start.md), [update](../../operations/instance-groups/update.md), and [delete](../../operations/instance-groups/delete.md).<br>Any significant changes to the group, such as resizing the group or reconfiguring instances, will only be applied after the group starts. |
| `DELETING` | Instance group is being deleted. First, the instances in the group are deleted, and then the [network load balancer target group](../../../network-load-balancer/concepts/target-resources.md) (if any) is deleted, too. Finally, the entire instance group is deleted as well.<br>The allowed action with the group is [update](../../operations/instance-groups/update.md) (in case you need to specify a new service account ID). |

## Statuses of instances in the group {#vm-statuses}

| Status | Description |
----- | -----
| `CREATING_INSTANCE` | Instance is being created and started. {{ ig-name }} will wait until the instance [status](../vm-statuses.md) in {{ compute-name }} switches to `RUNNING`. |
| `AWAITING_STARTUP_DURATION` | Instance has been created and is waiting for the user application to start for the specified startup period. Network traffic is not being sent to the instance. For [automatic scaling](scale.md), instances with this status are not taken into account. |
| `CHECKING_HEALTH` | {{ ig-name }} is waiting for the results of its own [health checks](autohealing.md) of the instance. You can limit the time in this status (see [{#T}](autohealing.md#settings)). |
| `OPENING_TRAFFIC` | If an instance group is [integrated with the load balancing service](balancers.md), {{ ig-name }} waits until the instance passes a health check from the load balancer and is ready to accept traffic from it. You can limit the time in this status (see [{#T}](balancers.md#principles-health-checks)).<br/>If the integration is disabled, the status is skipped. |
| `AWAITING_WARMUP_DURATION` | Instance receives traffic, but no metrics for [automatic scaling](scale.md) are read from it during the specified time interval. |
| `RUNNING_ACTUAL` | Instance is running and receiving network traffic. User applications are running. |
| `RUNNING_OUTDATED` | Instance is running but will soon be updated or deleted. |
| `CLOSING_TRAFFIC` | Instance is being removed from the network load balancer's target group. Network traffic from the load balancer to the instance is being stopped. |
| `STOPPING_INSTANCE` | Instance is being stopped. |
| `STOPPED` | Instance has been stopped. You are not charged for instances with this status. |
| `STARTING_INSTANCE` | Instance is being started. {{ ig-name }} will wait until the instance [status](../vm-statuses.md) in {{ compute-name }} switches to `RUNNING`. |
| `UPDATING_INSTANCE` | Basic parameters or metadata of the instance are being updated. |
| `DELETING_INSTANCE` | Instance is being deleted. |
| `PREPARING_RESOURCES` | Instance is being prepared for use with new instances. For example, the disks may be remained or their volume may be changed. |
| `DELETED` | Instance has been deleted. All data and resources associated with this instance are saved for later use. |

## Lifecycle of instances in a group {#life-cycle-instance}

The chart below shows how the instance status changes during the lifecycle:

- ![dot-yellow](../../../_assets/dot-yellow.png): {{ ig-name }} performs an action on an instance.
- ![dot-green](../../../_assets/dot-green.png): Instance is waiting for an action from {{ ig-name }}.

![life cycle instance](../../../_assets/life-cycle-instance.svg =495x697)