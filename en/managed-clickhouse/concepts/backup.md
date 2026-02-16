---
title: '{{ CH }} backups'
description: '{{ mch-short-name }} supports automatic and manual database backups. Backups take up space in the storage allocated to the cluster. Backups are automatically created once a day.'
keywords:
  - backups
  - back up
  - backup
  - backing up
  - '{{ CH }} backups'
  - '{{ CH }} backup'
  - '{{ CH }}'
---

# Backups in {{ mch-name }}

{{ mch-short-name }} supports automatic and manual database backups.

A backup is automatically created once a day. You cannot disable automatic backups or change their retention period.

For clusters running an unsupported [DBMS version](update-policy.md#versioning-policy), restoring from backups is not available.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Creating a backup {#size}

You can create backups either automatically or manually. In both cases, the incremental method is used:

* When you create a new backup, {{ mch-short-name }} checks [data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) for uniqueness.
* If one of the existing backups already contains identical [data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) and they are not older than {{ mch-dedup-retention }} days, they are not duplicated. For cold data in a [hybrid storage](storage.md#hybrid-storage-features), this period is {{ mch-backup-retention }} days.

A backup includes the entire cluster and contains all its [shards](./sharding.md). You can recover either individual shards or the entire cluster.

{% note info %}

Prior to April 1, 2025, separate backups were created for each cluster shard. For such backups, you can recover the following:

* One or multiple shard backups to an individual cluster.
* Entire cluster by specifying backups of all its shards.

You can recover multiple shards to a single cluster if their backups were created for the same cluster.

{% endnote %}

Backups contain data solely for the `MergeTree` engine family. For other engines, backups only contain table schemas. Learn more about the engines in [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/).

The system uses random replica hosts to create backups. Thus, if cluster hosts lack data consistency, restoring such a cluster from a backup does not guarantee complete data recovery. For example, this may occur in the following cases:

* [The tables are not replicated](replication.md#replicated-tables) on all shard hosts.
* The tables are not replicated and are only placed on some of the shard hosts.

When [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster, you can set the backup start window. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Backups are only created on running clusters. If you are not using your {{ mch-short-name }} cluster 24/7, check the [settings of backup start time](../operations/update.md#change-additional-settings).

Learn about creating manual backups in [Managing backups](../operations/cluster-backups.md).

## Storing a backup {#storage}

* Backups of [local and network storages](storage.md) reside in a separate {{ objstorage-name }} bucket and take up no space in the cluster storage. If there are X GB of free space in the cluster, the first X GB of backups are stored free of charge.

* Backups of cold data from a [hybrid storage](storage.md#hybrid-storage-features) are stored in the same {{ objstorage-name }} bucket as the data itself. The cost of using {{ objstorage-name }} includes both the space used by the backups and the space used by the data itself.

    For more information, see the [pricing policy](../pricing.md#rules-storage).

* Backups are stored as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* The retention time for backups of an existing cluster depends on the way they were created:

    * Automatic backups are stored for {{ mch-backup-retention }} days by default. When [creating](../operations/cluster-create.md) or [reconfiguring](../operations/update.md#change-additional-settings) a cluster, you can specify a different retention period between 3 and 60 days.

    * Manual backups are stored with no time limit.

* After you delete a cluster, all its backups are retained for {{ mch-backup-retention }} days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Testing recovery from a backup {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md) and check your data for integrity.

## Deleting a backup {#deletion}

You can only delete manual backups. To delete such a backup, [follow this guide](../operations/cluster-backups.md#delete-backup).

## Use cases {#examples}

* [{#T}](../operations/cluster-backups.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}