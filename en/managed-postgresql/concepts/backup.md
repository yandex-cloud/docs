---
title: PostgreSQL backups
description: {{ mpg-short-name }} provides automatic and manual PostgreSQL database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created once a day. 
keywords:
  - backup
  - backup PostgreSQL
  - PostgreSQL
---

# Backups

{{ mpg-short-name }} provides automatic and manual database backups.

A backup is automatically created once a day and stored for 7 days. You can't disable automatic backups or change the retention period.

{{ mpg-name }} lets you restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. This is achieved by supplementing the backup selected as the starting point for recovery with entries from the write-ahead logs (WAL) of later backups and the cluster. For more information about PITR, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/continuous-archiving.html).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

Backups can be automatic or manual. In both cases, the following scheme is used:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

The backup start time is set when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

Backups are only created on running clusters. If you don't use a {{ mpg-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

To learn how to manually create a backup, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mpg-name }}:

* Backups are stored in object storage as binary files and are encrypted using [GPG]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/GnuPG){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/GNU_Privacy_Guard){% endif %}. Each cluster has its own encryption keys.

* All backups (automatic or manual) are stored for 7 days. You can store one or two full backups to ensure recovery from an automatic seven-day-old backup.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see the [Pricing policy for {{ mpg-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

