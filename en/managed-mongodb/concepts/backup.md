# Backups

{{ mmg-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is [billed](../pricing.md).

You can recover the cluster data _from a given point in time_ (Point-in-Time-Recovery, PITR). The cluster must meet the following criteria:

- {{ MG }} version in the cluster: 4.2 or higher.
- [Sharding](../tutorials/sharding.md) is enabled. PITR works only for a cluster with a single replica set.

{{ mmg-name }} allows you to restore the cluster state from any point in time from the creation of the oldest backup to the present. For this purpose, the backup selected as the starting point of recovery is updated by `oplog` entries for the later backups and the cluster itself.

Learn more about PITR and its limitations in the [{{ MG }} documentation](https://docs.mongodb.com/database-tools/mongodump/#cmdoption-mongodump-oplog).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

Backups can be automatic or manual:

- The first backup and every seventh backup are full backups of all databases.
- Other backups are incremental and only store data that has changed since the previous backup to save storage space.

All cluster data is backed up once a day. You can't disable an automatic backup. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

- [Storage time](#storage).
- Backup start time. The backup will start within half an hour of the specified time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time).

To learn how to manually create a backup, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmg-name }}:

- Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.
- Backups are compressed to ensure compact storage. To find out the total backup size stored, request a [list of backups](../operations/cluster-backups.md#list-backups).
- Automatic backups are stored for {{ mmg-backup-retention }} days by default. When [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set a different storage period in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} days. Automatic backups are deleted when the storage period expires. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md).
- Manual backups are stored indefinitely. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md) stage.

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service. For user clusters, backups currently aren't checked.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

