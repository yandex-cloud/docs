# Migrating to a third-party {{ MY }} cluster

To migrate a database deployed in a {{ mmy-full-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer the data.
1. Disable data writes to the source database.
1. Switch all traffic to the third-party cluster.

You can migrate your databases from one {{ MY }} version to another, e.g., from {{ MY }} 5.7 to {{ MY }} 8. Note that the third-party cluster must run a major {{ MY }} version not lower than that on your {{ mmy-full-name }} cluster.


## Required paid resources {#paid-resources}

The migration infrastructure cost includes a fee for each transfer: Use of computing resources and number transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Create a {{ MY }} cluster with any suitable configuration. For this operation, the following requirements apply:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

    Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Migration to an earlier {{ MY }} version is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MySQL migration with Data Transfer](datatransfer/managed-mysql-to-mysql.md) %}

## See also {#see-also}

For other migration methods, see [this {{ mmy-full-name }} tutorial](../../managed-mysql/tutorials/index.md).
