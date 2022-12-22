# Monitoring the state of {{ MG }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#cluster}

To view detailed information about the {{ mmg-name }} cluster status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts open on the page:

* **Asserts total**: The number of [assert](https://docs.mongodb.com/manual/reference/command/serverStatus/#mongodb-serverstatus-serverstatus.asserts) triggered in the cluster.
* **Average operation time per host**: The average time of command execution by each host (in microseconds).
* **Average operations time on primary**: The average command execution time on primary replicas (in microseconds).
* **Average operations time on secondaries**: The average command execution time on secondary replicas (in microseconds).
* **CPU usage per host**: vCPU usage on each host (in thousandths).
* **CPU usage per host, top 5 hosts**: 5 hosts with the highest vCPU utilization (%).
* **Configured oplog size per host**: The size of the oplog on each cluster host (in GB).
* **Connections per host**: The average number of connections to each host.
* **Data size on primary, top 5 databases**: The size of the five largest DBs on the primary replica (in bytes). The chart counts data without [compression](../concepts/settings-list.md#setting-wired-tiger).
* **Disk read per host, top 5 hosts**: 5 hosts with the highest load on reading from the disk subsystem (bytes per second).
* **Disk space usage per host, top 5 hosts**: 5 hosts that take up the most disk space (two charts are displayed: in bytes and %). The chart counts data after [compression](../concepts/settings-list.md#setting-wired-tiger).
* **Disk usage per host, top 5 hosts**: 5 hosts with the highest load on the storage I/O subsystem (bytes per second).
* **Disk write per host, top 5 hosts**: 5 hosts with the highest load on writing to the disk subsystem (kilobytes per second).
* **Documents affected on primary**: The average number of documents affected by queries on the primary replica.
* **Documents affected on secondaries**: The average number of documents affected by queries on all secondary replicas.
* **Documents affected per host**: The average number of documents affected by queries on each host.
* **Hosts available for read**: The number of hosts that accept read data queries.
* **Hosts available for write**: The number of hosts that accept write data queries.
* **Index size on primary, top 5 indexes**: The size of the five largest indexes on the primary replica (in bytes).
* **Memory usage per host**: The amount of RAM used by each host (in bytes).
* **Memory usage per host, top 5 hosts**: 5 hosts that use the most RAM (%).
* **Network data received per host, top 5 hosts**: 5 hosts with the highest network load on reading (kilobytes per second).
* **Network data sent per host, top 5 hosts**: 5 hosts with the highest network load on writing (kilobytes per second).
* **Network usage per host, top 5 hosts**: 5 hosts with the highest total network load (kilobytes per second).
* **Open cursors total**: The number of open cursors in the cluster.
* **Oplog window**: Time interval, for which replication data is stored in each host's oplog collection.
* **Page faults per host**: The number of [page faults]({% if lang=="ru" %}https://ru.wikipedia.org/wiki/Отказ_страницы{% endif %}{% if lang =="en" %}https://en.wikipedia.org/wiki/Page_fault{% endif %}) on each host.
* **Queries on secondaries**: The average number of queries of each type on secondary replicas.
* **Queries on primary**: The average number of each type of query on primary replicas.
* **Read operations count, top 5 collections**: 5 collections with the longest time spent in reads.
* **Readers/writers active queue per host, top 5**: The total size of the 5 largest queues for each host:
   * With read requests.
   * With write requests.
* **Replicated queries**: The average number of replicated queries in the cluster.
* **Replication lag per host and write_concern wait**: Replication lag on each host and waiting time for [write concern](https://docs.mongodb.com/manual/reference/write-concern/) (in seconds).
* **Scan and order per host**: The number of data sorts without index usage on each host.
* **Scanned / returned**: Shows the following ratios:
   * `scanned_docs / returned_docs`: Documents scanned to documents returned.
   * `scanned_keys / returned_docs`: Index keys scanned to documents returned.
* **TTL indexes activity**: The total number of [TTL indexes](https://docs.mongodb.com/manual/core/index-ttl/).
* **Total operations count on cluster**: The total number of operations performed in the cluster.
* **Total operations time on cluster**: The total operation execution time in the cluster (in milliseconds).
* **WiredTiger cache pages evicted on primary**: The average number of memory pages evicted on the primary replica.
* **WiredTiger cache state on primary**: WiredTiger cache usage on the primary replica (in bytes).
* **WiredTiger checkpoint time on primary**: The time it takes to create WiredTiger checkpoints on the primary replica (in milliseconds).
* **WiredTiger concurrent transactions on primary**: The average number of parallel transactions on the primary replica.
* **WiredTiger transactions state on primary**: The average number of transactions on each level on the primary replica.
* **Write conflicts per host**: The number of write conflicts on each host.
* **Write operations count, top 5 collections**: 5 collections with the longest time spent in writes.

## Monitoring the state of hosts {#hosts}

To view detailed information about the status of individual {{ mmg-name }} hosts:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
1. Select the host from the drop-down list. You'll see the host role (`PRIMARY` or `SECONDARY`) and type (`MONGOCFG`, `MONGOD`, `MONGOINFRA`, or `MONGOS`) next to the host name.

This page displays charts showing the load on an individual host in the cluster:

* **CPU**: The load on processor cores. As the load goes up, the **Idle** value goes down.
* **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Disk bytes**: The speed of disk operations (bytes per second).
* **Disk IOPS**: The number of disk operations per second.
* **Network Bytes**: The speed of data exchange over the network (bytes per second).
* **Network Packets**: The number of packets exchanged over the network per second.

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.

   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.

   1. Under **Service dashboards**, select:

      * **{{ mes-name }}** to configure cluster alerts.
      * **{{ mes-name }} — Host Overview** to configure host alerts.

   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.

   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).

   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.

   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter                      | `Alarm`                   | `Warning`                 |
|---------------------------------|:-------------------------------:|:------------------------:|:------------------------:|
| DB write availability | `can_write`                      | `Equals 0`                 | —                         |
| Replication delay              | `replset_status-replicationLag` | `180`,,,,,,,,,,,,,,,,,,,, | `30`,,,,,,,,,,,,,,,,,,,,, |
| Storage space used | `disk.used_bytes`                | 90% of storage size  | 70% of storage size  |

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-mongodb).

{% endif %}

### Monitoring the switch to read-only mode {#read-only-alert}

To monitor storage usage on cluster hosts and get notifications when free space is about to run out:

{% if audience == "external" %}
1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
   {% else %}
1. Create an alert.
   {% endif %}
1. Add the `disk.free_bytes` status metric.

   To do this, create a query in the query builder:

   `service={{ mmg-name }}` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Set the alert threshold values in the alert settings:
   * **Trigger condition**: Set the `Less than or equal to` condition for the size of free disk space to trigger the alert.

      Recommended threshold values depending on the storage size:

      | Storage size, GB | `Alarm` | `Warning` |
      |---------------------|-------------|------------------|
      | ⩽ 600 | `1G` (1 GB) | `1500M` (1.5 GB) |
      | > 600 | `6G` (6 GB) | `10G` (10 GB) |

   * **Additional settings** → **Aggregation function**: Select the `Minimum` value (the minimum metric value for the period).

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
