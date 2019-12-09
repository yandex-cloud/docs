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
| `DELETING` | The instance group is deleted. First, the instances in the group are deleted, then the [load balancer target group](../../../load-balancer/concepts/target-resources.md) is deleted (if specified). Finally, the instance group itself is deleted.<br>Allowed actions with the group: [update](../../operations/instance-groups/update.md), if you need to specify a new service account ID. |

## Statuses of instances in the group {#vm-statuses}

| Status | Description |
| ----- | ----- |
| `CREATING_INSTANCE` | Instance is being created. |
| `AWAITING_STARTUP_DURATION` | After starting, the instance keeps this status for the startup period specified by the user. During this time, user apps can start up and the instance won't receive any time. For [automatic scaling](scale.md), instances with this status are not taken into account. |
| `OPENING_TRAFFIC` | The instance is ready to receive network traffic. |
| `AWAITING_WARMUP_DURATION` | When [automatic scaling](scale.md) is enabled, instances switch to this status when they start receiving network traffic. Instances keep this status during the warm-up period specified in the [automatic scaling settings](scale#auto-scale-settings). Metric values received from an instance with this status are replaced with average values from instances in the same availability zone. |
| `RUNNING_ACTUAL` | The instance is started, receives network traffic, and user apps are running. |
| `CHECKING_HEALTH` | The instance status is being checked. |
| `CLOSING_TRAFFIC` | The instance isn't ready to receive network traffic. |
| `STOPPING_INSTANCE` | The instance is being stopped. |
| `STOPPED` | The instance was stopped. You aren't charged for instances with this status. |
| `STARTING_INSTANCE` | The OS and user application are being started. |
| `RUNNING_OUTDATED` | The instance is running but will soon be updated or deleted. |
| `UPDATING_INSTANCE` | The basic parameters or metadata are being updated without re-creating the instance. |
| `DELETING_INSTANCE` | The instance is being deleted. |
| `DELETED` | The instance was deleted. |

