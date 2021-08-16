---
title: PostgreSQL backups
description: {{ mpg-short-name }} provides automatic and manual PostgreSQL database backups. Backups take up space in the storage allocated to the cluster. A backup is automatically created once a day. 
keywords:
  - backup
  - backup PostgreSQL
  - PostgreSQL
---

# Backups

{{ mpg-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage space, the excess is [billed](../pricing.md).

A backup is automatically created once a day. You currently can't disable automatic backups or change the storage period for automatic backups (7 days by default).

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time).

You can recover cluster data _from a given time point_ (Point-in-Time-Recovery, PITR). {{ mpg-name }} allows you to restore the state of a cluster from any time pont after the creation of the oldest full backup up to a given time. This is achieved by supplementing the backup selected as the starting point for recovery with entries from the write-ahead logs (WAL) of later backups and the cluster. For more information about PITR, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/continuous-archiving.html).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

## Creating backups {#size}

Backups can be made automatically and manually. Regardless of their type, they follow the same guidelines:

- The first backup and every seventh backup are full backups of all databases.
- Other backups are incremental and only store data that has changed since the previous backup to save storage space.

After a backup is created, it's compressed for storage. The exact backup size currently isn't displayed.

## Storing backups {#storage}

Backups are stored in Yandex internal storage as binary files and are encrypted using [GPG](https://en.wikipedia.org/wiki/GnuPG). Each cluster has its own encryption keys.

All backups (automatic or manual) are stored for 7 days. You can store one or two full backups to ensure recovery from an automatic seven-day-old backup.

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service. For user clusters, backups currently aren't checked.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

