### Error at data copying stage {#history-lost}

The _{{ dt-type-copy-repl }}_ type transfer terminates with the following error at the copying stage:

```text
encountered non-recoverable resume token error. Sync cannot be resumed from this state and must be terminated and re-enabled to continue functioning: (ChangeStreamHistoryLost) Resume of change stream was not possible, as the resume point may no longer be in the oplog.
```

The `ChangeStreamHistoryLost` error occurs when the total copy time of the {{ MG }} (Managed Service for MongoDB) source cluster data exceeds the operation log (oplog) time window size. You can check the current time window size in the management console. See the **Oplog window** chart of the [cluster monitoring page](../../../../storedoc/operations/monitoring.md).


**Solution**:

* Increase the oplog size (10% of the cluster disk size by default). To increase the oplog size in a {{ mmg-name }} source cluster, contact [support]({{ link-console-support }}). To change the oplog size in case of a custom source installation, see the relevant {{ MG }} guide.
* Enable [parallel data copying](../../../../data-transfer/concepts/sharded.md) to speed up the copying stage.
* Limit the list of transferable objects in the [transfer settings](../../../../data-transfer/operations/transfer.md#create).

Once that is done, [activate](../../../../data-transfer/operations/transfer.md#activate) the transfer again.
