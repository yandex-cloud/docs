# Resolving issues with disk and network input/output performance on a VM


## Issue description {#issue-description}

* Services on a VM are running too slow, although the `Load Average` values and CPU usage levels are small.
* The VM monitoring charts show an increase in the number of deferred disk operations.

## Solution {#issue-resolution}

When the VM's disk subsystem operation exceeds the service limits at any given time, this triggers [throttling](../../../compute/concepts/storage-read-write.md#throttling), resulting in decreased performance of services running on the VM.

Check the VM's internal monitoring data for many deferred disk operations and reaching the [technical write limits](../../../compute/concepts/limits.md#limits-disks). You can use the `iotop` utility to analyze disk subsystem metrics for Linux VMs, or Sysinternals DiskMon for Windows VMs.

In {{ yandex-cloud }}, the VM disk performance directly depends on its size:

* If `IOWait` values reach tens of percent under load for a long period, increase the disk size to the next [placement unit](../../../compute/concepts/storage-read-write.md) threshold.
* If that did not help, change the storage type to SSD. With each 32 GB increment, the number of placement units increases and the disk subsystem performance improves.

{% note warning %}

You can only select the storage type when creating a VM. 

You can take a [disk snapshot](../../../compute/operations/disk-control/create-snapshot.md) and then [create a new VM from this snapshot](../../../compute/operations/vm-create/create-from-snapshots.md) with `network-ssd`.

{% endnote %}