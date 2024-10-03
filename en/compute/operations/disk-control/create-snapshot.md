---
title: How to create a disk snapshot
description: Follow this guide to create a disk snapshot.
---

# Creating a disk snapshot


A _disk snapshot_ is a copy of the disk file system at a specific point in time.

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

## Setup {#prepare}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

## Creating a snapshot {#create}

To create a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

An HDD or SSD snapshot is created asynchronously. The snapshot is created as soon as you run the create command and gets the `Creating` status. From this point on, you can resume writing data to disk, and disk operations will not affect the data in the snapshot.

Once the snapshot creation is completed, its status will change to `Ready`. From this point on, you can use the snapshot to create images, populate disks, and so on.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

To avoid this, attach the disk to the VM and change all the duplicate UUIDs. For more information, see the [guide on attaching a disk](../vm-control/vm-attach-disk.md).

{% endnote %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [{#T}](../disk-create/from-snapshot.md)
