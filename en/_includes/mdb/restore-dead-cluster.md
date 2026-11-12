If your cluster is in the `DEAD` status, create a [support]({{ link-console-support }}) ticket. If the cluster is small, you can try to restore it from a backup without waiting for a response from the support team. The time it takes to restore a cluster depends on the amount of data and the configuration of the new cluster.

Restoration creates a separate cluster. Select an available backup or recovery point, given your acceptable loss of recent changes: data written after the selected point will not be included in the new cluster. Once restoration is complete, redirect your applications to the new cluster.

If high load caused the unavailability, restoring the cluster from a backup will not fix the issue on its own. Before resuming full load, limit the query rate. Once the cluster is restored, analyze its resource consumption and optimize the load so the issue does not recur.
