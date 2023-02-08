---
title: "Backups in {{ compute-full-name }}"
description: "Backups of data in images, snapshots, and disks that aren't attached to instances are stored securely and replicated within the Yandex Cloud infrastructure. To back up the data from disks attached to an instance, create snapshots of the disks from time to time."
keywords:
  - backup
  - backups
  - data backups
---

# Backups in {{ compute-name }}

Data in images, snapshots, and disks that aren't attached to instances is stored securely and replicated within the {{ yandex-cloud }} infrastructure.

To back up the data from disks attached to an instance, create snapshots of the disks from time to time — do this [manually](../operations/disk-control/create-snapshot.md) or automatically, according to the [schedule](snapshot-schedule.md).

You can restore an instance from a snapshot of the disk you need in the following ways:
* Create a new disk from a snapshot, then [attach the created disk](../operations/vm-control/vm-attach-disk.md) to an instance.
* Create a new instance [from a set of snapshots](../operations/vm-create/create-from-snapshots.md). In the operation parameters, you can specify snapshots as both boot and regular disks.