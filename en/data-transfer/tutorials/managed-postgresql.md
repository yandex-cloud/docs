# Migrating databases to {{ mpg-full-name }}

To migrate your database to {{ mpg-full-name }}, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

Performing migration with {{ data-transfer-name }} lets you:

* Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.
* Migrate the database completely without stopping serving users.
* Migrate from older {{ PG }} versions to newer versions.

For more information, see [What tasks is {{ data-transfer-full-name }} used for](../concepts/use-cases.md).

## Before you begin {#before-you-begin}

1. Allow connecting to the source cluster from the internet.

1. [Create a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration. In this case:

   * The {{ PG }} version must be the same or higher than the version in the source cluster. For the method using a logical dump, the versions must match.

      Migration with a {{ PG }} version downgrade is impossible.

   * When creating a cluster, specify the same database name as in the source cluster.
   * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## Transferring tables with tsvector columns {#tsvector}

By default, tables with the [`tsvector` data type]({{ pg-docs }}/datatype-textsearch.html#DATATYPE-TSVECTOR) are copied using `INSERT` commands, which is much slower than standard copying. To accelerate [data transfers](#data-transfer), follow these steps:

1. When preparing a [target cluster](../../data-transfer/operations/prepare.md#target-pg), create tables with `tsvector` columns in the target cluster manually, but change the column type from `tsvector` to `text`.
1. When creating a [target endpoint](../../data-transfer/operations/endpoint/index.md#create), specify the `Do not clean` value for the **Cleanup policy** field in the settings.
1. After [activating the transfer](../../data-transfer/operations/transfer.md#activate) and changing its status to {{ dt-status-repl }}, convert the data in the desired columns to the `tsvector` type:

   ```sql
   ALTER TABLE <table name>
   ALTER COLUMN <column name> SET DATA TYPE tsvector
   USING
   to_tsvector(<column name>);
   ```

## See also {#see-also}

For other migration methods, see the [{{ mpg-full-name }} documentation](../../managed-postgresql/tutorials/data-migration.md).
