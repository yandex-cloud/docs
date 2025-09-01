# Migrating {{ mmg-full-name }} clusters


To migrate your database to {{ mmg-name }}, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

Performing migration with {{ data-transfer-name }} allows you to:

* Migrate the database without interrupting user service.
* Migrate from older {{ SD }} versions to newer versions.
* Go without creating an intermediate VM or granting online access to your {{ mmg-name }} target cluster.

To learn more, see [{#T}](../../data-transfer/concepts/use-cases.md).

To use this migration method, allow connecting to the source cluster from the internet.


## Required paid resources {#paid-resources}

The support cost includes:

* {{ SD }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ SD }} pricing](../../storedoc/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

[Create a {{ mmg-name }}](../../storedoc/operations/cluster-create.md) target cluster with the computing capacity and storage size appropriate for the environment where the migrated database is deployed.

The database name in the target cluster must be the same as the source database name.

## Transferring data {#data-transfer}

{% include notitle [Data migration MMG](datatransfer/managed-mongodb.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmg-full-name }}](../../storedoc/tutorials/data-migration.md) documentation.
