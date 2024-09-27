### Insufficient resources {#insufficiency-resources}

Error message:

```text
Warn(Activate): Snapshot loading failed:
snapshot tasks failed: main uploader failed:
errors detected on secondary workers: secondary worker #3 failed:
pod instance restarted 5h41m39.092446028s ago
```

**Solution**:

If the `pod instance restarted` error was caused by the transfer VM running out of memory (OOM), you may consider the following solutions:

* Decrease the number of threads per worker in the [transfer settings](../../../data-transfer/operations/transfer.md#update-copy-repl). At the same time, you can increase the number of workers to maintain the overall level of [sharding](../../../data-transfer/concepts/sharded.md) (parallel loading) at the copy stage. Since threads share the worker's resources, decreasing the number of threads per worker will increase the amount of resources available to each thread. As a result, a thread will be less likely to run out of memory.

* For [transfers at the GA stage](../../../data-transfer/transfer-matrix.md), you can increase computing resources in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.runtime.title }}** [transfer setting](../../../data-transfer/operations/transfer.md#update). Such transfers are [chargeable](../../../data-transfer/pricing.md), so with increased computing resources your data transfer costs will be higher.

* For [transfers at the Preview stage](../../../data-transfer/transfer-matrix.md), you cannot scale computing resources on your own: contact [support]({{ link-console-support }}) or your account manager.

If the `pod instance restarted` error is not caused by OOM, contact [support]({{ link-console-support }}).
