---
title: '{{ compute-full-name }} reserved instance pool'
description: In this article, you will learn what a reserved instance pool is and how to reserve computing resources to create VMs with required configurations in selected availability zones.
---

# Reserved instance pools

{% include [reserved-pools-pricing-warning](../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../_includes/compute/reserved-pools-preview-notice.md) %}

A _reserved instance pool_ is the total of computing resources reserved by the user in a given [availability zone](../../overview/concepts/geo-scope.md) to secure their guaranteed availability to the user for the purpose of creating [VMs](./vm.md) of a particular [configuration](./performance-levels.md#available-configurations) in this availability zone.

A reserved instance pool consists of a set of _slots_, i.e., collections of the availability zone's [computing resources](./vm.md#types) that are minimally required to launch one VM in the configuration specified for the pool. The size of a reserved instance pool is the number of slots in the pool. You can [change](../operations/reserved-pools/update-reserved-pool.md) the pool size after you create it.

Pool slots can be either free or occupied by running VMs. Each running VM attached to a reserved instance pool occupies one slot.

{% note info %}

Vacant reserved instance pool slots use up [quotas](./limits.md#compute-quotas) for the total number of vCPUs, GPUs, and VM's total virtual memory but do not use up quotas for the number of VMs per cloud.

{% endnote %}

You can manage reserved instance pools and attach VMs to them using the [{{ yandex-cloud }} CLI](../cli-ref/reserved-instance-pool/index.md) and [API](../api-ref/ReservedInstancePool/index.md).

Reserved instance pools are incompatible with [dedicated hosts](./dedicated-host.md), [preemptible VMs](./preemptible-vm.md), and VMs with [vCPU performance levels](./performance-levels.md) below 100%. At present, reserved instance pools do not support [placement groups](./placement-groups.md) and [instance groups](./instance-groups/index.md).


## Creating a pool {#creating-pool}

When [creating](../operations/reserved-pools/create-reserved-pool.md) a reserved instance pool, you specify the availability zone the computing resources will be reserved in and the configuration of the virtual machines in the pool.

The configuration of VMs in the pool includes the following parameters:

* [Platform](./vm-platforms.md)
* Number of [vCPUs](./performance-levels.md)
* Amount of RAM
* Cluster and number of [GPUs](./gpus.md)
* Network type (standard or [software-accelerated](./software-accelerated-network.md))

The availability zone and VM configuration are set when you create a pool and cannot be changed later. 

## Attaching VMs to a pool {#attaching-vms}

To attach a virtual machine to a reserved instance pool, send the pool ID to its settings. You can attach a VM to a reserved instance pool either when [creating](../operations/reserved-pools/manage-pool-vms.md#attach-new-vm) a new VM or when [updating](../operations/reserved-pools/manage-pool-vms.md#attach-existing-vm) an existing one.

When you create a new virtual machine in the reserved instance pool, this virtual machine will occupy one of the free slots in the pool. If you create a VM in a pool with no free slots, the VM creation will fail with an error. To fix this, you can [increase](../operations/reserved-pools/update-reserved-pool.md) the pool size.

When attaching an existing virtual machine to a reserved instance pool:
* If the VM you are attaching to the pool is stopped, this will not affect the pool size, and when you start the VM, it will occupy one of the available slots.
* If you are attaching a running VM, the pool size will increase by one slot.

You cannot attach a VM to the reserved instance pool if its configuration is different from the configuration specified in the pool settings.

## Starting and stopping VMs attached to a pool {#stopping-vms}

Stopping a virtual machine attached to the reserved instance pool releases the slot occupied by that virtual machine; that slot can then be used by the same or another VM in the pool. When restarted, this VM will again occupy one of the available slots.

This means stopped VMs do not consume slots in reserved instance pools and the number of VMs attached to a pool may exceed its size. The number of VMs in the pool running at the same time cannot exceed its size, i.e., total available slots.

## Detaching VMs from a pool {#detaching-vms}

You can [detach](../operations/reserved-pools/manage-pool-vms.md#detach-vm) a virtual machine from a reserved instance pool: 
* If the VM you want to detach is stopped, this will not affect the pool size.
* If the VM you want to detach is running,the pool size will decrease by one slot.

## Deleting a pool {#deleting-pool}

When you [delete](../operations/reserved-pools/delete-reserved-pool.md) a reserved instance pool, all attached VMs will be detached from it, and the running VMs will continue to operate.

#### See also {#see-also}

* [{#T}](../operations/reserved-pools/create-reserved-pool.md)
* [{#T}](../operations/reserved-pools/update-reserved-pool.md)
* [{#T}](../operations/reserved-pools/delete-reserved-pool.md)
* [{#T}](../operations/reserved-pools/manage-pool-vms.md)