---
title: "MySQL backups"
description: "{{ mmy-short-name }} provides automatic and manual MySQL database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created every day."
keywords:
  - backup
  - database backup
  - backups
  - MySQL backups
  - backup MySQL
  - MySQL
---

# Backups in {{ mmy-name }}

{{ mmy-short-name }} provides automatic and manual database backups.

{{ mmy-name }} allows you to restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. This is achieved by supplementing the backup selected as the starting recovery point with entries from the binary logs of later cluster backups.

For example, if the backup operation on ended August 10, 2020, 12:00 p.m. UTC, the current date is August 15, 2020, 7:00 p.m. UTC, and the latest binary log was saved on August 15, 2020, 6:50 p.m. UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 p.m. UTC and August 15, 2020, 6:50:00 p.m. UTC, inclusive.

PITR is enabled by default.

When creating backups and restoring data from them to a given point in time, keep the following in mind:

* A binary log consists of files with a size of 100 MB, which are archived in a running cluster as soon as the desired size is reached, and then uploaded to the object storage. Transactions are only logged to the binary log entirely, so sometimes the file size exceeds the specified one and it takes more time to archive the files.

* It takes some time to create and upload a binary log archive to the object storage. This is why the cluster state stored in the object storage may differ from the actual one.

* When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

   When restored to the current state, the new cluster will match the state of:

   * Existing cluster at the time of recovery.
   * Deleted cluster at the time of archiving the last binary log.

You can learn more about PITR in the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/point-in-time-recovery.html).

To restore a cluster from a backup, [follow this guide](../operations/cluster-backups.md).

## Creating backups {#size}

You can create backups both automatically and manually; in both cases, you get a [full physical backup](https://dev.mysql.com/doc/refman/5.7/en/backup-types.html) of all databases.

You cannot disable automatic backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set a start time for these backups. By default, the backup process starts at 10 p.m. UTC. The backup will start within 30 minutes of the specified time.

After a backup is created, it is compressed for storage.

In single-host clusters, you create a backup by reading data from the master host while the solution for multi-host clusters is to read one of the replicas, since it is a resource-intensive operation. In this case:

* The replica with the highest backup priority is selected. You can set the priority when [creating](../operations/cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new hosts, or [modifying the settings](../operations/hosts.md#update) of the existing ones. This defines which replica to use for backups. The minimum backup priority value is `0`, while the maximum one is `100` and the default one is `0`.
* If there are multiple replicas with the highest priority, a backup source is selected randomly from among these.

If the service is unable to create a backup using the selected replica, the backup operation will proceed with the master host.

Backups are only created on running clusters. If you do not use a {{ mmy-short-name }} cluster 24/7, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmy-name }}:

* Backups are kept in {{ yandex-cloud }} internal storage as binaries and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* In an existing cluster, you can set up the retention period for automatic backups ranging from 7 (default) to 60 days. Manual backups are stored with no time limit.

* Once you delete a cluster, all its backups persist for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [{{ mmy-name }} pricing policy](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
