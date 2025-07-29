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

#### How do I migrate a database or table from one cluster to another? {#transfer-db-table}

You can migrate a database or table using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I transfer data between clusters in different folders or clouds? {#transfer-data}

You can transfer data using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I move a cluster to another cloud? {#transfer-cluster}

You can move a cluster using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I restore a backup to an existing cluster? {#restore-existing-cluster}

You can restore a backup only to a new cluster.

#### How do I restore a cluster to the selected backup state? {#cluster-existing-backup}

You can restore a backup only to a new cluster.

#### Can I recover a single database from a backup? {#restore-one-database}

No, you cannot select specific databases. You can only restore the entire cluster with all its databases.
