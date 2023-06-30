---
title: "{{ PG }} backups"
description: "{{ mpg-short-name }} provides automatic and manual {{ PG }} database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created every day."
keywords:
  - backup
  - database backup
  - backups
  - PostgreSQL backups
  - backup PostgreSQL
  - PostgreSQL
---

# Backups in {{ mpg-name }}

{{ mpg-short-name }} provides automatic and manual database backups.

{{ mpg-name }} allows you to restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. This is achieved by supplementing the backup selected as the starting point for recovery with entries from the write-ahead logs (WAL) of later cluster backups.

For example, if the backup operation on ended August 10, 2020, 12:00 p.m. UTC, the current date is August 15, 2020, 7:00 p.m. UTC, and the latest write ahead log was saved on August 15, 2020, 6:50 p.m. UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 p.m. UTC and August 15, 2020, 6:50:00 p.m. UTC, inclusive.

PITR is enabled by default.

When creating backups and restoring data from them to a given point in time, keep the following in mind:

* WAL consists of 16 MB files that are archived in a running cluster when the required size is reached or if the time specified by the [archive timeout](./settings-list.md#setting-archive-timeout) cluster-level DBMS setting has passed since a file was last archived. The archive is then uploaded to object storage.

* It takes some time to create and upload a WAL archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

You can learn more about PITR in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/continuous-archiving.html).

To restore a cluster from a backup, [follow this guide](../operations/cluster-backups.md#restore).

## Creating backups {#size}

The first and every seventh automatic backups as well as all manually created backups are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is backed up once a day. You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Backup start time. By default, the backup process starts at 10 p.m. UTC. The backup will start within 30 minutes of the specified time.

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

Backups are only created on running clusters. If you do not use a {{ mpg-short-name }} cluster 24/7, check the [backup start time settings](../operations/update.md#change-additional-settings). A cluster that has no backups cannot be [stopped](../operations/cluster-stop.md#stop-cluster).

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

## Storing backups {#storage}

Specifics of storing backups in {{ mpg-name }}:

* Backups are stored in object storage as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mpg/backup-wal.md) %}

* The retention time for backups of an existing cluster depends on the method used to create such backups:

   * Automatic backups are stored for 7 days by default. When [creating](../operations/cluster-create.md) a cluster or [editing](../operations/update.md#change-additional-settings) its settings, you can specify a different retention period of between 7 and 60 days.

   * Manually created backups are stored with no time limit.

* Once you delete a cluster, all its backups persist for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [{{ mpg-name }} pricing policy](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
