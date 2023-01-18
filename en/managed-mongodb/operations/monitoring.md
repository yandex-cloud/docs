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
      * **{{ mes-name }} Host Overview** to configure host alerts.

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

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mmg-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-mongodb` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `secondary` |
| shard | Shard ID |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Disk metrics" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Disk operation metrics" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "RAM metrics" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "DbStats metrics" %}

Collected for each `<dbname>` database, including service ones (admin, config, and local).

| Name<br/>Type, units | Description |
| ----- | ----- |
| `db_stats_avgObjSize`<br/>`DGAUGE`, bytes | Average document size. |
| `db_stats_collections`<br/>`DGAUGE`, pcs | Number of DB collections. |
| `db_stats_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data in the DB. |
| `db_stats_fsTotalSize`<br/>`DGAUGE`, bytes | Total disk space of the file system where MongoDB stores data. |
| `db_stats_fsUsedSize`<br/>`DGAUGE`, bytes | Used disk space of the file system where MongoDB stores data. |
| `db_stats_indexSize`<br/>`DGAUGE`, bytes | Space used by DB indexes. |
| `db_stats_indexes`<br/>`DGAUGE`, pcs | Number of indexes in all DB collections. |
| `db_stats_numExtents`<br/>`DGAUGE`, pcs | Number of logical containers in all DB collections. |
| `db_stats_objects`<br/>`DGAUGE`, pcs | Number of objects (documents) in all DB collections. |
| `db_stats_ok`<br/>`DGAUGE`, 0/1 | dbStats command output.<br/>`1` if the command completed successfully, `0` if it failed. |
| `db_stats_scaleFactor`<br/>`DGAUGE`, pcs | The `scale` parameter used by the command. |
| `db_stats_storageSize`<br/>`DGAUGE`, bytes | Space allocated for document storage across DB collections, including free space. |
| `db_stats_views`<br/>`DGAUGE`, pcs | Number of DB views. |

{% endcut %}

