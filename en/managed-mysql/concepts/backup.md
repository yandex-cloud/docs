---
title: MySQL backups
description: {{ mmy-short-name }} provides automatic and manual MySQL database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created once a day.
keywords:
  - backup
  - backup MySQL
  - MySQL
---
# Backups

{{ mmy-short-name }} provides automatic and manual database backups.

[A physical backup](https://dev.mysql.com/doc/refman/5.7/en/backup-types.html) of all cluster data is automatically created once a day and stored for 7 days. You can't disable automatic backups or change the retention period.

{{ mmy-name }} lets you restore the cluster state _to any point in time_ (Point-in-Time-Recovery, PITR) after the creation of the oldest full backup. This is achieved by supplementing the backup selected as the starting point for recovery with entries from the Binary Logs of later cluster backups.

For example, if the backup operation ended August 10, 2020, 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the latest binary log was saved August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC inclusive.

When creating backups and restoring data from them to a given point in time, keep in mind the following:

* A binary log consists of files with a size of 100 MB, which are archived in a running cluster as soon as the desired size is reached and then uploaded to object storage. Transactions are only logged to the binary log entirely, so sometimes the file size exceeds the specified one and it takes more time to archive them.

* It takes some time to create and upload a binary log archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

* When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

    When restoring to the current state, the new cluster will reflect the state of:
    * An existing cluster at the time of recovery.
    * A deleted cluster at the time of archiving the last binary log.

To learn more about PITR, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/point-in-time-recovery.html).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

## Creating backups {#size}

Backups can be automatic or manual. In both cases, the following scheme is used:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

The backup start time is set when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

Backups are only created on running clusters. If you don't use a {{ mmy-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

To learn how to manually create a backup, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmy-name }}:

* Backups are stored in Yandex internal storage as binary files and encrypted using [GPG]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/GnuPG){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/GNU_Privacy_Guard){% endif %}. Each cluster has its own encryption keys.

* All backups (automatic or manual) are stored for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see the [Pricing policy for {{ mmy-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

