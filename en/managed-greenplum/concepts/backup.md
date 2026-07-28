---
title: Backups in {{ mgp-full-name }}
description: In this tutorial, you will learn about {{ mgp-name }} backups and how to create and store them.
---

# Backups in {{ mgp-name }}


{{ mgp-short-name }} supports automatic and manual database backups.

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore). You can also restore your cluster to move its hosts to a different availability zone.

## Creating a backup {#size}

The first and every second automatic backup, just as all manual backups, are full backups of all databases. To save space, other backups are incremental and only store data that has changed from the previous backup.

A backup is automatically created once a day. You cannot disable automatic backups. However, for such backups, you can specify a time interval during which the backup will start when you [create](../operations/cluster-create.md) or [update](../operations/update.md#change-additional-settings) a cluster. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Once created, a backup is compressed for storage. Append-optimized tables use data deduplication technology: newly added data or old data last archived more than 30 days ago is copied. The backup size does not include the deduplicated part size, so the displayed value can be significantly smaller than the data size in the cluster.

Backups are only created on running clusters. If you are not using your {{ mgp-name }} cluster 24/7, check the [settings of backup start time](../operations/update.md#change-additional-settings).

Learn about creating manual backups in [Managing backups](../operations/cluster-backups.md#create-backup).

## Storing a backup {#storage}

Storing backups in {{ mgp-name }}:

* Backups are stored in object storage as binary files and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

* Automatic backups are stored for seven days. Manual backups are stored until the user deletes them manually.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Recovery from a backup {#capabilities}

Restoring a cluster from a backup creates a new cluster with that backup’s data. You need to specify all the cluster's settings, just as when creating a new cluster. If your folder lacks [resources](../concepts/limits.md) to create such a cluster, you will not be able to recover it from a backup.

You can also use backup recovery to move {{ mgp-name }} cluster hosts between availability zones. Do it by specifying a new availability zone when recovering. If your cluster operates as a [{{ data-transfer-full-name }} endpoint](../../data-transfer/concepts/index.md#endpoint), create the [endpoint](../../data-transfer/operations/endpoint/index.md#create) and [transfer](../../data-transfer/operations/transfer.md#create) again after restoring the cluster from a backup.

If you set the current time as the restore time, the new cluster will match the state of the latest available restore point.

{% include [advice-backup](../../_includes/mdb/advice-backup.md) %}

### Limits {#limits}

When restoring a cluster from a backup, there will be restrictions on the new cluster's configuration:

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}

## PITR in {{ mgp-name }} {#pitr-details}

{{ mgp-short-name }} enables you to restore your cluster to a specific _recovery point_ where the data is consistent. This feature is known as Point-in-Time-Recovery (PITR). Recovery points are created every hour. When you specify a time to recover data for, the service will use the backup closest to that point in time. When recovering the selected cluster backup, records from write-ahead logs (WALs) will be added to the backup data up to the closest recovery point.

> For example, if the backup was created on November 10, 2022, 12:00:00 UTC, the current date is November 15, 2022, 19:00:00 UTC, and the latest recovery point was saved on November 15, 2022, 18:00:00 UTC, the cluster can be restored to any recovery point between November 10, 2022, 12:00:01 UTC and November 15, 2022, 18:00:00 UTC, inclusive. If you specify November 15, 2022, 17:30:00 UTC as the recovery time, the cluster will be restored to the recovery point saved on November 15, 2022, 17:00:00 UTC.

PITR mode is enabled by default. It only supports automatic backups.

## Use cases {#examples}

* [{#T}](../operations/cluster-backups.md)
