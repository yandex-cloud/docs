# Disks

_A disk_ is a virtual version of physical storage devices, such as SSD and HDD.

Disks are designed for storing data. They are attached to VMs to work with them. If you detach a disk, its data is not deleted.

Each disk is located in one of the availability zones and is not automatically replicated to other zones.

## Disks as Yandex.Cloud resources {#disk-as-resource}

A disk is created within a folder and inherits its access rights.

Disks use storage capacity that incurs additional fees. For more information, see [#T](../pricing.md). The size of a disk is specified when creating it. This is the capacity that you are charged for.

If a disk is created from a snapshot or image, the disk information contains the ID of the source resource. In addition, the license IDs are inherited from the source resource (`product_ids`), which are used to calculate the cost of disk usage.

## Disk types {#disks_types}

In Yandex.Cloud, there are two types of disks:

- Fast network disks (`network-nvme`) — network block storage on an SSD connected via the NVMe interface.
- Standard network disks (`network-hdd`) — network block storage on an HDD.

The availability zone affects which types of disks you can create in it.

## Attaching and detaching disks {#attach-detach}

Each disk can only be attached to one VM. The disk and VM must be located in the same availability zone.

You need to attach a boot disk to a VM, and additional attached disks are optional.

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When you select a disk to attach to a VM, you can specify whether the disk should be deleted along with the VM. You can choose this option when creating a VM, updating it, or attaching a new disk to it.

If previously created disks are attached to the VM, they will be detached when the VM is deleted. The disk data is preserved and this disk can be attached to another VM in the future.

If you want a disk to be deleted with a VM, specify this during one of the following operations: when creating the VM, updating it, or attaching the disk to it. Such disks will be deleted when you delete the VM.

## Backup {#backup}

Each disk is automatically replicated within its availability zone to ensure reliable data storage.

You can also create disk snapshots for backup purposes. A disk snapshot is automatically replicated to multiple availability zones. This allows changing the availability zone without losing any of the disk data.

If you need to frequently create a disk from its backup, you can create an image of the disk to speed up recovery. This can be done if you have created a boot disk for your OS and want to install it on other VMs. A disk image is also automatically replicated to multiple availability zones.

