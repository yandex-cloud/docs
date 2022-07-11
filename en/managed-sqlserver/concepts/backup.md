---
title: {{ MS }} backups
description: {{ mms-short-name }} provides automatic and manual SQL Server database backups. A backup is automatically created once a day. The backup process start time is set when a {{ MS }} cluster is created or updated.
keywords:
  - backup
  - backup {{ MS }}
  - ms sql server
  - {{ MS }}
---

# Backups

{{ mms-short-name }} provides automatic and manual database backups.

A backup is automatically created once a day and stored for 7 days. You can't disable automatic backups or change the retention period.

{{ mms-name }} lets you restore a cluster to a state _at any point in time_ (Point-in-Time-Recovery, PITR) between the time you created the oldest backup and the time you archived the most recent transaction log. For this purpose, the backup selected as the recovery starting point is updated with entries from the cluster transaction log.

When creating backups and restoring data from them to a given point in time, keep in mind the following:

* The transaction log is archived in a running cluster every 20 minutes and then uploaded to object storage.

* It takes some time to create and upload a transaction log archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

For more information about PITR, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-2016).

To restore a cluster or an individual database from a backup, [follow the instructions](../operations/cluster-backups.md).

{% note warning %}

You cannot use SQL commands to modify the [recovery model]({{ ms.docs }}/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2016) for backup and restore operations.

{% endnote %}

## Creating backups {#size}

You can create backups both automatically and manually making a full backup of all the databases in both cases.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

The backup process start time is set when a cluster is [created](../operations/cluster-create.md) or [updated](../operations/update.md). By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

Backups are only created on running clusters. If you don't use a {{ mms-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information on creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mms-name }}:

* Backups are stored in Yandex internal storage as binary files.

* Manually created backups of an existing cluster will be stored indefinitely. Once you delete a cluster, all its backups persist for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see the [Pricing policy for {{ mms-name }}](../pricing/index.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md#restore-cluster) and check the integrity of your data.
