# Migrating to a third-party {{ MY }} cluster

To migrate a database deployed in a {{ mmy-full-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer data.
1. Disable data writes to the source database.
1. Transfer the load to a third-party cluster.

Migration across versions is supported. For example, you can move databases from {{ MY }} 5.7 to 8. The {{ MY }} major version on a third-party cluster must be the same or higher than the version in the {{ mmy-full-name }} cluster.


## Required paid resources {#paid-resources}

The support cost for this solution includes a transfer fee, which covers the use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Create a {{ MY }} cluster with any suitable configuration. In this case, the following applies:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

    Transferring data with {{ MY }} major version upgrade is possible but not guaranteed. For more information, see the relevant [{{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html) documentation.

    You [cannot](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html) perform migration while downgrading {{ MY }} version.

* [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MySQL migration with Data Transfer](datatransfer/managed-mysql-to-mysql.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmy-full-name }}](../../managed-mysql/tutorials/index.md) documentation.
