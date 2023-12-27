# Migrating {{ CH }} clusters

With {{ data-transfer-name }}, you can transfer your database from a third-party {{ CH }} source cluster to a {{ mch-name }} target cluster.

This method allows you to:

* Copy the database without interrupting user service.
* Go without creating an intermediate VM or granting online access to your {{ mch-name }} target cluster.

For more information, see [{#T}](../concepts/use-cases.md).

## Getting started {#before-you-begin}

* [Create a {{ mch-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md) with the computing capacity and storage size appropriate for the environment where the copied database is deployed.

   The database name in the target cluster must be the same as the source database name.

* [Allow connecting to the source cluster from the internet](../concepts/network.md#source-external).

## Transferring data {#data-transfer}

{% include notitle [Data migration MCH](../../_tutorials/datatransfer/managed-clickhouse.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
