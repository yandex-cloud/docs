# Configuring a {{ GP }} source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* Settings of connection to the [custom installation](#on-premise), including one based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

   {% include [Common Greenplum table list UI](../../../../_includes/data-transfer/necessary-settings/ui/greenplum-table-list.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **Buffer size limit**: The limit on the memory consumed by the transfer, in  bytes. The higher is the buffer size, the faster is the data transfer. However, there exists a risk of transfer failure because the available memory is used up. We recommend that you use the default value.

   * **Auxiliary object schema** — a schema for placing auxiliary objects of the transfer.

{% endlist %}

## Specifics of working with the Greenplum source {#shard-copy-settings}

When using the default sharded copying settings (sharded copying is disabled, meaning that the number of instances and processes is not specified) at startup, the service copies data only through interaction with the {{ GP }} cluster coordinator. The tables being copied are accessed in `ACCESS SHARE` [lock mode](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-LOCK.html).

When using the preset sharded copying settings at startup, the service copies data by interacting with both the {{ GP }} cluster coordinator and its segments. The tables being copied are accessed in `SHARE` [lock mode](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-sql_commands-LOCK.html). If a transaction is interrupted in the Greenplum cluster coordinator, the consistency of copied data is not guaranteed.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
