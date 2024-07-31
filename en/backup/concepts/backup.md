---
title: "Backups in {{ backup-full-name }}"
description: "In this tutorial, you will learn about backups in {{ backup-name }}."
---

# Backups

{% include [vm-running](../../_includes/backup/vm-running.md) %}

## Backup types {#types}

* _Full backups_ contain all data required for VM recovery. VMs recover faster from full backups than from incremental backups. However, full backups take up more storage space and it takes longer to create them.
* _Incremental backups_ only contain data that differs from a previous VM backup. It takes longer to restore VMs as compared to recovery from full backups due to using a chain of incremental backups. Incremental backups are faster and take up less space than full backups. It is not cost-effective to use incremental backups if two consecutive backups are significantly different.

{% note tip %}

To take advantage of both types, combine them. For example, set two [backup policies](policy.md) for a single VM: schedule weekly full backups in one policy and daily incremental backups in the other.

{% endnote %}

## Storing backups {#storage}

Backups created in {{ backup-name }} are stored in {{ objstorage-full-name }} internal buckets.

Data in {{ objstorage-name }} is stored securely in compliance with the international and national standards. Learn more in the [{#T}](../../security/conform.md) section of the document about security in {{ yandex-cloud }}.

You cannot get access to backup files and buckets that store them. VMs can only be recovered from backups using {{ backup-name }} tools.

## File-by-file recovery {#file-by-file}

With {{ backup-name }}, you can restore individual files and directories from a backup to any VM [connected](vm-connection.md) to the service. For more information, see [{#T}](../operations/backup-vm/recover-file-by-file.md).
