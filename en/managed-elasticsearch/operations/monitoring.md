# Monitoring the state of {{ ES }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mes-name }} cluster status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster and open the **Monitoring** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   The page displays the following charts:

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

   {% note info %}

   {% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

   {% endnote %}

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mes-name }} hosts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{mes-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Select the **Monitoring** tab.
   1. Select the host from the drop-down list.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU**: The load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk Bytes**: The speed of disk operations (bytes per second).
   * **Disk IOPS**: The number of disk operations per second.
   * **Memory**: The use of RAM in bytes. At high loads, the value of `Free` goes down while the other values go up.
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select:

      * **{{ mes-name }}** to configure cluster alerts.
      * **{{ mes-name }}**: Host Overview to configure host alerts.

   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter | Formula | `Alarm` | `Warning` |
|----------------------------------------------|:-----------------------------------------:|:----------------------:|:---------------------------------:|:---------------------------------:|
| Cluster status | `elasticsearch_status` | `bottom_last(1)` | `Equal to 0` | `Equal to 1` |
| Number of unassigned shards | `elasticsearch_unassigned_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of relocated shards | `elasticsearch_relocating_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of initialized shards | `elasticsearch_initializing_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of delayed assignment shards | `elasticsearch_delayed_unassigned_shards` | `top_last(1)` | `Greater than 0` |                                   |
| JVM heap memory used | `elasticsearch_jvm_mem_heap_used_percent` | `top_last(1)` | Over 90% of host RAM |                                   |
| Storage space used | `elasticsearch_fs_total_used_percent` | `top_last(1)` | Over 90% of the storage size | Over 85% of the storage size |
| Using the JVM long-lived object pool | `elasticsearch_jvm_mem_heap_pressure` | `top_last(1)` | Over 90% of host RAM | Over 75% of host RAM |

You can view the host's current storage size and RAM amount in the [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-elasticsearch).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
