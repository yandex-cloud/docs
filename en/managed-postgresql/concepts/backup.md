---
title: PostgreSQL backups
description: "{{ mpg-short-name }} provides automatic and manual PostgreSQL database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created once a day."
keywords:
  - backup
  - backup
  - backups
  - PostgreSQL backups
  - backup PostgreSQL
  - PostgreSQL
---

# Backups in {{ mpg-name }}

{{ mpg-short-name }} provides automatic and manual database backups.

{{ mpg-name }} lets you restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. This is achieved by supplementing the backup selected as the starting point for recovery with entries from the write-ahead logs (WAL) of later backups and the cluster. PITR is enabled by default.

When creating backups and restoring data from them to a given point in time, keep in mind the following:

* A WAL consists of 16 MB files that are archived in a running cluster when the desired size is reached or if the time specified by the [archive timeout](./settings-list.md#setting-archive-timeout) cluster-level DBMS setting has passed since the last archiving. The archive is then uploaded to object storage.

* It takes some time to create and upload a WAL archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

Learn more about PITR in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/continuous-archiving.html).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

The first and every 7th automatic backups as well as all manually created backups are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is backed up once a day. You can't disable an automatic backup. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Backup start time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

Backups are only created on running clusters. If you don't use a {{ mpg-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mpg-name }}:

* Backups are stored in object storage as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* The retention time for backups of an existing cluster depends on the method used to create such backups:

   * Automatic backups are stored for 7 days by default. When [creating](../operations/cluster-create.md) a cluster or [editing](../operations/update.md#change-additional-settings) its settings, you can specify a different retention period of between 7 and 60 days.

   * Manually created backups are kept indefinitely.

* Once you delete a cluster, all its backups persist for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [Pricing policy for {{ mpg-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
