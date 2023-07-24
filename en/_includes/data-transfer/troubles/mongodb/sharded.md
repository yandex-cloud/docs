### Error when transferring a sharded cluster {#sharded}

**Solution:** in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** [transfer parameter](../../../../data-transfer/operations/transfer.md#update), specify the number of workers equal to the number of collections being transferred.
