Reaching the timeout does not stop the process immediately: data redistribution will be completed for the tables currently being processed (`IN PROGRESS` status). You can request the [status of the tables](../../../../managed-greenplum/operations/cluster-expand.md#redistribute-monitoring) if the cluster is not closed from load.

The minimum value is `0`. The timeout will be calculated automatically depending on the cluster configuration and data size.

The maximum value depends on whether background data redistribution is enabled:

* If enabled, the maximum value is `28800` (eight hours).
* If disabled, the maximum value is not limited.
