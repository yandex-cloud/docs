---
title: MongoDB backups
description: {{ mmg-short-name }} provides automatic and manual MongoDB database backups. Backups take up space in the storage allocated to the cluster. All cluster data is backed up once a day. You can't disable an automatic backup.
keywords:
  - backup
  - MongoDB backup
  - MongoDB
---

# Backups

{{ mmg-short-name }} provides automatic and manual database backups.

{{ mmg-name }} lets you restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup until the moment when the most recent oplog is archived. For this purpose, the backup selected as the starting point of recovery is updated with entries from the cluster oplog.

When creating backups and restoring data from them to a given point in time, keep in mind the following:

* The oplog is archived in a running cluster several times a minute and then uploaded to object storage.

* It takes some time to create and upload an oplog archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

For more information about PITR, see the [{{ MG }} documentation](https://docs.mongodb.com/database-tools/mongodump/#std-option-mongodump.--oplog).

To use PITR, the cluster must meet the following criteria:

* {{ MG }} version in the cluster: 4.2 or higher.
* [Sharding](../tutorials/sharding.md) is disabled. PITR works only for a cluster with a single replica set.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

Backups can be automatic or manual:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is backed up once a day. You can't disable an automatic backup. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Storage time](#storage).
* Backup start time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

After a backup is created, it's compressed for storage. To find out its exact size, request a [list of backups](../operations/cluster-backups.md#list-backups).

Backups are only created on running clusters. If you don't use a {{ mmg-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

To learn how to manually create a backup, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmg-name }}:

* Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/GnuPG){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/GNU_Privacy_Guard){% endif %}. Each cluster has its own encryption keys.

* Automatic backups are stored for {{ mmg-backup-retention }} days by default. When [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set a different storage period in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} days. Automatic backups are deleted when the storage period expires. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

* Manual backups are stored indefinitely. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see the [Pricing policy for {{ mmg-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

