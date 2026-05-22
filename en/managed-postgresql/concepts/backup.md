---
title: '{{ PG }} backups'
description: '{{ mpg-short-name }} supports automatic and manual {{ PG }} database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created once a day.'
keywords:
  - backups
  - back up
  - backup
  - backing up
  - '{{ PG }} backups'
  - backup {{ PG }}
  - '{{ PG }}'
---

# Backups in {{ mpg-name }}

{{ mpg-short-name }} supports automatic and manual database backups.

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Creating a backup {#size}

The first and every seventh automatic backups as well as all manually created backups are full backups of all databases. To save space, other backups are incremental and only store the data that has changed since the previous backup.

Both full and incremental backups are created using the [wal-g](https://wal-g.readthedocs.io/PostgreSQL/) utility. The _Point-in-Time Recovery_ (PITR) is implemented using data from Write Ahead Logs (WAL). For more information, see [{#T}](#pitr-details).

To reduce the load on the master, the backup data is taken from a replica.

{% note warning %}

The WAL that [goes to replicas](replication.md#write-sync-and-read-consistency) does not contain the changes made to the [UNLOGGED]({{ pg.docs.org }}/current/sql-createtable.html#SQL-CREATETABLE-UNLOGGED) and [TEMP]({{ pg.docs.org }}/current/sql-createtable.html#SQL-CREATETABLE-TEMPORARY) tables; therefore, data from these tables is not added to the backup. The `UNLOGGED` and `TEMP` tables store their data only until the [master is switched manually](../operations/update.md#start-manual-failover) or restarted.

{% endnote %}

All cluster data is automatically backed up once a day. You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Time interval during which the backup starts. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Once created, a backup is compressed for storage. The exact backup size is not displayed.

Backups are only created on running clusters. If you are not using your {{ mpg-short-name }} cluster 24/7, check the [settings of backup start time](../operations/update.md#change-additional-settings). A cluster that has no backups cannot be [stopped](../operations/cluster-stop.md#stop-cluster).

Learn about creating manual backups in [Managing backups](../operations/cluster-backups.md).

{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

## Storing a backup {#storage}

Storing backups in {{ mpg-name }}:

* Backups are stored in object storage as binary files and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mpg/backup-wal.md) %}

* The retention time for backups of an existing cluster depends on the way they were created:

    * Automatic backups are stored for 7 days by default. When [creating](../operations/cluster-create.md) or [reconfiguring](../operations/update.md#change-additional-settings) a cluster, you can specify a different retention period between 7 and 60 days.

    * Automatic backups [created](../operations/backup-retention-policies.md) with backup policies can be stored from 7 to 1095 days (up to three years).

    * Manual backups are stored with no time limit.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [{{ mpg-name }} pricing policy](../pricing.md#rules-storage).

## Recovery from a backup {#restore}

By restoring a cluster from a backup, you create a new cluster. You need to specify all the cluster's settings, just as when creating a new cluster. If your folder lacks [resources](limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

The cluster is restored to a selected point in time using [PITR](#pitr-details). The new cluster will reflect the state of:

* Existing cluster at the time of archiving the most recent WAL.
* Deleted cluster at the time of archiving the last WAL.

When restored from a backup, the cluster is recovered as a whole, with all its databases. You cannot select specific databases.

{% note tip %}

Periodically test the recovery of production system clusters. Verify data integrity in the restored cluster.

{% endnote %}

## PITR in {{ mpg-name }} {#pitr-details}

{{ mpg-name }} allows you to restore the cluster state to any point in time (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. For this purpose, the backup selected as the recovery starting point is updated with archived entries from the WAL logs.

> For example, if the backup operation ended on August 10, 2020 at 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the most recent WAL was saved on August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC, inclusive.

WAL consists of 16 MB files that are archived in a running cluster when the required size is reached or if the time specified by the [archive timeout](./settings-list.md#setting-archive-timeout) cluster-level DBMS setting has passed since a file was last archived. The archive is then uploaded to object storage.

{% note warning %}

It takes some time to create and upload a WAL archive to object storage. This is why the cluster state saved in the object storage may differ from the actual one.

{% endnote %}

PITR is enabled by default.

For more information about PITR, see [this {{ PG }} guide]({{ pg.docs.org }}/current/continuous-archiving.html).
