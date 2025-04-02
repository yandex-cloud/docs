---
title: Backups in {{ compute-full-name }}
description: Backups of data in images, snapshots, and disks that are not attached to instances are stored securely and replicated within the {{ yandex-cloud }} infrastructure. To back up the data from disks attached to an instance, create snapshots of the disks on a regular basis.
keywords:
  - back up
  - database backup
  - backup
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


## Comparison with backups in {{ backup-name }} {#backup-comparison}

In {{ backup-name }}, you can create [full and incremental backups](../../backup/concepts/backup.md#types) of virtual machines along with boot disks and restore VMs from these backups. VM backups are application-consistent: they save not only the data stored on disks but also the data already sent but not yet fully written.

{% include [av-note](../../_includes/backup/av-note.md) %}

With {{ backup-name }}, you can [restore](../../backup/operations/backup-vm/recover-file-by-file.md) individual files and directories from a backup.

To enable backups on a VM, [connect](../../backup/concepts/vm-connection.md) the VM to {{ backup-name }} and [link](../../backup/operations/policy-vm/update.md#update-vm-list) it to a backup [policy](../../backup/concepts/policy.md). The provider must [support](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html) the VM operating system.

{% include [backup-image-snapshot-comparison](../../_includes/backup-image-snapshot-comparison.md) %}
