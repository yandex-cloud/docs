---
title: Backups in {{ mgp-full-name }}
description: In this tutorial, you will learn about {{ mgp-name }} backups and how to create and store them.
---

# Backups in {{ mgp-name }}


{{ mgp-short-name }} supports automatic and manual database backups.

{{ mgp-short-name }} enables you to restore your cluster to a specific _recovery point_ where the data is consistent. This feature is known as Point-in-Time-Recovery (PITR). Recovery points are created every hour. When you specify a time to recover data for, the service will use the backup closest to that point in time. When recovering the selected cluster backup, records from write-ahead logs (WALs) will be added to the backup data up to the closest recovery point.

For example, if the backup was created on November 10, 2022, 12:00:00 UTC, the current date is November 15, 2022, 19:00:00 UTC, and the latest recovery point was saved on November 15, 2022, 18:00:00 UTC, the cluster can be restored to any recovery point between November 10, 2022, 12:00:01 UTC and November 15, 2022, 18:00:00 UTC, inclusive. If you specify November 15, 2022, 17:30:00 UTC as the recovery time, the cluster will be restored to the recovery point saved on November 15, 2022, 17:00:00 UTC.

PITR mode is enabled by default. It supports automatic backups only.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore). You can also restore your cluster to move its hosts to a different availability zone.

## Creating a backup {#size}

The first and every second automatic backup, as well as all manually created backups are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

A backup is automatically created every day. You cannot disable automatic backups. However, for such backups, you can specify a time interval during which the backup will start when you [create](../operations/cluster-create.md) or [update](../operations/update.md#change-additional-settings) a cluster. Default time: `22:00 - 23:00` UTC (Coordinated Universal Time).

After a backup is created, it is compressed for storage. Append-optimized tables use data deduplication technology: newly added data or old data last archived more than 30 days ago is copied. The backup size does not include the deduplicated part size, so the displayed value can be significantly smaller than the data size in the cluster.

Backups are only created on running clusters. If you are not using your {{ mgp-short-name }} cluster 24/7, check the [settings of backup start time](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md#create-backup).

## Storing backups {#storage}

Storing backups in {{ mgp-name }}:

* Backups are stored in object storage as binary files and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

* Automatic backups are stored for seven days. Manual backups are stored until the user deletes them manually.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.

## Use cases {#examples}

* [{#T}](../operations/cluster-backups.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
