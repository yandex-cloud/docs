---
title: How to create a disk snapshot
description: Follow this guide to create a disk snapshot.
---

# Creating a disk snapshot


A _disk snapshot_ is a copy of the disk file system at a specific point in time.

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

## Preparation steps {#prepare}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

## Creating a snapshot {#create}

{% note info %}

The disk snapshot you create will get assigned the [virtualized hardware generation](../../concepts/hardware-generations.md) on which a VM instance can be deployed from this snapshot. You can assign to a snapshot a generation different from the one assigned to the source disk using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml), [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md), or [API](../../../api-design-guide/index.yaml).

{% endnote %}

To create a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

HDD or SSD snapshots are created asynchronously. The snapshot is created as soon as you run the create command and gets the `Creating` status. You can now resume writing data to the disk, as further disk operations will not affect the data in the snapshot.

Once the snapshot creation is complete, the snapshot status will change to `Ready`. You can now use the snapshot to create images, disks, and more.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

To avoid this, attach the disk to the VM and change all duplicate UUIDs. For more information, see [Attaching a disk to a VM](../vm-control/vm-attach-disk.md).

{% endnote %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [{#T}](../disk-create/from-snapshot.md)
