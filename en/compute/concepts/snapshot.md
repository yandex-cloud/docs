# Disk snapshots

In {{ yandex-cloud }}, a _disk snapshot_ is a copy of the disk file system made at a certain point in time.

You can use disk snapshots for various purposes, such as:

* Migrating data from one disk to another, for example, to a disk in a different availability zone.
* Creating a disk backup before performing operations that may damage your data.
* Performing disk versioning by creating snapshots on a regular basis.

{% note info %}

If you need to create multiple disks with the same content, you can use [images](image.md). Creating disks from images is faster than doing so from snapshots.

{% endnote %}

A disk snapshot only contains the data that had already been written to the disk when the snapshot was created. If the disk is attached to a running VM, the OS and app cache will not be included in the snapshot. For more information about preparing a VM for disk snapshot creation and ensuring the integrity of the snapshot data, see [this guide](../operations/disk-control/create-snapshot.md#prepare).

You can create disk snapshots both manually and automatically, based on a [schedule](snapshot-schedule.md).

A single snapshot can only be created for one disk at a time.

{% include [snapshot-disk-types](../../_includes/compute/snapshot-disk-types.md) %}

{% include [boot-disk-recover](../../_includes/compute/boot-disk-recover.md) %}

## Disk snapshot as a {{ yandex-cloud }} resource {#snapshot-as-resource}

A disk snapshot is a resource, just like a disk itself. Snapshots are stored in a folder. Access rights to a snapshot are inherited from those to the folder.

A snapshot takes some space in the storage and is kept for an indefinite period of time. Snapshot storage is charged separately. To avoid unnecessary costs, delete unused snapshots. For more information, see [{#T}](../pricing.md).

Snapshot information contains the ID of the disk from which the snapshot was created. The license IDs (`product_ids`) used to calculate the disk use cost are also inherited from the source.


## Reliable and secure snapshot storage {#reliability-and-security}

Snapshots are stored in {{ ydb-full-name }}, replicated in multiple availability zones, and encrypted at the database level.

The checksum is stored for blocks in the snapshot. This checksum is checked when creating a disk from a snapshot.

To test disk recovery from a snapshot, [create a VM with a snapshot disk](../operations/vm-create/create-from-snapshots.md) and check the integrity of your data.


## Encrypting snapshots {#encryption}

To protect critical data in {{ compute-name }}, we recommend encrypting snapshots with [{{ kms-full-name }}](../../kms/) keys.

For more information, see [{#T}](encryption.md).


#### See also {#see-also}

* [Guides on disk snapshots and schedules](../operations/#snapshots)
* [{#T}](../operations/disk-create/from-snapshot.md)
