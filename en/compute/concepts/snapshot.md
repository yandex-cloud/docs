# Disk snapshots

_A disk snapshot_ in Yandex.Cloud is a copy of the disk file system at a certain point in time.

You can use disk snapshots for various purposes, such as:

- Transferring data from one disk to another, for example, to a disk in a different availability zone.
- Creating a disk backup before performing operations that may cause damage to your data.
- Performing disk versioning by regularly creating snapshots of the disk.

> [!NOTE]
>
> If you need to create multiple disks with identical content, use [images](images.md). Disk creation from an image is faster than from a snapshot.

## A disk snapshot as a Yandex.Cloud resource {#concept_pdw_xtc_v2b}

A disk snapshot is a resource like the disk itself. Snapshots are created in a folder. Access rights to a snapshot are inherited from rights to the folder.

Snapshots take up space in the storage so additional fees are charged for storing them. For more information, see the section [[!TITLE]](../pricing.md).

Snapshot information contains the ID of the disk from which the snapshot was created. In addition, the license IDs are inherited from the source resource (`product_ids`), which are used to calculate the cost of disk usage.

## Backup {#backup}

Each snapshot is automatically replicated across multiple availability zones to ensure reliable data storage.

