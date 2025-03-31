### Replication restarts frequently {#replication-restarts}

Frequent replication restarts can signify an issue in the data source or target, as well as a memory shortage.

**Solution**:

 * To identify issues in the source and target, run performance diagnostics on them.
  * If the source-target pair is at the [GA](../../../../overview/concepts/launch-stages.md) stage and is being [charged](../../../../data-transfer/pricing.md), increase the amount of computing resources in the **Runtime environment** transfer settings section.

> Example: How to [change the amount of computing resources](../../../../data-transfer/operations/transfer.md#update) for a transfer and [run performance diagnostics](../../../../managed-mysql/operations/performance-diagnostics.md) for a {{ mmy-name }} cluster.