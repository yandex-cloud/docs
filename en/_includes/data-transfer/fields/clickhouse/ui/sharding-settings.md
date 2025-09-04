**{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}**: Specify the settings for [sharding](../../../../../managed-clickhouse/concepts/sharding.md):

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}**: No sharding is used.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}**: Name of the table column to shard the data by. Uniform distribution between shards will depend on the hash of this column value. Specify the name of the column to be sharded in the appropriate field.

    For sharding by specific column values, specify them in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}** field. This field defines the mapping between the column and shard index values (the sequential number of the shard in the name-sorted list of shards), to enable sharding by specific data values.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}**: Data will be distributed between shards based on the transfer ID value. The transfer will ignore the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** setting and will only shard the data based on the transfer ID.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_round_robin.title }}**: Data will be randomly distributed between shards. Each shard will contain approximately the same amount of data.

  {% note warning %}

  For transfers from {{ CH }} to {{ CH }}, sharding is not supported.

  The possible workaround is to create a distributed table in the target cluster and perform a transfer to this table by selecting the `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` cleanup policy.

  {% endnote %}
