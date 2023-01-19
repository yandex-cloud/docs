# Migrating databases from {{ mmy-full-name }} to {{ MY }}

To migrate a database deployed in a {{ mmy-full-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer data.
1. Disable data writes to the source database.
1. Switch over the load to a third-party cluster.

Migration across versions is supported. For example, you can move databases from {{ MY }} 5.7 to 8. The {{ MY }} major version on a third-party cluster must be equal to or higher than the version in the {{ mmy-full-name }} cluster.

## Before you start {#before-you-begin}

Create a {{ MY }} cluster with any suitable configuration. In this case:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

   Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

   Migration with a {{ MY }} version downgrade is [impossible](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MySQL migration with Data Transfer](../../_tutorials/datatransfer/managed-mysql-to-mysql.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmy-full-name }} documentation](../../managed-mysql/tutorials/index.md).
