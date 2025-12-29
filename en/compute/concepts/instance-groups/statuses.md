# Statuses

This section lists the possible statuses of [instance groups](#group-statuses) and [instances (VMs)](#vm-statuses) in a group.

{% note info %}

The statuses of instances in groups are different from the [statuses of instances](../vm-statuses.md) in {{ compute-name }}.

{% endnote %}


## Group statuses {#group-statuses}

#|
|| **Status** | **Description** ||
|| `DEPLOYING` | The group is being created or modified. 
Available actions with the group: [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). ||
|| `STARTING` | The group is starting.
Available actions with the group: [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). ||
|| `ACTIVE` | The group is running. If activated in the settings, [autohealing](autohealing.md) and [scaling](scale.md) will be on in groups with this status. 
Available actions with the group: [modify](../../operations/instance-groups/update.md), [pause processes](../../operations/instance-groups/pause-processes.md), [stop](../../operations/instance-groups/stop.md), [delete](../../operations/instance-groups/delete.md). ||
|| `PAUSED` | The group's instances are running; however, updates, autohealing, and scaling are paused.
Available actions with the group: [resume processes](../../operations/instance-groups/resume-processes.md).
All major alterations of the group, e.g., resizing, instance reconfiguration, etc., will only apply after the processes are resumed.

{% include [stop-in-deleting-ig](../../../_includes/compute/stop-in-deleting-ig.md) %} ||
|| `STOPPING` | The group's instances and processes are coming to a halt.
Available actions with the group: [run](../../operations/instance-groups/start.md), [modify](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).
All major alterations of the group, e.g., resizing, instance reconfiguration, etc., will only apply after the group is started. ||
|| `STOPPED` | All the group's instances and processes are stopped.
Available actions with the group: [run](../../operations/instance-groups/start.md), [modify](../../operations/instance-groups/update.md), [delete](../../operations/instance-groups/delete.md).
All major alterations of the group, e.g., resizing, instance reconfiguration, etc., will only apply after the group is started. ||
|| `DELETING` | The group is being deleted. The first to be deleted are the group's instances, next the [network load balancer target group](../../../network-load-balancer/concepts/target-resources.md), if specified. Finally, the instance group itself gets deleted.
Available actions with the group: [modify](../../operations/instance-groups/update.md), if you need to specify a new service account ID. ||
|#

## Statuses of instances in the group {#vm-statuses}

Status | Description
----- | -----
`CREATING_INSTANCE` | The instance is being created and started. {{ ig-name }} is waiting for the instance in {{ compute-name }} to get the `RUNNING` [status](../vm-statuses.md).
`AWAITING_STARTUP_DURATION` | The instance has been created and is waiting for the user application to start up within the specified upload period. Network traffic is not being sent to the instance. For [automatic scaling](scale.md), instances with this status are not taken into account.
`CHECKING_HEALTH` | {{ ig-name }} is waiting for the results of its own [health checks](autohealing.md) of the instance. You can limit the time in this status (see [{#T}](autohealing.md#settings)).
`OPENING_TRAFFIC` | If an instance group is [integrated with the load balancing service](balancers.md), {{ ig-name }} waits until the instance passes a health check from the load balancer and is ready to accept traffic from it. You can limit the time in this status (see [{#T}](balancers.md#principles-health-checks)).<br/>If the integration is disabled, the status is skipped.
`AWAITING_WARMUP_DURATION` | The instance is receiving traffic, but no [autoscaling](scale.md) metrics are read from it during the specified time interval.
`RUNNING_ACTUAL` | The instance is running and receiving network traffic. User applications are running.
`RUNNING_OUTDATED` | The instance is running but will soon be updated or deleted.
`CLOSING_TRAFFIC` | The instance is being removed from the network load balancer's target group. Network traffic from the load balancer to the instance is being stopped.
`STOPPING_INSTANCE` | The instance is being stopped.
`STOPPED` | The instance has been stopped. You are not charged for instances with this status.
`STARTING_INSTANCE` | The instance is starting. {{ ig-name }} is waiting for the instance in {{ compute-name }} to get the `RUNNING` [status](../vm-statuses.md).
`UPDATING_INSTANCE` | Basic parameters or metadata of the instance are being updated.
`DELETING_INSTANCE` | The instance is being deleted.
`PREPARING_RESOURCES` | Instance is being prepared for use with new instances. For example, the disks may be remained or their volume may be changed.
`DELETED` | The instance has been deleted. All data and resources associated with this instance are saved for later use.

## Lifecycle of instances in a group {#life-cycle-instance}

The chart below shows how the instance status changes during the lifecycle:

- ![dot-yellow](../../../_assets/dot-yellow.png): {{ ig-name }} performs an action on the instance.
- ![dot-green](../../../_assets/dot-green.png): The instance expects an action from {{ ig-name }}.

![life cycle instance](../../../_assets/life-cycle-instance.svg =495x697)