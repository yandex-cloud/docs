#### Can I restore a cluster backup to a running {{ mpg-short-name }} instance in another cloud network? {#diff-network}

Yes, you can switch to another cloud network when restoring a cluster from a backup.

#### Can I change the retention period for automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups during cluster [creation](../../managed-postgresql/operations/cluster-create.md) or [modification](../../managed-postgresql/operations/update.md#change-additional-settings).

#### Do I need the wal2json plugin if I am only doing data replication and not copying? {#wal2json}

Yes, you need this plugin even if you do not copy data.

#### Can I download a database backup to my local machine? {#backup-local-dump}

While {{ yandex-cloud }} service does not support local backup downloads, you can use the [pg_dump utility]({{ pg.docs.org }}/current/app-pgdump.html) as an alternative.

#### How do I move a local {{ PG }} database dump to {{ yandex-cloud }}? {#dump-to-yc}

Follow the steps described in this [Migrating databases tutorial](../../managed-postgresql/tutorials/data-migration.md).

#### How do I migrate a database or a table from one cluster to another? {#transfer-db-table}

You can migrate a database or a table using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I transfer data between clusters in different folders or clouds? {#transfer-data}

You can transfer data using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I move a cluster to another cloud? {#transfer-cluster}

You can move a cluster using {{ data-transfer-name }} or [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

For more information on using {{ data-transfer-name }} for migration, see [Database migration](../../managed-postgresql/tutorials/outbound-replication.md).

#### How do I restore a backup to an existing cluster? {#restore-existing-cluster}

You can only restore a backup to a new cluster.

#### How do I restore a cluster to the state of the selected backup? {#cluster-existing-backup}

You can only restore a backup to a new cluster.

#### Can I restore a single database from a backup? {#restore-one-database}

No, you cannot restore a specific database. You can only restore the entire cluster with all its databases.
