#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

* CPU, memory, network, and disk utilization, in absolute terms.
* Memory, network, and disk utilization as a percentage of the set limits for the cluster’s host class.
* Total cluster data size and available storage space remaining.

For DB hosts, you can monitor metrics specific to their DBMS type. For example, for {{ GP }}, you can track:

* Average query execution time.
* Number of queries per second.
* Number of errors in logs.

You can monitor metrics with a minimum granularity of five seconds.

For more information, see [Monitoring the cluster and host state](../../managed-greenplum/operations/monitoring.md).

#### Which charts reflect the state of hybrid storage? {#hybrid-storage-monitoring}

On the **Hybrid Storage** graph, you can track the number of files in cold storage and their total size. The number and total size of files may decrease over time due to the hybrid storage cleanup procedure. For more information, see [{#T}](../../managed-greenplum/concepts/hybrid-storage.md)

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}
