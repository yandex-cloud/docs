# Source endpoint parameters {{ GP }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can set the following:

* Settings for connecting to a [custom installation](#on-premise), including a VM-based installation {{ compute-full-name }}. These settings are required.
* [Additional settings](#additional-settings).

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

    * **Buffer size limit**: A limit of memory consumption by transfer (in bytes). The higher the buffer size, the faster the data transfer. However, you do risk the transfer going into emergency shutdown when all the available memory is used up. We recommend using the default value.

    * **Service object schema**: The schema for placement of transfer service objects.

        For example, to ensure ([snapshot consistency](https://docs.greenplum.org/6-16/admin_guide/dml.html)) for [heap tables](https://docs.greenplum.org/6-8/admin_guide/ddl/ddl-storage.html#topic37), a service function is created when running the transfer and placed in the specified schema.

{% endlist %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
