### Данные в источнике не подходят для шардирования {#cannot-get-delimiters}

Активация трансфера из источника {{ MG }} завершается с ошибкой:

```text
ERROR: Unable to Activate
error: "failed to execute mongo activate hook: Snapshot loading failed: unable to sharded upload tables: unable to sharded upload(main worker) tables: unable to shard tables for operation id_операции: unable to split table, err: cannot get delimiters: there are two or more types of objects in the sharding index"
```

Ошибка `cannot get delimiters: there are two or more types of objects in the sharding index` означает, что на источнике в коллекции в поле `id` встречаются данные разных типов, и поэтому его нельзя использовать для шардирования.

**Решение**:

Укажите в [настройках трансфера](../../../../data-transfer/operations/transfer.md#update-copy-repl) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** 1 воркер и 1 поток, чтобы отключить шардирование.

После этого [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
