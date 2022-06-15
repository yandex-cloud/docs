# Disk snapshots

A _disk snapshot_ in {{ yandex-cloud }} is a copy of the disk file system at a certain point in time.

You can use disk snapshots for various purposes, such as:

* Transferring data from one disk to another, for example, to a disk in a different availability zone.
* Creating a disk backup before performing operations that may cause damage to your data.
* Performing disk versioning by regularly creating snapshots of the disk.

{% note info %}

If you need to create multiple disks with the same content, use [images](image.md). Disk creation from an image is faster than from a snapshot.

{% endnote %}

## A disk snapshot as a {{ yandex-cloud }} resource {#concept_pdw_xtc_v2b}

A disk snapshot is a resource like the disk itself. Snapshots are created in a folder. Access rights to a snapshot are inherited from rights to the folder.

Snapshots take up space in the storage so additional fees are charged for storing them. For more information, see [{#T}](../pricing.md).

Snapshot information contains the ID of the disk from which the snapshot was created. In addition, the license IDs (`product_ids`) are inherited from the source resource, which are used to calculate the disk use cost.

## Backups {#backup}

Snapshots are stored in {{ ydb-full-name }}, replicated in multiple availability zones, and encrypted at the database level.

Snapshot storage time is unlimited. To make sure you don't overpay, delete unused snapshots.

### Checking backups {#verify}

#### Checking backup integrity {#integrity}

The checksum is stored for blocks in the snapshot. This checksum is checked when creating a disk from a snapshot.

#### Checking backup recovery {#capabilities}

To test disk recovery from a snapshot, [create a VM with a disk from a snapshot](../operations/vm-create/create-from-snapshots.md) and check the integrity of your data.
