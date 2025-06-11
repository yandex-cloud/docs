---
title: MongoDB backups
description: '{{ mmg-short-name }} performs automatic and manual MongoDB database backups. Backups take up space in the storage allocated to the cluster. You can recover the cluster data from a given point in time (Point-in-Time-Recovery, PITR).'
keywords:
  - backup
  - back up
  - backup
  - backups
  - '{{ MG }} backups'
  - backup {{ MG }}
  - '{{ MG }}'
---

# Backups in {{ mmg-name }}

{{ mmg-short-name }} supports automatic and manual database backups.

{{ mmg-name }} allows you to restore your cluster _to any state_ (Point-in-Time-Recovery, PITR) in the time interval between the oldest backup and the archiving of the most recent [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog/) collection. For this purpose, the backup selected as the starting point of recovery is updated with entries from the cluster oplog.

When creating backups and restoring data from them to a given point in time, keep the following in mind:

* The oplog is archived in a running cluster a few times a minute, and then uploaded to object storage.

* It takes some time to create and upload an oplog archive to object storage. This is why the cluster state stored in the object storage may differ from the actual one.

To use PITR, you must disable the [sharding](../tutorials/sharding.md) mechanism in the cluster: PITR works only for a cluster with a single replica set.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Creating backups {#size}

You can create backups either automatically or manually; in both cases, you get a full backup of all databases.

All cluster data is automatically backed up every day. You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Time interval during which the backup starts. Default time: `22:00 - 23:00` UTC (Coordinated Universal Time).

After a backup is created, it is compressed for storage. To find out its exact size, request a [list of backups](../operations/cluster-backups.md#list-backups).

Backups are only created on running clusters. If not using your {{ mmg-short-name }} cluster 24/7, look up the [settings](../operations/update.md#change-additional-settings) to make sure the backup is taking place when the cluster is running.

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmg-name }}:

* Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* The retention time for backups of an existing cluster depends on the method used to create such backups:

    * Automatic backups are stored for {{ mmg-backup-retention }} days by default. When [creating](../operations/cluster-create.md) a cluster or [editing](../operations/update.md#change-additional-settings) its settings, you can specify a different retention period of between {{ mmg-backup-retention-min }} and {{ mmg-backup-retention-max }} days.

    * Manually created backups are stored with no time limit.

* After you delete a cluster, all its backups are kept for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}
* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see [Pricing policy](../pricing.md#rules-storage).

## Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
