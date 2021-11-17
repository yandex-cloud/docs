# Stopping and pausing an instance group

You can completely or partially stop an instance group.

## Stopping a group {#stopping}

Completely _stopping a group_ stops all the instances and interrupts the following processes: the [automatic scaling](scale.md) of a group and the [auto-healing](autohealing.md) and [updating](deploy/index.md) of instances.

[The group status](statuses.md#group-statuses) first changes to `STOPPING` followed by `STOPPED`. The [statuses of all instances](statuses.md#vm-statuses) first change to `STOPPING_INSTANCE` and then to `STOPPED`. Afterwards, no other [charges](../../pricing.md) are incurred for VM use.

Any significant changes to a stopped group, such as re-sizing the group or re-configuring instances, are only applied after the group starts.

You can stop a group by following the [instructions](../../operations/instance-groups/stop.md).

## Pausing processes {#pausing}

_Pausing processes_ in a group only interrupts the automatic scaling of the group and the auto-healing and updating of instances. All instances running when processes are paused continue to run.

The group status changes to `PAUSED`. The statuses of all the instances remain unchanged, and you will continue to be charged for their use.

Any significant changes to the group, such as re-sizing the group or re-configuring instances, will not be applied until processes are resumed.

You can pause processes in a group by following the [instructions](../../operations/instance-groups/pause-processes.md).