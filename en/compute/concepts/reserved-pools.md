---
title: '{{ compute-full-name }} reserved instance pools'
description: In this article, you will learn what a reserved instance pool is and how to reserve computing resources to create properly configured VMs in availability zones of your choice.
---

# Reserved instance pools

{% include [reserved-pools-pricing-warning](../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../_includes/compute/reserved-pools-preview-notice.md) %}

A _reserved instance pool_ is the total of computing resources reserved by the user in a given [availability zone](../../overview/concepts/geo-scope.md) to secure their guaranteed availability to the user for the purpose of creating [VMs](./vm.md) of a particular [configuration](./performance-levels.md#available-configurations) in this availability zone.

You can manage reserved instance pools and attach VMs to them using the [{{ yandex-cloud }} CLI](../cli-ref/reserved-instance-pool/index.md) and [API](../api-ref/ReservedInstancePool/index.md).

Reserved instance pools are incompatible with [dedicated hosts](./dedicated-host.md), [preemptible VMs](./preemptible-vm.md), and VMs with [vCPU performance levels](./performance-levels.md) below 100%. At present, reserved instance pools do not support [placement groups](./placement-groups.md) and [instance groups](./instance-groups/index.md).

A reserved instance pool consists of a set of _slots_, i.e., collections of the availability zone's [computing resources](./vm.md#types) that are minimally required to launch one VM in the configuration specified for the pool.

## Pool size {#pool-size}

The size of a reserved instance pool is the number of its slots. You can view a pool’s `size` in its [details](#stats).

When modifying the size of a pool with [pending slots](#pending-slots), another key parameter apart from `size` will be its `committed_size`. The `committed_size` field indicates the actual number of non-pending slots in the pool, i.e., the number of slots for which {{ compute-name }} guarantees resources.

A pool’s `committed_size` will be different from its `size` only if the pool has [pending slots](#pending-slots). If pending slots are not used, the pool’s `committed_size` will match its `size`.

Each running VM attached to a reserved instance pool [occupies](#slot-stats) a single slot. VMs attached to the pool but not currently running do not occupy any slots but still count towards the [total](#vm-stats) number of VMs in the pool.

In pools with [overcommitment](#oversubscription) disabled, the number of attached VMs cannot exceed the `committed_size` value. To attach more VMs to a pool than specified as its `committed_size`, enable overcommitment.

Regardless of the overcomminment state, the number of VMs you can run simultaneously cannot exceed the `committed_size` value.

### Pending slots {#pending-slots}

When increasing the size of a pool, you can enable the _pending slots_ option. This allows you to add to the pool as many slots as you need even if the pool's availability zone currently lacks resources to accommodate them.

You can manage this setting via `--allow-pending-slots` in the `yc compute reserved-instance-pool update` {{ yandex-cloud }} CLI [command](../cli-ref/reserved-instance-pool/update.md) or in the `allow_pending_slots` field of an [API](../api-ref/ReservedInstancePool/index.md) request.

When you scale up a pool with pending slots enabled, and there are not enough resources to create new slots immediately, any such slots will get the `pending` [status](#slot-stats). {{ compute-full-name }} will continuously search for resources in the reserved instance pool's availability zone to allocate them to `pending` slots. Once there are enough resources for a slot, its status changes to `available`, and the pool's `committed_size` value increases accordingly.

{% note info %}

Slots with the `pending` status are not billable.

{% endnote %}

You must enable pending slots each time you change the size of a pool with slots in the `pending` status. Otherwise, the reserved instance pool update operation will fail. The only exception is scaling a pool down to a value that does not exceed its `committed_size`. When you scale down a pool, its `pending` slots will be removed first.

## Creating a pool {#creating-pool}

When [creating](../operations/reserved-pools/create-reserved-pool.md) a reserved instance pool, you specify its size as the number of slots, the availability zone the computing resources will be reserved in, and the configuration of the virtual machines in the pool.

The configuration of VMs in the pool includes the following parameters:

* [Platform](./vm-platforms.md)
* Number of [vCPUs](./performance-levels.md)
* Amount of RAM
* Cluster and number of [GPUs](./gpus.md)
* Network type (standard or [software-accelerated](./software-accelerated-network.md))

You can [change](../operations/reserved-pools/update-reserved-pool.md) the pool size after you create it. The availability zone and VM configuration are set when you create a pool and cannot be changed later.

## Managing instances in a pool {#managing-pool}

{% note info %}

You cannot attach a VM to a reserved instance pool if its configuration is different from that specified in the pool settings.

{% endnote %}

### Attaching VMs to a pool {#attaching-vms}

To attach a virtual machine to a reserved instance pool, provide the pool ID in the VM’s settings. You can attach a VM to a reserved instance pool either when [creating](../operations/reserved-pools/manage-pool-vms.md#attach-new-vm) a new VM or when [updating](../operations/reserved-pools/manage-pool-vms.md#attach-existing-vm) an existing one.

When you create a new virtual machine in the reserved instance pool, this virtual machine will occupy one of the [free](#stats) slots in the pool. If you create a VM in a pool with no free slots, the VM creation will fail with an error. To fix this, you can [increase](../operations/reserved-pools/update-reserved-pool.md) the pool size.

When attaching an existing virtual machine to a reserved instance pool:
* If the VM is stopped, the `total` value in the pool's VM [statistics](#vm-stats) will increase.
* If the VM is running, the number of `available` slots in the pool's [slot statistics](#slot-stats) will decrease while the number of `used` slots will increase as well as the `total` value in the [VM statistics](#vm-stats).

    If the pool has `pending` or `unavailable` slots, the running VMs you are attaching will replace such slots first, starting with `unavailable` ones.

By default, the number of VMs attached to a pool cannot exceed its actual size, specified under `committed_size`. The possible workaround is to use [overcommitment](#oversubscription).

#### Overcommitment {#oversubscription}

In _overcommitment mode_, you can attach any number of stopped VMs to a pool so that the total count of attached VMs can exceed its size. However, the number of simultaneously running VMs in a pool cannot be more than its current `committed_size`, which means an attempt to start a VM in a pool with no `available` slots will fail.

You can enable overcommitment when creating or updating a reserved instance pool by using the `--allow-oversubscription` parameter in these {{ yandex-cloud }} CLI [commands](../cli-ref/reserved-instance-pool/index.md): `yc compute reserved-instance-pool create|update`. Alternatively, use the `allow_oversubscription` field in the [API](../api-ref/ReservedInstancePool/index.md) request.

To disable overcommitment in a pool, make sure the number of attached VMs does not exceed its `committed_size`. Remember to [detach](../operations/reserved-pools/manage-pool-vms.md#detach-vm) any excess VMs first.

### Starting and stopping VMs attached to a pool {#stopping-vms}

Stopping a VM attached to a reserved instance pool releases the slot occupied by that VM, changing the slot's [status](#slot-stats) back to `available`. The released slot can then be used by the same or another VM in the pool. This means stopped VMs do not consume slots in reserved instance pools.

When restarted, this VM will again occupy one of the available slots, switching it back to `used`.

### Detaching VMs from a pool {#detaching-vms}

You can [detach](../operations/reserved-pools/manage-pool-vms.md#detach-vm) a virtual machine from a reserved instance pool: 
* If the VM is stopped, the `total` value in the pool's [VM statistics](#vm-stats) decreases.
* If the VM is running, the number of `available` slots in the pool's slot [statistics](#slot-stats) increases while the number of `used` slots as well as the `total` value in the [VM statistics](#vm-stats) decreases.

    You can detach a running VM from a pool only if the availability zone has resources to reserve for the slot being released.

    {% note info %}

    Detaching a running VM from a reserved instance pool increases the amount of [billable](../pricing.md) resources: you pay for the detached VM separately from the pool as well as the resources reserved for its new `available` slot.

    {% endnote %}


## Statistics of pool resource usage {#stats}

To get information about a reserved instance pool, use the `yc compute reserved-instance-pool get` {{ yandex-cloud }} CLI [command](../cli-ref/reserved-instance-pool/get.md), the [get](../api-ref/ReservedInstancePool/get.md) REST API method for the [ReservedInstancePool](../api-ref/ReservedInstancePool/index.md) resource, or the [ReservedInstancePoolService/Get](../api-ref/grpc/ReservedInstancePool/get.md) gRPC API call. The output will return the pool's name, ID, size, availability zone, configuration of its VMs, slot and VM statistics, as well as other properties.

### Pool slot statistics {#slot-stats}

In slot statistics of a reserved instance pool, the following fields are available:

* `total`: Total number of slots in the pool. This is the sum of all `used`, `available`, `unavailable`, and `pending` slots.
* `used`: Number of slots currently occupied by running VMs.
* `available`: Number of slots which have reserved resources in the pool's availability zone. These slots can be occupied by VMs.

    All `available` slots in a reserved instance pool use up [quotas](./limits.md#compute-quotas) for the total number of vCPUs, GPUs, and VM's total virtual memory but do not use up quotas for the number of VMs per cloud.
* `unavailable`: Number of slots currently unavailable due to technical issues.

    If some of the hardware allocated to the pool fails, a slot may become `unavailable`. You cannot use such a slot to run a VM.
    
    {{ compute-name }} continuously attempts to restore `unavailable` slots using the availability zone’s resources. Once the required resources are found, the slot’s status changes back to `available`.
* `pending`: Number of [pending](#pending-slots) slots.

    This status is assigned to a new slot when you scale up a pool and the availability zone lacks resources to allocate to this new slot, provided you perform the update with the pending slots setting enabled.

    {{ compute-name }} continuously searches for resources to allocate them to `pending` slots. Once it finds sufficient resources for a slot, its status changes to `available`.

{% note info %}

Slots with the `unavailable` or `pending` status are not billable.

{% endnote %}

### Pool VM statistics {#vm-stats}

The VM statistics indicate the `total` number of virtual machines attached to a reserved instance pool. This value represents all its attached VMs, both running and stopped.

## Deleting a pool {#deleting-pool}

When you [delete](../operations/reserved-pools/delete-reserved-pool.md) a reserved instance pool, all VMs attached to it will be detached, and the running ones will continue to operate.

#### See also {#see-also}

* [{#T}](../operations/reserved-pools/create-reserved-pool.md)
* [{#T}](../operations/reserved-pools/update-reserved-pool.md)
* [{#T}](../operations/reserved-pools/delete-reserved-pool.md)
* [{#T}](../operations/reserved-pools/manage-pool-vms.md)