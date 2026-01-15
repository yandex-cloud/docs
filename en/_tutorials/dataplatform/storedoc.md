# Migrating {{ MG }} clusters


To migrate your {{ MG }} database to {{ mmg-name }}, you need to transfer the actual data, write-lock the old database, and transfer the load to the {{ yandex-cloud }} DB cluster.

Performing migration with {{ data-transfer-name }} allows you to:

* Migrate the database without interrupting user service.
* Migrate from older {{ MG }} versions to newer versions.
* Eliminate the need for an intermediate VM or public internet access to your {{ mmg-name }} target cluster.

For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

To use this migration method, allow connecting to the source cluster from the internet.


## Required paid resources {#paid-resources}

* {{ SD }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ SD }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

[Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) whose computing and storage capacity match those of the source database environment.

The source and target database names must be the same.

## Transferring data {#data-transfer}

{% include notitle [Data migration MMG](datatransfer/storedoc.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmg-name }} documentation](../../storedoc/tutorials/data-migration.md).
