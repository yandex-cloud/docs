# Configuring a {{ GP }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mgp-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mgp-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mgp-full-name }}](../../../../managed-greenplum/).

{% list tabs %}

- Management console

   {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **List of included tables**: Data is only transferred from the listed tables.

      If a table is partitioned, you can specify both the entire table and individual partitions in this field.

      Make sure that, for tables to be included in the list, [all the necessary privileges are granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user on whose behalf data will be transferred.

   * **List of excluded tables**: Data from these listed tables is not transferred.

      If a table is partitioned, to exclude it from the list, make sure to list all of its partitions.

      Both lists support expressions in the following format:

      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

   * **Assure strict snapshot consistency**: When enabled, {{ data-transfer-name }} will apply additional steps to the source to assure [snapshot consistency](#snapshot-consistency).

   * **Auxiliary object schema** — a schema for placing auxiliary objects of the transfer.

{% endlist %}

## Specifics of working with the Greenplum source {#advanced}

{{ data-transfer-name }} only supports {{ GP }} version 6. {{ GP }} versions 4 and 5 are not supported.

The service performs operations with a {{ GP }} cluster with the `READ COMMITTED` [level of isolation](https://gpdb.docs.pivotal.io/6-19/ref_guide/sql_commands/SET_TRANSACTION.html).

{{ data-transfer-name }} supports operation with activated [sharded copy](../../../concepts/sharded.md) for a {{ GP }} source.

During operation with enabled sharded copy, {{ data-transfer-name }} maintains an open transaction on the {{ GP }} master host. If this transaction is interrupted, a transfer will return an error.

With sharded copy disabled, a transfer will move data from such {{ GP }} objects as `TABLE`, `VIEW`, `FOREIGN TABLE`, and `EXTERNAL TABLE`. Data from these objects will be treated as data from ordinary tables and are processed by the target accordingly. With activated sharded copy, a transfer will only move tables (`TABLE` objects); tables with the `DISTRIBUTED REPLICATED` [allocation policy](https://gpdb.docs.pivotal.io/6-19/admin_guide/distribution.html) are not transferred.

### Snapshot consistency {#snapshot-consistency}

When starting a transfer with disabled sharded copy (default), the service will perform the copy working only with the {{ GP }} [cluster master host](../../../../managed-greenplum/concepts/index.md). The tables being copied are accessed in `ACCESS SHARE` [lock mode](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-LOCK.html). Snapshot consistency is achieved through {{ GP }} mechanisms.

When starting a transfer with sharded copy enabled, the service will perform the copy working both with the master host and in utility mode with {{ GP }} cluster [segment hosts](../../../../managed-greenplum/concepts/index.md). Access to the tables to be copied locks the tables in `ACCESS SHARE` or `SHARE` mode depending on the **Snapshot consistency** setting.

A transfer with sharded copy enabled needs to assure that data in the tables being transferred remain static to guarantee snapshot consistency. For `ACCESS SHARE` locks (default), the service does not guarantee that the data remain static and this must be assured externally. For `SHARE` locks, the {{ GP }} mechanisms guarantee that data in the source tables remain static.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
