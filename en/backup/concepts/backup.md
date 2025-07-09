---
title: Backups in {{ backup-full-name }}
description: In this tutorial, you will learn about backups in {{ backup-name }}.
---

# Backups

{% include [vm-running](../../_includes/backup/vm-running.md) %}


## Backup types {#types}

* _Full backup_ contains all the data required to recover a VM or {{ baremetal-full-name }} server. VMs and {{ baremetal-name }} servers recover faster from full backups than from incremental backups. However, full backups take up more storage space and take longer to create.
* _Incremental backup_ contains only data that is different from the previous VM or {{ baremetal-name }} server backup. VMs and servers take longer to recover from incremental backups than from full backups because of the use of chains of incremental backups. Incremental backups are made faster and take up less space than full backups. It is not advisable to use an incremental backup if there are many differences between two consecutive backups.

{% include [av-note](../../_includes/backup/av-note.md) %}

You cannot restore a VM backup to a {{ baremetal-name }} server or a {{ baremetal-name }} server backup to a VM.

{% note tip %}

To take advantage of both types, combine them. For example, create two [backup policies](policy.md) for the same VM or {{ baremetal-name }} server: schedule weekly full backups in one policy and daily incremental backups in the other.

{% endnote %}

### Working with LVM {#lvm}

{{ backup-name }} allows creating VM and {{ baremetal-name }} server backups with logical volumes managed by the subsystem [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)).

You should keep in mind the following when restoring VMs and {{ baremetal-name }} servers from such backups:

{% list tabs group=backup_resource_type %}

- VM {#vm}

  * To restore a backup to the VM it was created for, you do not need to take any additional actions: the structure of LVM volumes should recover correctly.
  * Before restoring a backup to a different VM, make sure disk partitioning and LVM volume structure on the target VM is exactly the same as on the original one.

      {% note warning %}

      Restoring a backup with LVM volumes to a VM other than the original one does not guarantee successful restoration of the LVM volume structure.

      {% endnote %}

- {{ baremetal-name }} server {#baremetal-server}

  * To restore a backup to the same server it was created for, you do not need to take any additional actions: the LVM volume structure should recover correctly.
  * When restoring a backup to a server other than the original one, [request]({{ link-console-support }}/tickets/create) a special bootable [ISO image](https://en.wikipedia.org/wiki/Optical_disc_image) from support and load the target server from that image.

{% endlist %}

## Storing backups {#storage}

Backups created in {{ backup-name }} are stored in {{ objstorage-full-name }} internal buckets. 

Data in {{ objstorage-name }} is stored securely in compliance with the international and national standards. Learn more about security in {{ yandex-cloud }} in the [{#T}](../../security/conform.md) section of the document.

You cannot get access to backup files and buckets that store them. {{ backup-name }} is your only option to restore a VM or {{ baremetal-name }} server from a backup.

### Backup archives {#archives}

Backup copies are grouped into archives. A _backup archive_ includes all backups created for one VM or {{ baremetal-name }} server under a single backup policy.

By using archives, you can [delete](../operations/backup-vm/batch-delete.md) backups for outdated resources more efficiently. Furthermore, deleting backups as a whole archive reduces the load on the [{{ backup-name }} agent](./agent.md) and is less likely to cause errors than deleting them one by one.

## File-by-file recovery {#file-by-file}

With {{ backup-name }}, you can restore individual files and directories from a backup to any VM [connected](vm-connection.md) to the service. For more information, see [{#T}](../operations/backup-vm/recover-file-by-file.md).

File-by-file recovery to {{ baremetal-name }} servers is currently not available.


## Use cases {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)