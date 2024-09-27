### Source data cannot be sharded {#cannot-get-delimiters}

The transfer from a {{ MG }} source fails with the following error message:

```text
ERROR: Unable to Activate
error: "failed to execute mongo activate hook: Snapshot loading failed: unable to shard upload tables: unable to shard upload (main worker) tables: unable to shard tables for operation ID: unable to split table, err: cannot get delimiters: there are two or more types of objects in the sharding index"
```

The `cannot get delimiters: there are two or more types of objects in the sharding index` error means that the source collection `id` field contains different data types, making the source unsuitable for sharding.

**Solution**:

In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** [transfer settings](../../../../data-transfer/operations/transfer.md#update-copy-repl), specify one worker and one stream to disable sharding.

Once that is done, [activate](../../../../data-transfer/operations/transfer.md#activate) the transfer again.
