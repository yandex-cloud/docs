### Replication lag is growing {#row-max-lag-constant}

Lag growth can be caused by increasing number of events from the source, data target problems, insufficient resources, or operational errors.

**Solution**:

  * [Check your target settings](../../../../data-transfer/operations/endpoint/index.md#get).
    * If the source-target pair is at the [GA](../../../../overview/concepts/launch-stages.md) stage and on a [paid plan](../../../../data-transfer/pricing.md), increase the amount of computational resources in the **Runtime environment** transfer settings section.
  * To learn more about the status of the transfer, explore [logs](../../../../data-transfer/metrics.md) in {{ monitoring-name }}.
  * To identify issues in the source and target, run performance diagnostics on them.


> Example: How to [change the amount of computing resources](../../../../data-transfer/operations/transfer.md#update) for a transfer and [run performance diagnostics](../../../../managed-mysql/operations/performance-diagnostics.md) for a {{ mmy-name }} cluster.