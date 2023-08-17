---
title: "{{ CH }} backups"
description: "{{ mch-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. Backups are automatically created every day."
keywords:
  - backup
  - database backup
  - backups
  - ClickHouse backups
  - backup ClickHouse
  - ClickHouse
---

# Backups in {{ mch-name }}

{{ mch-short-name }} provides automatic and manual database backups.

A backup is automatically created every day. You cannot disable automatic backups or change the retention period.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md#restore).

## Creating backups {#size}

You can create both automatic and manual backups. In both cases, the incremental method is used:

* When creating a new backup, [data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) are checked for uniqueness.
* If there are identical [data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) in one of the existing backups and they are no older than {{ mch-dedup-retention }} days, they are not duplicated. For cold data in [hybrid storage](storage.md#hybrid-storage-features), this period is {{ mch-backup-retention }} days.

Backups are created separately for each individual cluster [shard](./sharding.md). They are also restored by individual shard. You can restore:

* One or more shard backups in an individual cluster.
* The entire cluster by specifying backups of all cluster shards.

Backup data is only stored for the `MergeTree` engine family. For other engines, backups only store table schemas. You can learn more about engines in the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/).

Backups are created based on a random replica host. This is why, if there is no cluster host data consistency, restoring clusters from backups does not guarantee complete data recovery. For example, this may occur in the following cases:

* [The tables are not replicated](replication.md#replicated-tables) on all shard hosts.
* The tables are not replicated and are only hosted on some of the shard hosts.

The backup process start time is set when a cluster is [created](../operations/cluster-create.md) or [updated](../operations/update.md#change-additional-settings). By default, the backup process starts at 10 p.m. UTC. The backup will start within 30 minutes of the specified time.

Backups are only created on running clusters. If you do not use a {{ mch-short-name }} cluster 24/7, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md).

## Storing backups {#storage}

* Backups of the data from [local](storage.md) and [network](storage.md) storage devices are stored in a separate {{ objstorage-name }} bucket and do not take up any space in the cluster storage. If there are N free GB of space in the cluster, the first N GB of backups are stored free of charge.

* Backups of cold data from [hybrid storage](storage.md#hybrid-storage-features) are stored in the same {{ objstorage-name }} bucket as the regular data. The cost for using Object Storage factors in the space used by backups and the size of data.

   For more information, see the [{{ mch-short-name }} pricing policy](../pricing.md#rules-storage).

* Backups of cold data from [hybrid storage](storage.md#hybrid-storage-features) only contain increments, i.e., the history of changes to data parts for the last {{ mch-backup-retention }} days. Backups of data that has not been modified are provided by {{ objstorage-name }}.

* Backups are stored as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* Automatically created backups of an existing cluster are kept for seven days, whereas those created manually are stored indefinitely. After you delete a cluster, all its backups are kept for {{ mch-backup-retention }} days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
