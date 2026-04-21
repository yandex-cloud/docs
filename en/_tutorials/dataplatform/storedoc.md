# Migrating {{ MG }} clusters


To migrate your {{ MG }} database to {{ mmg-name }}, follow these steps: transfer the data, switch the legacy database to read-only mode, transfer the workload over to the {{ yandex-cloud }} database cluster.

Using {{ data-transfer-name }} for migration allows you to:

* Migrate your database with zero downtime.
* Migrate from older to newer versions of {{ MG }}.
* Eliminate the need for an intermediate VM or for exposing your {{ mmg-name }} target cluster to the internet.

For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

To use this migration method, enable internet access to the source cluster.


## Required paid resources {#paid-resources}

* {{ SD }} cluster: Computing resources allocated to hosts along with storage and backup capacity (see [{{ SD }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Per transfer: Computing resources used and the number of data rows transferred (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

[Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) with computing capacity and storage size matching the source database’s environment.

The source and target database names must be the same.

## Transferring data {#data-transfer}

{% include notitle [Data migration MMG](datatransfer/storedoc.md) %}

## See also {#see-also}

For other migration methods, see [this {{ mmg-name }} guide](../../storedoc/tutorials/data-migration.md).
