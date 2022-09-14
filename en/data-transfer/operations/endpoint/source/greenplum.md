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

      If a table is partitioned, to include it in the list, you can specify both the entire table and its individual partitions.

      Make sure that, for tables to be included in the list, [all the necessary privileges are granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user on whose behalf data will be transferred.

   * **List of excluded tables**: Data from these listed tables is not transferred.

      If a table is partitioned, to exclude it from the list, make sure to list all of its partitions.

      Both lists support expressions in the following format:

      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

   * **Buffer size limit**: The limit on the memory consumed by the transfer, in bytes. The higher is the buffer size, the faster is the data transfer. However, there exists a risk of transfer failure because the available memory is used up. We recommend that you use the default value.

   * **Auxiliary object schema** — a schema for placing auxiliary objects of the transfer.

{% endlist %}

## Specifics of working with the Greenplum source {#shard-copy-settings}

When using the default sharded copying settings (sharded copying is disabled, meaning that the number of instances and processes is not specified) at startup, the service copies data only through interaction with the {{ GP }} cluster coordinator. The tables being copied are accessed in `ACCESS SHARE` [lock mode](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-LOCK.html).

When using the preset sharded copying settings at startup, the service copies data by interacting with both the {{ GP }} cluster coordinator and its segments. The tables being copied are accessed in `SHARE` [lock mode](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-LOCK.html). If a transaction is interrupted in the Greenplum cluster coordinator, the consistency of copied data is not guaranteed.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
