# Backups in {{ mgp-name }}

{{ mgp-short-name }} provides automatic database backups.

## Creating backups {#size}

The first backup and every seventh backup are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

All cluster data is automatically backed up every day. You cannot create a backup manually or disable auto backups. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set a start time for these backups. By default, the backup process starts at 10 p.m. UTC. The backup will start within 30 minutes of the specified time.

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

Backups are only created on running clusters. If you do not use a {{ mgp-short-name }} cluster 24/7, check the [backup start time settings](../operations/update.md#change-additional-settings).

## Storing backups {#storage}

Specifics of storing backups in {{ mgp-name }}:

* Backups are stored in object storage as binary files and encrypted using [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

* Backups are kept for seven days.

* Once you delete a cluster, all its backups persist for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
