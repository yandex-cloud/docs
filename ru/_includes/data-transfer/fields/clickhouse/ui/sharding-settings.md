**{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}** — задайте настройки для [шардирования](../../../../../managed-clickhouse/concepts/sharding.md):

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}** — шардирование не используется.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}** — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки. Укажите имя колонки для шардирования в соответствующем поле.

    Для шардирования по конкретным значениям колонки укажите их в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}**. Это поле определяет соответствие значений колонки и индекса шарда (порядковый номер шарда в отсортированном по именам списке шардов) для шардирования по конкретным значениям данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}** — данные по шардам будут распределяться на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** и шардирует данные только по идентификатору трансфера.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_round_robin.title }}** — данные по шардам будут распределяться случайным образом (количество данных на каждом шарде будет примерно одинаковым).
