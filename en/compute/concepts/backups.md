---
title: "Backups in {{ compute-full-name }}"
description: "Backups of data in images, snapshots, and disks that are not attached to instances are stored securely and replicated within the {{ yandex-cloud }} infrastructure. To back up the data from disks attached to an instance, create snapshots of the disks on a regular basis."
keywords:
  - backup
  - database backup
  - backups
  - data backups
---

# Backups in {{ compute-name }}

Data contained in images, snapshots, and disks that are not attached to VMs is stored securely and replicated within the {{ yandex-cloud }} infrastructure.

To back up the data from disks attached to VMs, you need to create disk snapshots on a regular basis. You can do this both [manually](../operations/disk-control/create-snapshot.md) and automatically, [on schedule](snapshot-schedule.md).

To restore a VM from a disk snapshot, you can:
* Create a new disk from a snapshot, and then [attach the created disk](../operations/vm-control/vm-attach-disk.md) to a VM.
* Create a new VM [from a set of snapshots](../operations/vm-create/create-from-snapshots.md). In the operation parameters, you can specify both boot and regular disk snapshots.

{% include [boot-disk-recover](../../_includes/compute/boot-disk-recover.md) %}