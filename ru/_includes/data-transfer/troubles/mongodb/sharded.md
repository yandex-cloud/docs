### Ошибка при трансфере шардированного кластера {#sharded}

**Решение**: задайте в [параметре трансфера](../../../../data-transfer/operations/transfer.md#update) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** количество воркеров, равное количеству переносимых коллекций.
