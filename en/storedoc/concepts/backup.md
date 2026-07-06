---
title: '{{ SD }} backups'
description: '{{ mmg-short-name }} supports automatic and manual {{ SD }} database backups. Backups take up space in the storage allocated to the cluster. You can recover the cluster data from a given point in time (Point-in-Time-Recovery, PITR).'
keywords:
  - backups
  - back up
  - backup
  - MongoDB backups
  - Yandex StoreDoc backup
  - backup Yandex StoreDoc
  - backup MongoDB
  - MongoDB
  - Yandex StoreDoc
---

# Backups in {{ mmg-name }}

{{ mmg-short-name }} supports automatic and manual database backups.

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

## Creating a backup {#size}

You can create backups either automatically or manually; in both cases, you get a full backup of all databases.

For sharded clusters, two backups are created: a sharded one and a non-sharded one. The sharded backup displays a larger size which includes:
* Backup size for `mongoinfra` or `mongocfg` type hosts.
* Total size of all non-sharded backups. This total is counted towards the overall size of a sharded backup, but technically non-sharded backups do not take up extra storage space as part of a sharded backup.

You can restore only a non-sharded cluster from a non-sharded backup. From a sharded backup, you can restore a cluster with standard or advanced sharding, no matter what sharding type was used in the original cluster. The restored cluster's shards must match the original cluster's shards at the time of creating the backup.

All cluster data is automatically backed up once a day. You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Time interval during which the backup starts. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Once created, a backup is compressed for storage. To find out its exact size, request a [list of backups](../operations/cluster-backups.md#list-backups).

Backups are only created on running clusters. If not using your {{ mmg-short-name }} cluster 24/7, check the [settings](../operations/update.md#change-additional-settings) to make sure that backups take place during the cluster's active hours.

Learn about creating manual backups in [Managing backups](../operations/cluster-backups.md).

## Storing a backup {#storage}

Storing backups in {{ mmg-name }}:

* Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* The retention time for backups of an existing cluster depends on the way they were created:

    * Automatic backups are stored for {{ mmg-backup-retention }} days by default. When [creating](../operations/cluster-create.md) a cluster or [editing](../operations/update.md#change-additional-settings) its settings, you can specify a different retention period of between {{ mmg-backup-retention-min }} and {{ mmg-backup-retention-max }} days.

    * Manual backups are stored with no time limit.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}
* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see [Pricing policy](../pricing.md#rules-storage).

## Recovery from a backup {#capabilities}

Restoring a cluster from a backup creates a new cluster with that backup’s data. You need to specify all the cluster's settings (except the cluster type), just as when creating a new cluster. If your folder lacks [resources](../concepts/limits.md) to create such a cluster, you will not be able to recover it from a backup. The average restore speed is 10 MBps.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md).

{% include [advice-backup](../../_includes/mdb/advice-backup.md) %}

## PITR in {{ mmg-name }} {#pitr-details}

{{ mmg-name }} allows you to restore your cluster _to any state_ (Point-in-Time-Recovery, PITR) in the time interval between the oldest backup and the archiving of the most recent `oplog` collection. For this purpose, the backup selected as the starting point of recovery is updated with entries from the cluster `oplog`.

> For example, if a backup operation completed on August 10, 2020, at 12:00:00 UTC, it is now August 15, 2020, 19:00:00 UTC, and the latest `oplog` was saved on August 15, 2020, at 18:50:00 UTC, the cluster can be restored to any of its states starting from August 10, 2020, 12:00:01 UTC through August 15, 2020, 18:50:00 UTC.

The `oplog` is archived in a running cluster a few times a minute and then uploaded to object storage.

It takes some time to create and upload an `oplog` archive to object storage. This is why the cluster state stored in the object storage may differ from the actual one.

{% note warning %}

PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. These clusters can only be restored to the point in time when the chosen backup was created.

{% endnote %}

PITR only works for clusters with a single replica set. Therefore, to use PITR, you must disable the [sharding](../tutorials/sharding.md) mechanism in the cluster.

When restored to the current point in time, the new cluster will reflect the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the last `oplog`.
