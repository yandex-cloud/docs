# Backups in {{ mgp-name }}

{{ mgp-short-name }} provides automatic database backups.

## Creating backups {#size}

The first backup and every seventh backup are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is backed up once a day. You can't disable an automatic backup. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set a start time for these backups. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

Backups are only created on running clusters. If you don't use a {{ mgp-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

## Storing backups {#storage}

Storing backups in {{ mgp-name }}:

* Backups are stored in object storage as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

* Backups are kept for 7 days.

* Once you delete a cluster, all its backups persist for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
