# Backups in {{ mgp-name }}

{{ mgp-short-name }} provides automatic database backups.

{{ mgp-short-name }} enables you to restore your cluster to a specific _recovery point_ where the data is consistent. This feature is known as Point-in-Time-Recovery (PITR). Recovery points are created every hour. When you specify a time to recover data for, the service will use the backup closest to that point in time. When recovering the selected cluster backup, records from write-ahead logs (WALs) will be added to the backup data up to the closest recovery point.

For example, if the backup was created on November 10, 2022, 12:00 p.m. UTC, the current date is November 15, 2022, 7:00 p.m. UTC, and the latest recovery point was saved on November 15, 2022, 6:00 p.m. UTC, the cluster can be restored to any recovery point between November 10, 2022, 12:00:01 p.m. UTC and November 15, 2022, 6:00:00 p.m. UTC, inclusive. If you specify November 15, 2022, 5:30 p.m. UTC as the recovery time, the cluster will be restored to the recovery point saved on November 15, 2022, 5:00 p.m. UTC.

PITR mode is enabled by default.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore). You can also restore your cluster to move its hosts to a different availability zone. You may need to do this, for example, if your cluster hosts reside in the `{{ region-id }}-c` availability zone which is to be [deprecated](/blog/posts/2023/08/new-availability-zone).

## Creating backups {#size}

The first backup and every seventh backup are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is automatically backed up every day. You cannot create a backup manually or disable auto backups. However, for such backups, you can specify a time interval during which the backup will start when you [create](../operations/cluster-create.md) or [update](../operations/update.md#change-additional-settings) a cluster. The default time is `22:00 - 23:00` UTC (Coordinated Universal Time).

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

Backups are only created on running clusters. If you do not use a {{ mgp-short-name }} cluster 24/7, check the [backup start time settings](../operations/update.md#change-additional-settings).

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Storing backups {#storage}

Specifics of storing backups in {{ mgp-name }}:

* Backups are stored in object storage as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

* Backups are kept for seven days.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
