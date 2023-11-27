# Fixing the "Not enough resources" error on launching a virtual machine



## Issue description {#issue-description}

* You see the `Not enough resources` error when trying to create or launch a VM instance.

## Solution {#issue-resolution}

The `Not enough resources` error on VM instance creation is caused by a shortage of resources for VM creation and launch in the selected availability zone.
The resource availability check for the launch happens when you try to launch a preemptible VM instance.

Possible ways to solve this issue:

* [Change the availability zone](../../../compute/operations/vm-control/vm-change-zone.md) for the VM instance and try to create or launch it again.
* [Change the configuration of VM instance computing resources](../../../compute/operations/vm-control/vm-update-resources.md): Decrease the number of allocated CPU cores, RAM, disk space, and the number of GPUs attached to the VM instance (if any).
* [Change placement policy for the VM](../../../compute/operations/placement-groups/create.md): If you set up a placement group for the VM, check its parameters. The issue might be related to the limitations of the VM placement policy in the availability zone or a [host from the host group](../../../compute/concepts/dedicated-host.md#bind-vm). Try changing the group parameters, setting less stringent requirements for VM placement, and repeat the creation or launch of the VM instance.
* If you use [preemptible VM instances](../../../compute/concepts/preemptible-vm.md), change the type of your problematic VMs from preemptible to regular by [this guide](../../../compute/operations/vm-create/create-preemptible-vm.md#preemptible-to-regular).
   In scenarios with preemptible VMs, you can also use [instance groups](../../../compute/concepts/instance-groups/index.md) of one or more VM instances. To restart preemptible VMs, set up [auto-recovery policies](../../../compute/concepts/instance-groups/autohealing.md) for their groups.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. ID of the VM instance that cannot be launched.
2. Problem description.
