# Target endpoint parameters {{ CH }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can set the following:

* Connection settings to a [{{ mch-full-name }} cluster](#managed-service) or a [custom installation](#on-premise), including those based on {{ compute-full-name }} virtual machines. These parameters are required.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-full-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Management console

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

    * **{{ CH}} cluster name**: Specify the name of the cluster that the data will be transferred to.

    * **Override table names**: Fill in if you need to rename source tables when transferring to the target database.

    * **Shard column**: The name of the column in tables that data will be [sharded](../../../../managed-clickhouse/concepts/sharding.md) by.

    * **Shard by transfer ID**: Data will be distributed across shards based on the transfer ID value.

        {% note warning %}

        If both the **Shard column** and **Shard by transfer ID** options are enabled, then the database is only sharded by the transfer ID.

        {% endnote %}

    * **Upload data in JSON format**: For optional values, default values will be used (if any). Enable this setting if the transfer connects to the target via the HTTP port rather than the native one.

    * **Write interval**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if ClickHouse does not have time to merge pieces of data.

    * {% include [Field Cleanum Policy Drop/Disabled](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop.md) %}

{% endlist %}

