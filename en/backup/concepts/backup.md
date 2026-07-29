---
title: Backups in {{ backup-full-name }}
description: In this tutorial, you will learn about backups in {{ backup-name }}.
---

# Backups

{% include [vm-running](../../_includes/backup/vm-running.md) %}


## Backup types {#types}

* A _full backup_ contains all data required to recover a [resource](./index.md#protected-resources). Resources recover faster from full backups than from incremental backups. However, full backups take up more storage space and take longer to create.
* An _incremental backup_ contains only data that is different from the previous backup of the resource. Resources take longer to recover from incremental backups than from full backups due to the use of chains of incremental backups. Incremental backups are made faster and take up less space than full backups. It is not advisable to use an incremental backup if there are many differences between two consecutive backups.

{% note tip %}

To take advantage of both types, combine them. For example, create two [backup policies](./policy.md) for the same VM: schedule weekly full backups in one policy and daily incremental backups in the other.

{% endnote %}

{% include [av-note](../../_includes/backup/av-note.md) %}

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

### Working with LVM {#lvm}

{{ backup-name }} allows creating resource backups with logical volumes managed by the subsystem [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)).

You should keep in mind the following when restoring resources from such backups:

{% list tabs group=backup_resource_type %}

- VM {#vm}

  * To restore a backup to the VM it was created for, you do not need to take any additional actions: the structure of LVM volumes should recover correctly.
  * Before restoring a backup to a different VM, make sure disk partitioning and LVM volume structure on the target VM is exactly the same as on the original one.

      {% note warning %}

      Restoring a backup with LVM volumes to a VM other than the original one does not guarantee successful restoration of the LVM volume structure.

      {% endnote %}

- Server {#baremetal-server}

  * To restore a backup to the same server it was created for, you do not need to take any additional actions: the LVM volume structure should recover correctly.
  * When restoring a backup to a server other than the original one, [request]({{ link-console-support }}/tickets/create) a special bootable [ISO image](https://en.wikipedia.org/wiki/Optical_disc_image) from support and load the target server from that image.

{% endlist %}

## Storing backups {#storage}

Backups created in {{ backup-name }} are stored in {{ objstorage-full-name }} internal buckets. 

Data in {{ objstorage-name }} is stored securely in compliance with the international and national standards. Learn more about security in {{ yandex-cloud }} in the [{#T}](../../security/conform.md) section of the document.

You cannot get access to backup files and buckets that store them. You can recover a resource from a backup only using {{ backup-name }}.

### Backup archives {#archives}

Backups are grouped into archives. A _backup archive_ is a total of all backups pertaining to one resource under a single backup policy.

By using archives, you can [delete](../operations/backup-vm/batch-delete.md) backups for outdated resources more efficiently. Furthermore, deleting backups as a whole archive reduces the load on the [{{ backup-name }} agent](./agent.md) and is less likely to cause errors than deleting them one by one.

## File-by-file recovery {#file-by-file}

With {{ backup-name }}, you can restore individual files and directories from a backup to any {{ compute-name }} VM or {{ baremetal-name }} server [connected](vm-connection/index.md) to the service. For more information, see [{#T}](../operations/backup-vm/recover-file-by-file.md).

## Use cases {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)

#### Useful links {#see-also}

{% include [see-also-snapshot](../../_includes/backup/see-also-snapshot.md) %}
