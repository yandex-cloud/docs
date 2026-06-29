* In `deployMode=cluster` mode, when the driver runs on one of the cluster's `compute` hosts, a subcluster with the `master` host requires 4–8 CPU cores and 16 GB of RAM.
* In `deployMode=client` mode, when the driver run on the cluster's master host, the compute capacity depends on the job logic and the number of concurrent jobs.

For more information on driver deploy modes and computing resource usage, see [{#T}](../../data-proc/concepts/spark-sql.md#resource-management).
