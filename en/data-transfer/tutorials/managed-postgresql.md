# Migrating databases to {{ mpg-full-name }}

To migrate your database to {{ mpg-full-name }}, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

Performing migration with {{ data-transfer-name }} lets you:

* Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.
* Migrate the database completely without stopping serving users.
* Migrate from older {{ PG }} versions to newer versions.

For more information, see [What tasks is {{ data-transfer-full-name }} used for](../concepts/use-cases.md).

## Before you start {#before-you-begin}

1. Allow connecting to the source cluster from the internet.

1. [Create a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration. In this case:

   * The {{ PG }} version must be the same or higher than the version in the source cluster. For the method using a logical dump, the versions must match.

      Migration with a {{ PG }} version downgrade is impossible.

   * When creating a cluster, specify the same database name as in the source cluster.
   * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mpg-full-name }} documentation](../../managed-postgresql/tutorials/data-migration.md).
