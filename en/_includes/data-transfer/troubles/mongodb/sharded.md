### Error when transferring a sharded cluster {#sharded}

**Solution**: In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** [transfer parameter](../../../../data-transfer/operations/transfer.md#update), specify the number of [workers](../../../../data-transfer/concepts/index.md#worker) equal to the number of collections being transferred.
