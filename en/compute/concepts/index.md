# Relationships between resources in {{ compute-full-name }}

All resources in {{ compute-short-name }} can be divided into three types:

* _Basic_ resources including [virtual machines](vm.md) and [disks](disk.md).
* _Auxiliary_ resources including [snapshots](snapshot.md) and [images](image.md). These resources are only used for creating other resources.
* _Information_ resources such as disk type and availability zone. These resources are read-only.

In addition, when creating VMs, resources of other services are used, such as subnets and folders.

## Basic resources {#basic-resource}

{{ compute-short-name }} allows you to create VMs and attach disks to them.

At least one disk must be connected to a VM, that is, a boot disk. A disk can be restored from a snapshot and image or created empty.

## Auxiliary resources {#auxillary-resource}

Snapshots and images are mainly designed for saving and restoring data disks.

A snapshot can only be created from a disk. Snapshot information contains the ID of its source disk.

An image can be created from a disk, snapshot, another image, or file.

## Information resources {#information-resource}

When creating disks and VMs, you should specify the [availability zone](../../overview/concepts/geo-scope.md) where they will reside (disk images and snapshots are not associated with any availability zones).

You can view a list of availability zones and find out their current status.

When creating a disk, you also specify the disk type. You can view possible disk types and find out in which zones they are available.

## Relationship with resources of other services {#relationship-with-resources-of-other-services}

When creating a VM, you specify the subnet to which it will be connected. [For more information about cloud networks, see](../../vpc/concepts/network.md).

All {{ compute-short-name }} resources are created within folders. Disk types and availability zones are public resources that do not belong to any folder. [Learn more about the resource hierarchy in {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).
