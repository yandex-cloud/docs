# Disk snapshots

A _disk snapshot_ in {{ yandex-cloud }} is a copy of the disk file system at a certain point in time.

You can use disk snapshots for various purposes, such as:

* Transferring data from one disk to another, for example, to a disk in a different availability zone.
* Creating a disk backup before performing operations that may cause damage to your data.
* Performing disk versioning by regularly creating snapshots of the disk.

{% note info %}

If you need to create multiple disks with the same content, use [images](image.md). Disk creation from an image is faster than from a snapshot.

{% endnote %}

A disk snapshot only contains the data that was already written to the disk when the snapshot was created. If the disk is attached to a running VM, the cache of the apps and OS will not be included in the snapshot. For more information about preparing a VM for the creation of a disk snapshot and ensuring the integrity of the snapshot data, see the [instructions](../operations/disk-control/create-snapshot.md#prepare).

You can create disk snapshots manually or automatically, according to the [schedule](snapshot-schedule.md).

A single snapshot can be created for one disk at a time.


## A disk snapshot as a {{ yandex-cloud }} resource {#snapshot-as-resource}

A disk snapshot is a resource like the disk itself. Snapshots are created in a folder. Access rights to a snapshot are inherited from rights to the folder.

A snapshot takes some space in the storage, it is kept indefinitely. Storage of snapshots is charged additionally. To make sure you don't overpay, delete unused snapshots. For more information, see [{#T}](../pricing.md).

Snapshot information contains the ID of the disk from which the snapshot was created. In addition, the license IDs (`product_ids`) are inherited from the source resource, which are used to calculate the disk use cost.


## Reliable and secure snapshot storage {#reliability-and-security}

Snapshots are stored in {{ ydb-full-name }}, replicated in multiple availability zones, and encrypted at the database level.

The checksum is stored for blocks in the snapshot. This checksum is checked when creating a disk from a snapshot.

To test disk recovery from a snapshot, [create a VM with a disk from a snapshot](../operations/vm-create/create-from-snapshots.md) and check the integrity of your data.

#### See also {#see-also}

* [Instructions for disk snapshots and schedules](../operations/#snapshots)
