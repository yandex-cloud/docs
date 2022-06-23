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

   * **Buffer size limit**: The limit on the memory consumed by the transfer, in bytes. The higher is the buffer size, the faster is the data transfer. However, there exists a risk of transfer failure because the available memory is used up. We recommend that you use the default value.

   * **Auxiliary object schema** — a schema for placing auxiliary objects of the transfer.

      For example, to ensure [snapshot consistency](https://docs.greenplum.org/6-16/admin_guide/dml.html) For [heap tables](https://docs.greenplum.org/6-8/admin_guide/ddl/ddl-storage.html#topic37), an auxiliary function is created when running the transfer to be placed in the specified schema.

{% endlist %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
