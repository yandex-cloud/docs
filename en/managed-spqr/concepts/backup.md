---
title: '{{ SPQR }} backups'
description: '{{ mspqr-name }} supports automatic and manual backups for {{ SPQR }} clusters. Backups take up space in the storage allocated to the cluster. You can recover the cluster data from a given point in time (Point-in-Time-Recovery, PITR).'
keywords:
  - backups
  - back up
  - backup
  - backing up
  - Sharded PostgreSQL backup
  - backup Sharded PostgreSQL
  - Yandex Sharded PostgreSQL
---

# Backups in {{ mspqr-name }}

{{ mspqr-name }} supports automatic and manual database backups.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Creating a backup {#size}

You can create backups either automatically or manually. In both cases, you get a full backup of shard configuration (metadata storage) for `INFRA` or `COORDINATOR` hosts.

Shard backups are based on the settings of their respective {{ mpg-name }} clusters. For more information, see [{#T}](../../managed-postgresql/concepts/backup.md).

A cluster backup is automatically created once a day. You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/cluster-update.md) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Time interval during which the backup starts. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Once created, a backup is compressed for storage. To find out its exact size, request a [list of backups](../operations/cluster-backups.md#list-backups).

Backups are created only on running {{ mspqr-name }} clusters. If not using your cluster 24/7, check the [settings](../operations/cluster-update.md) to make sure that backups take place during the cluster's active hours.

Learn about creating manual backups in [Managing backups](../operations/cluster-backups.md).

## Storing a backup {#storage}

Backups are stored in {{ objstorage-name }} as binaries and do not take up space in the cluster storage. [Quotas]({{ link-console-quotas }}) and limits for cluster storage do not apply to backup storage.

Before they are moved to object storage, all backups are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

The retention time for backups of an existing cluster depends on the way they were created:

* Automatic backups are stored for 7 days by default. When [creating](../operations/cluster-create.md) or [reconfiguring](../operations/cluster-update.md) a cluster, you can specify a different retention period between 7 and 60 days.

* Manual backups are stored with no time limit.

After you delete a cluster, all its backups are kept for seven days.

## Recovery from a backup {#restore}

By restoring a cluster from a backup, you create a new cluster. You need to specify all the cluster's settings, just as when creating a new cluster. Regardless of the original cluster’s sharding type, you can restore a cluster with either standard or advanced sharding. If your folder lacks [resources](limits.md) to create such a cluster, you will not be able to restore from the backup.

{{ mspqr-name }} allows you to restore the cluster state to any point in time since the oldest full backup was created. For this purpose, this backup is updated with archived entries from the coordinator's metadata storage. In a running cluster, metadata storage is continuously archived every five minutes. Then archived entries are uploaded to object storage.

> For example, if a backup operation completed on August 10, 2025 at 12:00:00 UTC, and the latest metadata storage backup was saved on August 15, 2025, at 18:50:00 UTC, the cluster can be restored to any of its states within the time interval from August 10, 2025, 12:00:01 UTC to August 15, 2025, 18:50:00 UTC, inclusive.

The new cluster will reflect the state of:

* Existing cluster at the time of the latest backup of the coordinator's metadata storage.
* Deleted cluster at the time of the latest metadata archiving.

After restoring your cluster, you can add shards to it:

* Based on existing {{ PG }} clusters.
* Based on {{ PG }} clusters restored from backups to a selected point in time. For more information, see [Restoring a {{ PG }} cluster](../../managed-postgresql/concepts/backup.md#restore).

The restored cluster's shards must match the original cluster's shards at the time of creating the backup.

{% note tip %}

Periodically test the recovery of production system clusters. Verify metadata integrity in the restored cluster.

{% endnote %}
