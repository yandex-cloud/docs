# Migrating databases to {{ mmg-full-name }}

To migrate your database to {{ mmg-name }}, you need to transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

Performing migration with {{ data-transfer-name }} lets you:

* Migrate the database without interrupting user service.
* Migrate from older {{ MG }} versions to newer versions.
* Go without creating an intermediate VM or granting online access to your {{ mmg-name }} target cluster.

To use this migration method, allow connecting to the source cluster from the internet.

For more information, see [What tasks is {{ data-transfer-full-name }} used for](../concepts/use-cases.md).

## Before you start {#before-you-begin}

[Create a {{ mmg-name }} target cluster](../../managed-mongodb/operations/cluster-create.md) with the computing capacity and storage size appropriate for the environment where the migrated database is deployed.

The database name in the target cluster must be the same as the source database name.

## Transferring data {#data-transfer}

{% include notitle [Data migration MMG](../../_tutorials/datatransfer/managed-mongodb.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmg-full-name }} documentation](../../managed-mongodb/tutorials/data-migration.md).
