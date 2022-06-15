# Target endpoint parameters {{ CH }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
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

   * **Shard column**: The name of the column in tables that data will be [sharded](../../../../managed-clickhouse/concepts/sharding.md) by. A uniform distribution across shards will be determined by a hash from this column value. For sharding by specific column values, specify them in the **Shard mapping** field.

   * **Shard by transfer ID**: Data will be distributed across shards based on the transfer ID value. The transfer will ignore the **Sharding column** and **Shard mapping** settings, and will only shard the data based on the transfer ID.

      {% note warning %}

      If you omit the sharding columns and the **Shard by transfer ID** setting, all the data will be moved to the same shard.

      {% endnote %}

   * **Shard mapping** defines the mapping between values in the column set as the **Shard column** and the shard index (the sequential number of the shard in the name-sorted list of shards), to enable sharding by specific data values.

   * **Upload data in JSON format**: For optional values, default values will be used (if any). Enable this setting if the transfer connects to the target via the HTTP port rather than the native one.

   * **Write interval**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if ClickHouse fails to merge data parts.

   * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

{% endlist %}