{% cut "ServerStatus metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `server_status_admin_asserts.msg`<br/>`DGAUGE`, pcs | Number of message asserts triggered. |
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, pcs | Message assert increment per second. |
| `server_status_admin_asserts.regular`<br/>`DGAUGE`, pcs | Number of regular asserts triggered. |
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, pcs | Regular message assert increment per second. |
| `server_status_admin_asserts.rollovers`<br/>`DGAUGE`, pcs | Number of counter rollovers. |
| `server_status_admin_asserts.rollovers_rate`<br/>`DGAUGE`, pcs | Counter rollover increment per second.  |
| `server_status_admin_asserts.user`<br/>`DGAUGE`, pcs | Number of user asserts triggered. |
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, pcs | User assert increment per second. |
| `server_status_admin_asserts.warning`<br/>`DGAUGE`, pcs | Number of warnings. |
| `server_status_admin_asserts.warning_rate`<br/>`DGAUGE`, pcs | Warning increment per second. |
| `server_status_admin_connections.active`<br/>`DGAUGE`, pcs | Number of active connections. |
| `server_status_admin_connections.active_rate`<br/>`DGAUGE`, pcs | Active connection increment per second. |
| `server_status_admin_connections.adminConnections.readyThreads`<br/>`DGAUGE`, pcs | Ready threads. |
| `server_status_admin_connections.adminConnections.readyThreads_rate`<br/>`DGAUGE`, pcs | Ready thread increment per second. |
| `server_status_admin_connections.adminConnections.startingThreads`<br/>`DGAUGE`, pcs | Started threads. |
| `server_status_admin_connections.adminConnections.startingThreads_rate`<br/>`DGAUGE`, pcs | Started thread increment per second. |
| `server_status_admin_connections.adminConnections.threadsRunning`<br/>`DGAUGE`, pcs | Running threads. |
| `server_status_admin_connections.adminConnections.threadsRunning_rate`<br/>`DGAUGE`, pcs | Running thread increment per second. |
| `server_status_admin_connections.available`<br/>`DGAUGE`, pcs | Number of available connections. |
| `server_status_admin_connections.available_rate`<br/>`DGAUGE`, pcs | Available connection increment per second. |
| `server_status_admin_connections.current`<br/>`DGAUGE`, pcs | Number of incoming DB connections. |
| `server_status_admin_connections.current_rate`<br/>`DGAUGE`, pcs | Incoming DB connection increment per second. |
| `server_status_admin_connections.totalCreated`<br/>`DGAUGE`, pcs | Total number of incoming server connections, including terminated ones. |
| `server_status_admin_connections.totalCreated_rate`<br/>`DGAUGE`, number | Increment of total incoming server connections, including terminated ones. |
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, pcs | Number of [page faults](https://ru.wikipedia.org/wiki/Отказ_страницы). |
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, pcs | Number of operations in the current queue waiting for read lock release. |
| `server_status_admin_globalLock.currentQueue.readers_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for read lock release, per second. |
| `server_status_admin_globalLock.currentQueue.total`<br/>`DGAUGE`, pcs | Total number of operations in the current queue waiting for lock release. |
| `server_status_admin_globalLock.currentQueue.total_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for lock release, per second. |
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, pcs | Number of operations in the current queue waiting for write lock release. |
| `server_status_admin_globalLock.currentQueue.writers_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for write lock release, per second. |
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, pcs | Number of open cursors with the `DBQuery.Option.noTimeout` setting to prevent a timeout in the event of inactivity. |
| `server_status_admin_metrics.cursor.open.noTimeout_rate`<br/>`DGAUGE`, pcs | Increment of the number of open cursors with the `DBQuery.Option.noTimeout` setting to prevent a timeout in the event of inactivity, per second. |
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, pcs | Number of pinned open cursors. |
| `server_status_admin_metrics.cursor.open.pinned_rate`<br/>`DGAUGE`, pcs | Increment of the number of pinned open cursors, per second. |
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, pcs | Number of open cursors. |
| `server_status_admin_metrics.cursor.open.total_rate`<br/>`DGAUGE`, pcs | Increment of the number of open cursors, per second. |
| `server_status_admin_metrics.cursor.timedOut`<br/>`DGAUGE`, pcs | Number of open cursors that timed out. |
| `server_status_admin_metrics.cursor.timedOut_rate`<br/>`DGAUGE`, pcs | Increment of the number of cursors that timed out, per second. |
| `server_status_admin_metrics.document.deleted`<br/>`DGAUGE`, pcs | Number of documents deleted. |
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents deleted per second. |
| `server_status_admin_metrics.document.inserted`<br/>`DGAUGE`, pcs | Number of documents inserted. |
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents inserted per second. |
| `server_status_admin_metrics.document.returned`<br/>`DGAUGE`, pcs | Number of documents returned. |
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents returned per second. |
| `server_status_admin_metrics.document.updated`<br/>`DGAUGE`, pcs | Number of documents updated. |
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents updated per second. |
| `server_status_admin_metrics.getLastError.wtime.totalMillis`<br/>`DGAUGE`, ms | Number of milliseconds spent by the DB waiting for write confirmation. |
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, ms | Increment of the number of milliseconds spent by the DB waiting for write confirmation, per second. |
| `server_status_admin_metrics.operation.scanAndOrder`<br/>`DGAUGE`, pcs | Number of data sort operations with no index used. |
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, pcs | Increment of the number of data sort operations with no index used, per second.  |
| `server_status_admin_metrics.operation.writeConflicts`<br/>`DGAUGE`, pcs | Number of write conflicts. |
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, pcs | Increment of the number of write conflicts, per second. |
| `server_status_admin_metrics.queryExecutor.scanned`<br/>`DGAUGE`, pcs | Number of scanned index keys. |
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, pcs | Increment of the number of index keys scanned per second. |
| `server_status_admin_metrics.queryExecutor.scannedObjects`<br/>`DGAUGE`, pcs | Number of scanned documents. |
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents scanned per second. |
| `server_status_admin_metrics.ttl.deletedDocuments`<br/>`DGAUGE`, pcs | Number of documents deleted using the [TTL index](https://www.mongodb.com/docs/manual/core/index-ttl/). |
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents deleted using the [TTL index](https://www.mongodb.com/docs/manual/core/index-ttl/) per second. |
| `server_status_admin_metrics.ttl.passes`<br/>`DGAUGE`, pcs | Number of background operations for deleting documents from collections with the TTL index used. |
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, pcs | Increment of the number of background operations for deleting documents from collections with the TTL index used, per second. |
| `server_status_admin_opLatencies.commands.latency`<br/>`DGAUGE`, microseconds | Total delay in DB command execution, microseconds.  |
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, microseconds. | Change in the DB command execution delay per second. |
| `server_status_admin_opLatencies.commands.ops`<br/>`DGAUGE`, pcs | Number of operations on DB collections. |
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations on DB collections per second. |
| `server_status_admin_opLatencies.reads.latency`<br/>`DGAUGE`, microseconds. | Delay in read command execution, microseconds. |
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, microseconds. | Change in the read command execution delay per second. |
| `server_status_admin_opLatencies.reads.ops`<br/>`DGAUGE`, pcs | Number of DB collection reads. |
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB collection reads per second. |
| `server_status_admin_opLatencies.transactions.latency`<br/>`DGAUGE`, microseconds | Transaction latency in microseconds. |
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, microseconds. | Change in transaction latency per second. |
| `server_status_admin_opLatencies.transactions.ops`<br/>`DGAUGE`, pcs | Number of DB transactions. |
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB transactions per second. |
| `server_status_admin_opLatencies.writes.latency`<br/>`DGAUGE`, microseconds. | Delay in write command execution, microseconds. |
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, microseconds. | Change in the write command execution delay per second. |
| `server_status_admin_opLatencies.writes.ops`<br/>`DGAUGE`, pcs | Number of DB collection writes. |
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB collection writes per second. |
| `server_status_admin_opcounters.command`<br/>`DGAUGE`, pcs | Number of commands to the DB since its last start. Except `insert`, `update`, and `delete`. |
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, pcs | Increment of the number of commands to the DB per second. Except `insert`, `update`, and `delete`. |
| `server_status_admin_opcounters.delete`<br/>`DGAUGE`, pcs | Number of `delete` operations since the last start of the DB. |
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, pcs | Increment of the number of `delete` operations in the DB per second. |
| `server_status_admin_opcounters.getmore`<br/>`DGAUGE`, pcs | Number of `getmore` operations since the last start of the DB. |
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, pcs | Increment of the number of `getmore` operations in the DB per second. |
| `server_status_admin_opcounters.insert`<br/>`DGAUGE`, pcs | Number of `insert` operations since the last start of the DB. |
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, pcs | Increment of the number of `insert` operations in the DB per second. |
| `server_status_admin_opcounters.query`<br/>`DGAUGE`, pcs | Number of `query` operations since the last start of the DB. |
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, pcs | Increment of the number of `query` operations in the DB per second. |
| `server_status_admin_opcounters.update`<br/>`DGAUGE`, pcs | Number of `update` operations since the last start of the DB. |
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, pcs | Increment of the number of `update` operations in the DB per second. |
| `server_status_admin_opcountersRepl.command`<br/>`DGAUGE`, pcs | Number of replicated commands to the DB since its last start. |
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated commands to the DB per second. |
| `server_status_admin_opcountersRepl.delete`<br/>`DGAUGE`, pcs | Number of replicated `delete` operations since the last start of the DB. |
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `delete` operations in the DB per second. |
| `server_status_admin_opcountersRepl.getmore`<br/>`DGAUGE`, pcs | Number of replicated `getmore` operations since the last start of the DB. |
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `getmore` operations in the DB per second. |
| `server_status_admin_opcountersRepl.insert`<br/>`DGAUGE`, pcs | Number of replicated `insert` operations since the last start of the DB. |
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `insert` operations in the DB per second. |
| `server_status_admin_opcountersRepl.query`<br/>`DGAUGE`, pcs | Number of replicated `query` operations since the last start of the DB. |
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `query` operations in the DB per second. |
| `server_status_admin_opcountersRepl.update`<br/>`DGAUGE`, pcs | Number of replicated `update` operations since the last start of the DB. |
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `update` operations in the DB per second. |
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, bytes | Size of the WiredTiger cache used. |
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache_rate`<br/>`DGAUGE`, bytes | Increment of the size of the WiredTiger cache used, per second. |
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction`<br/>`DGAUGE`, pcs | Number of pages evicted at a checkpoint. |
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction_rate`<br/>`DGAUGE`, pcs | Increment of the number of pages evicted at a checkpoint, per second. |
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, bytes | Maximum cache size set. |
| `server_status_admin_wiredTiger.cache.modified_pages_evicted`<br/>`DGAUGE`, pcs | Number of modified RAM pages evicted. |
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, pcs | Increment of the number of modified RAM pages evicted per second. |
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, bytes | Size of the dirty cache. |
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache_rate`<br/>`DGAUGE`, bytes | Increment of the size of the dirty cache, per second. |
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted`<br/>`DGAUGE`, pcs | Number of unmodified RAM pages evicted. |
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, pcs | Increment of the number of unmodified RAM pages evicted per second. |
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, pcs | Number of used tickets of concurrent read transactions. |
| `server_status_admin_wiredTiger.concurrentTransactions.read.out_rate`<br/>`DGAUGE`, pcs | Increment of the number of used tickets of concurrent read transactions, per second. |
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, pcs | Number of available tickets of concurrent read transactions. |
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets_rate`<br/>`DGAUGE`, pcs | Increment of the number of tickets of concurrent read transactions, per second. |
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, pcs | Number of used tickets of concurrent write transactions. |
| `server_status_admin_wiredTiger.concurrentTransactions.write.out_rate`<br/>`DGAUGE`, pcs | Increment of the number of used tickets of concurrent write transactions, per second. |
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, pcs | Number of available tickets of concurrent write transactions. |
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets_rate`<br/>`DGAUGE`, pcs | Increment of the number of available tickets of concurrent write transactions, per second. |
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, pcs | Running transactions. |
| `server_status_admin_wiredTiger.transaction.transaction_begins_rate`<br/>`DGAUGE`, pcs | Running transaction increment per second. |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, ms | Maximum checkpoint creation time. |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, ms | Minimum checkpoint creation time. |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, ms | Most recent checkpoint creation time (ms). |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints`<br/>`DGAUGE`, pcs | Number of transaction checkpoints. |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints_rate`<br/>`DGAUGE`, pcs | Transaction checkpoint increment per second. |
| `server_status_admin_wiredTiger.transaction.transactions_committed`<br/>`DGAUGE`, pcs | Committed transactions. |
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, pcs | Committed transaction increment per second. |
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back`<br/>`DGAUGE`, pcs | Transactions rolled back. |
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, pcs | Rolled back transaction increment per second. |

{% endcut %}

{% cut "Other metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if not. |
| `oplog-diff`<br/>`DGAUGE`, ms | Operation log size (ms). |
| `oplog-firstTs`<br/>`DGAUGE`, ms | Timestamp of the first operation in the operation log. |
| `oplog-lastTs`<br/>`DGAUGE`, ms | Timestamp of the last operation in the operation log. |
| `oplog-maxSize`<br/>`DGAUGE`, bytes | Maximum size of the operation log. |
| `replset_status-replicationLag`<br/>`DGAUGE`, seconds. | Replication lag. |

{% endcut %}

{% endif %}
