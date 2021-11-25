# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a {{ mes-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

{% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mes-name }} cluster status:

1. Go to the folder page and select **{{ mes-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The following charts are displayed on the page:

* **Active shards**: The number of active [primary shards](../concepts/scalability-and-resilience.md) and the total number of active shards in the cluster.
* **Deletion rate**: The number of delete operations per second per host.
* **Disk space usage percent**: Shows how much disk space is used on each host (%).
* **Flushes**: The number of transaction log flush operations per host.

* **Health status**: Shows the cluster's health and technical condition:

    * 0 (<q>red</q>): The cluster is unhealthy or partially functional. At least one of the primary shards is unavailable. If the cluster responds to queries, incomplete search results will be returned.
    * 1 (<q>yellow</q>): The cluster is healthy. There is no access to at least one of the replica shards. The search results in the cluster responses are complete, but if there're more unavailable shards, the cluster's performance will be disrupted.
    * 2 (<q>green</q>): The cluster is healthy. All cluster shards are available.

* **Indexing rate**: The number of indexing operations per second per host.
* **JVM heap**: The use of JVM heap memory per host (in bytes).
* **JVM heap pressure**: The use of a pool of long-lived JVM objects per host (%).
* **JVM old collections**: The number of garbage collection cycles in the pool of long-lived JVM objects per host.
* **JVM young collections**: The number of garbage collection cycles in the pool of new JVM objects per host.
* **Merges**: The number of index segment merges per host.
* **Nodes**: The number of hosts with the [`Data node` role](../concepts/hosts-roles.md) and the total number of hosts in the cluster.
* **Open file descriptors**: The number of open file descriptors per host.
* **Other shards**: The number of inactive shards in each of the following states:

    * Delayed unassigned: Host assignment is delayed.
    * Unassigned: There is no assigned host.
    * Relocating: Moving to another host.
    * Initializing: Being initialized.

* **Process CPU**: Usage of processor cores on each host due to the JVM {{ ES }} process.
* **Query cache**: The number of queries in the cache on each host.
* **Read bytes**: Disk read rate on each host (bytes per second).
* **Read operations**: The number of read operations per second per host.
* **Refreshes**: The number of index segment refresh operations per host.
* **Search queries**: The number of search queries per second per host.
* **Segments**: The number of index segments per host.
* **Store size**: The size of index storage on disk (in bytes).
* **Write bytes**: Disk write rate on each host (bytes per second).
* **Write operations**: The number of write operations per second per host.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mes-name }} hosts:

1. Go to the folder page and select **{{mes-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU**: The loading of processor cores. As the load goes up, the **Idle** value goes down.
* **Disk Bytes**: The speed of disk operations (bytes per second).
* **Disk IOPS**: The number of disk operations per second.
* **Memory**: The use of RAM in bytes. At high loads, the value of the Free parameter goes down while those of other parameters go up.
* **Network Bytes**: The speed of data exchange over the network (bytes per second).
* **Network Packets**: The number of packets exchanged over the network per second.

