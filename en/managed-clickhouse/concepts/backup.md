---
title: ClickHouse backups
description: {{ mch-short-name }} provides automatic and manual ClickHouse database backups. Backups take up space in the storage allocated to the cluster. Backups are automatically created once a day. The backup process start time is set when a cluster is created or updated.
keywords:
  - backup
  - ClickHouse backup
  - ClickHouse
---

# Backups


{{ mch-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is [billed](../pricing.md).

Backups are automatically created once a day and stored for {{ mch-backup-retention }} days. You can't disable automatic backups or change the retention period.

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

## Creating backups {#size}

Backups can be made automatically and manually. Regardless of the type, backups are created incrementally:

- When creating another backup, [data parts](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) are checked for uniqueness.
- If there are identical [data parts](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage) in at least one of the existing backups and they are no older than {{ mch-dedup-retention }} days, they are not duplicated.

Backup data is stored only for the `MergeTree` engine family. For other engines, backups only store table schemas. Learn more about engines in the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/engines/table-engines/).

## Storing backups {#storage}

Backups are stored in Yandex internal storage as binary files and are encrypted using [GPG](https://en.wikipedia.org/wiki/GnuPG). Each cluster has its own encryption keys.

All backups (automatic or manual) are stored for {{ mch-backup-retention }} days.

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service. For user clusters, backups currently aren't checked.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

