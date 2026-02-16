# Stopping and pausing an instance group

You can completely or partially stop an instance group.

## Stopping a group {#stopping}

Completely _stopping a group_ stops all the instances and interrupts the following processes: group [autoscaling](scale.md), [automatic recovery](autohealing.md) and [updating](deploy/index.md) of instances. 

The [group's status](statuses.md#group-statuses) first changes to `STOPPING` and then to `STOPPED`. The [statuses of all instances](statuses.md#vm-statuses) first change to `STOPPING_INSTANCE` and then to `STOPPED`. Afterwards, no other [charges](../../pricing.md) are incurred for VM use.

Any significant changes to a stopped group, such as re-sizing the group or re-configuring instances, are only applied after the group starts.
  
To stop a group, follow [this guide](../../operations/instance-groups/stop.md).
  
## Pausing processes {#pausing}

{% include [stop-in-deleting-ig](../../../_includes/compute/stop-in-deleting-ig.md) %}

_Pausing a group's processes_ interrupts only the following processes: group autoscaling, automatic recovery and updating of instances. All instances running when processes are paused continue to run.

The group's status changes to `PAUSED`. The statuses of all the instances remain unchanged, and you will continue to be charged for their use.

Any significant changes to the group, such as re-sizing the group or re-configuring instances, will not be applied until processes are resumed.
  
To pause a group's processes, follow [this guide](../../operations/instance-groups/pause-processes.md).