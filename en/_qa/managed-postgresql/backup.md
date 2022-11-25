# Moving and restoring a {{ PG }} cluster

#### Can I restore a cluster backup to a running {{ mpg-short-name }} instance on a different cloud network? {#diff-network}

You can only recover a cluster from a backup within a single cloud network.

To migrate data between cloud networks, follow the [migration instructions](../../managed-postgresql/tutorials/replication-overview.md).

#### Do I need the wal2json plugin if there is only data replication and no copying? {#wal2json}

Yes, you need the plugin even if you do not copy data.

#### Can I make a local dump of a database backup? {#backup-local-dump}

You cannot use the service to make a local dump of a DB backup from {{ yandex-cloud }} but you can use the [pg_dump utility](https://www.postgresql.org/docs/9.6/app-pgdump.html).

#### How do I move a local {{ PG }} database dump to {{ yandex-cloud }}? {#dump-to-yc}

Follow the instructions in [Migrating databases](../../managed-postgresql/tutorials/data-migration.md).

#### How do I import data to a {{ PG }} database cluster in {{ mpg-short-name }}? {#migrate}

Use the `pg_dump` built-in tool to migrate data to a {{ PG }} cluster in {{ mpg-short-name }}.
