# Migrating databases to {{ mmy-name }}

With {{ data-transfer-name }}, you can transfer data from a third-party source cluster to a {{ mmy-name }} target cluster.

This method lets you migrate the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

## Before you start {#before-you-begin}

[Create a {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration. In this case:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

   Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

   Migration with a {{ MY }} version downgrade is [impossible](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data {#data-transfer}

{% include notitle [MySQL migration with Data Transfer](../../_tutorials/datatransfer/managed-mysql.md) %}

## See also {#see-also}

For other migration methods, see the [{{ mmy-full-name }} documentation](../../managed-mysql/tutorials/data-migration.md).
