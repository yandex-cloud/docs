# Fixing the `Not enough resources` error when starting a VM instance



## Issue description {#issue-description}

You get the `Not enough resources` error when creating or starting a VM instance.

## Solution {#issue-resolution}

The `Not enough resources` error when creating a VM instance means that the availability zone you selected lacks resources to create and start a VM. Resources are checked for availability when you try to start a preemptible VM instance.

Here are some possible solutions to this issue:

* [Change the availability zone](../../../compute/operations/vm-control/vm-change-zone.md) for the VM instance and try to create or launch it again.
* [Change the configuration of VM instance computing resources](../../../compute/operations/vm-control/vm-update-resources.md): Decrease the number of allocated CPU cores, RAM, disk space, and the number of GPUs attached to the VM instance (if any).
* [Change the placement policy for the VM](../../../compute/operations/placement-groups/create.md): If you set up a placement group for the VM, check its parameters. The issue may occur because of the limitations of the VM placement policy in the availability zone or the [host from the host group](../../../compute/concepts/dedicated-host.md#bind-vm). Try changing the group parameters by setting less stringent requirements for VM placement, and try creating or starting a VM instance again.

If you use [preemptible VM instances](../../../compute/concepts/preemptible-vm.md), consider changing the type of your affected VMs from preemptible to regular using [this guide](../../../compute/operations/vm-create/create-preemptible-vm.md#preemptible-to-regular).
In scenarios with preemptible VMs, you can also use [instance groups](../../../compute/concepts/instance-groups/index.md) of one or multiple VM instances. To restart preemptible VMs, set up [auto-recovery policies](../../../compute/concepts/instance-groups/autohealing.md) for their group.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the VM instance you cannot start.
1. Issue description.