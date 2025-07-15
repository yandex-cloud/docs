#### Can I restore a cluster backup to a running {{ mpg-short-name }} instance in a different cloud network? {#diff-network}

You can only recover a cluster from a backup within a single cloud network.

To migrate data between cloud networks, follow the [migration guide](../../managed-postgresql/tutorials/replication-overview.md).

#### Can I change the retention period of automatic backups? {#backup-retain-days}

When [creating](../../managed-postgresql/operations/cluster-create.md) or [modifying](../../managed-postgresql/operations/update.md#change-additional-settings) a cluster, you can set the retention period for automatic backups.

#### Do I need the wal2json plugin if data is only replicated but not copied? {#wal2json}

Yes, you need the plugin even if you do not copy data.

#### Can I make a local dump of a database backup? {#backup-local-dump}

You cannot use the service to make a local dump of a DB backup from {{ yandex-cloud }} but you can use the [pg_dump utility]({{ pg.docs.org }}/current/app-pgdump.html).

#### How do I move a local {{ PG }} database dump to {{ yandex-cloud }}? {#dump-to-yc}

Follow the steps described in [Migrating databases](../../managed-postgresql/tutorials/data-migration.md).

#### Can I recover a single database from a backup? {#restore-one-database}

No, you cannot select specific databases. You can only restore the entire cluster with all its databases.
