# Migrating to a third-party {{ MY }} cluster


You can migrate your databases from one {{ MY }} version to another, e.g., from {{ MY }} 5.7 to {{ MY }} 8. Note that the third-party cluster must run a major {{ MY }} version not lower than that on your {{ mmy-full-name }} cluster.

To migrate a database deployed in a {{ mmy-full-name }} cluster to a third-party {{ MY }} cluster:

1. [Get your cloud ready](#before-you-begin).
1. [Prepare a third-party {{ MY }} cluster](#prepare-cluster).
1. [Transfer data](#transfer-data).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The migration infrastructure cost includes a fee for each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).



## Prepare a third-party {{ MY }} cluster {#prepare-cluster}

Create a {{ MY }} cluster of any suitable configuration. In this case, the following applies:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

    Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Migration with a {{ MY }} version downgrade is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.


## Transfer the data {#transfer-data}

{% include notitle [MySQL migration with Data Transfer](datatransfer/managed-mysql-to-mysql.md) %}


## How to delete the resources you created {#clear-out}


Some resources are not free of charge. Delete the resources you no longer need, so you will not be charged for them:


{% list tabs group=instructions %}

- Manually {#manual}

    1. Once the transfer is stopped, [delete it](../../data-transfer/operations/transfer.md#delete).
    1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}


## Useful links {#see-also}

For other migration methods, see [this {{ mmy-full-name }} tutorial](../../managed-mysql/tutorials/index.md).
