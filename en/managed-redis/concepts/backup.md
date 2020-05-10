# Backups

{{ mrd-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

## Backup settings {{ mrd-short-name }} {#backup-settings}

{{ mrd-short-name }} uses AOF (append-only file) with forced write to disk every second: the [appendfsync everysec](http://download.redis.io/redis-stable/redis.conf) parameter is set.

A backup of all cluster data (an RDB snapshot) is automatically created once a day. You currently can't disable automatic backups or change the storage period for automatic backups (7 days by default).

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time).

## Creating backups {#size}

Backups can be made automatically and manually. Regardless of their type, they follow the same guidelines:

- The first backup and every seventh backup are full backups of all databases.
- Other backups are incremental and only store data that has changed since the previous backup to save storage space.

After a backup is created, it's compressed for storage. The exact backup size currently isn't displayed.

## Storing backups {#storage}

Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

All backups (automatic or manual) are stored for 7 days.

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service. For user clusters, backups currently aren't checked.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.

