# Backups

## Backup types {#types}

* _Full backups_ contain all data required for VM recovery. They're more reliable than incremental backups: if you delete one full backup, a VM can be restored from another one.
* _Incremental backups_ only contain data that differs from a previous VM backup. A VM is restored from a chain of incremental backups. Incremental backups are faster and take up less space than full backups.

{% note tip %}

To take advantage of both types, combine them. For example, set two [backup policies](policy.md) for a single VM: schedule weekly full backups in one policy and daily incremental backups in the other.

{% endnote %}

## Storing backups {#storage}

Backups created in {{ backup-name }} are stored in {{ objstorage-full-name }} internal buckets.

Data in {{ objstorage-name }} is stored securely in compliance with the international and national standards. Learn more in the [{#T}](../../security/conform.md) section of the document about security in {{ yandex-cloud }}.

One can't get access to backup files and buckets that store them. VMs can only be restored from backups using {{ backup-name }} tools.