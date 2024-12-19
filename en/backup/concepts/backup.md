---
title: Backups in {{ backup-full-name }}
description: In this tutorial, you will learn about backups in {{ backup-name }}.
---

# Backups

{% include [vm-running](../../_includes/backup/vm-running.md) %}

{% include [baremetal-note-extended](../../_includes/backup/baremetal-note-extended.md) %}

## Backup types {#types}



* _Full backup_ contains all the data required to recover a VM or {{ baremetal-full-name }} server. VMs and {{ baremetal-name }} servers recover faster from full backups than from incremental backups. However, full backups take up more storage space and take longer to create.
* _Incremental backup_ contains only data that is different from the previous VM or {{ baremetal-name }} server backup. VMs and servers take longer to recover from incremental backups than from full backups because of the use of chains of incremental backups. Incremental backups are made faster and take up less space than full backups. It is not advisable to use an incremental backup if there are many differences between two consecutive backups.

You cannot restore a VM backup to a {{ baremetal-name }} server, nor restore a {{ baremetal-name }} server backup to a VM.

{% note tip %}

To take advantage of both types, combine them. For example, create two [backup policies](policy.md) for the same VM or {{ baremetal-name }} server: schedule weekly full backups in one policy and daily incremental backups in the other.

{% endnote %}

## Storing backups {#storage}

Backups created in {{ backup-name }} are stored in {{ objstorage-full-name }} internal buckets.

Data in {{ objstorage-name }} is stored securely in compliance with the international and national standards. Learn more about security in {{ yandex-cloud }} in the [{#T}](../../security/conform.md) section of the document.

You cannot get access to backup files and buckets that store them. {{ backup-name }} is your only option to restore a VM or {{ baremetal-name }} server from a backup.

## File-by-file recovery {#file-by-file}

With {{ backup-name }}, you can restore individual files and directories from a backup to any VM [connected](vm-connection.md) to the service. For more information, see [{#T}](../operations/backup-vm/recover-file-by-file.md).

File-by-file recovery to {{ baremetal-name }} servers is currently not available.