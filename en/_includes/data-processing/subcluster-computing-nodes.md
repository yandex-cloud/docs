* In `deployMode=cluster` mode, when the driver is deployed on one of the cluster's `compute` hosts, 4–8 CPU cores and 16 GB RAM are sufficient for the subcluster with the `master` host.
* In `deployMode=client` mode, when the driver is deployed on the cluster's master host, the computing power depends on the job logic and the number of concurrently running jobs.

For more information about driver deploy modes and computing resource consumption, see [{#T}](../../data-proc/concepts/spark-sql.md#resource-management).
