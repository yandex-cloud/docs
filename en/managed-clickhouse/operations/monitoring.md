---
title: "Monitoring the state of {{ CH }} clusters and hosts"
description: "In this tutorial, you'll learn how to monitor the state of {{ CH }} cluster and hosts."
---

# Monitoring the state of {{ CH }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mch-name }} cluster status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Monitoring** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   If the cluster uses a mechanism for replication and distribution of queries using [{{ ZK }}](../concepts/replication.md#zk), the **Monitoring** tab displays the following two tabs:

   * **Clickhouse**: Charts that show the operation of the entire {{ CH }} cluster and hosts.
   * **Zookeeper**: Charts that indicate the performance of {{ ZK }} hosts.

   If replication is not used or [{{ CK }}](../concepts/replication.md#ck) is used, charts from the **Clickhouse** tab are displayed on the general **Monitoring** tab.

{% endlist %}

{% list tabs %}

- ClickHouse

   * **Active locks per host**: The number of active locks per host.
   * **Average insert query time per host**: The average time it takes to execute insert queries on each host.
   * **Average query time per host**: The average time it takes to execute queries on each host.
   * **Average select query time per host**: The average time it takes to execute select queries on each host.
   * **Connections per host**: The number of connections on each host.
   * **Data parts**: The number of data parts.
   * **Databases**: The number of databases.
   * **CPU cores usage**: The number processor cores used.
   * **CPU cores usage per host**: The number of processor cores used on each host.
   * **CPU usage per host**: Usage of processor cores on each host.
   * **Disk read per host:** Disk read rate on each host (bytes per second).
   * **Disk space usage**: Shows how much disk space is used (in bytes).
   * **Disk space usage per host**: Shows how much disk space is used on each host (two charts are displayed: in bytes and %).
   * **Disk usage per host**: The speed of disk operations on each host (bytes per second).
   * **Disk write per host**: Disk write rate on each host (bytes per second).
   * **Failed insert queries per host**: The percentage of failed insert queries per second on each host.
   * **Failed queries per host**: The total percentage of failed queries per second on each host.
   * **Failed select queries per host**: The percentage of failed select queries per second on each host.
   * **Inode usage**: The number of inodes used (two charts are displayed: pieces and percent).
   * **Insert queries**: The number of insert queries per second.
   * **Insert queries per host**: The number of insert queries per second on each host.
   * **Inserted data**: Data insertion rate (bytes per second).
   * **Inserted data per host**: Data insertion rate on each host (bytes per second).
   * **Inserted rows per host**: Row insertion rate on each host (rows per second).
   * **Max data parts per partition**: The largest number of data parts per partition across tables. The limit for this value is set in the [DBMS settings](../concepts/settings-list#setting-merge-tree). Approaching the limit indicates excessive load or low efficiency of data insertion.
   * **Max replication delay across tables**: The longest replication delay across tables. Values greater than a few seconds may indicate excessive load or replication issues.
   * **Memory usage**: The use of RAM in bytes.
   * **Memory usage per host**: Shows how much RAM is used on each host (two charts are displayed: in bytes and %).
   * **Merged data**: Data merge rate (bytes per second).
   * **Merged data per host**: Data merge rate on each host (bytes per second).
   * **Merged rows per host**: Row merge rate on each host (rows per second).
   * **Network data received per host**: Network data receipt rate on each host (bytes per second).
   * **Network data sent per host**: Network data send rate on each host (bytes per second).
   * **Network usage per host**: The rate of data exchange over the network on each host (bytes per second).
   * **Read data**: Data read rate (bytes per second).
   * **Read data per host**: Data read rate on each host (bytes per second).
   * **Read rows per host**: Data read rate on each host (rows per second).
   * **Replication queue**: The total replication queue of all tables.
   * **Rows of MergeTree tables**: The number of rows in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.
   * **Select queries**: The number of select queries per second.
   * **Select queries per host**: The number of select queries per second on each host.
   * **Tables**: The number of tables.
   * **Total queries**: The total number of queries per second.
   * **Queries per host**: The total number of queries per second on each host.
   * **Waiting locks per host**: The number of pending locks on each host.

- Zookeeper

   * **Average latency per ZooKeeper host**: The average time it takes each ZooKeeper host to respond.
   * **Average transaction time per ClickHouse host**: The average time it takes each ClickHouse host to execute a transaction. Indicates the time spent by ClickHouse to access ZooKeeper.
   * **Connections per ZooKeeper host**: The number of connections on each ZooKeeper host.
   * **CPU cores usage**: The number processor cores used.
   * **CPU cores usage per host**: The number of processor cores used on each host.
   * **CPU usage per host**: Usage of processor cores on each host.
   * **Disk read per host:** Disk read rate on each host (bytes per second).
   * **Disk space usage**: Shows how much disk space is used (in bytes). Two charts are displayed: one for each host and one for all hosts.
   * **Disk space usage per host**: Shows how much disk space is used on each host (%).
   * **Disk usage per host**: The speed of disk operations on each host (bytes per second).
   * **Disk write per host**: Disk write rate on each host (bytes per second).
   * **Ephemeral nodes**: The number of Ephemeral nodes.

   {% note info %}

   For more information about Znodes, Ephemeral nodes, and Watches, see the [{{ ZK }} documentation](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

   {% endnote %}

   * **Memory usage**: The use of RAM in bytes.
   * **Memory usage per host**: Shows how much RAM is used on each host (two charts are displayed: in bytes and %).
   * **Network data received per host**: Network data receipt rate on each host (bytes per second).
   * **Network data sent per host**: Network data send rate on each host (bytes per second).
   * **Network usage per host**: The rate of data exchange over the network on each host (bytes per second).
   * **Outstanding requests per ZooKeeper host**: The number of requests being processed on each ZooKeeper host.
   * **Transactions**: The number of transactions per second.
   * **Transactions per ClickHouse host**: The number of transactions per second on each ClickHouse host.
   * **Watches**: The number of Watches.
   * **Znodes**: The number of Znodes.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mch-name }} hosts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Select the **Monitoring** tab.
   1. Select the host from the drop-down list. The host type is shown next to its name: `CLICKHOUSE` or `ZOOKEEPER`.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
   * **Disk read/write bytes**: The speed of disk operations (bytes per second).
   * **Disk IOPS**: The number of disk operations per second.
   * **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select.
      * **{{ mch-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mch-name }} — ZooKeeper** to configure ZooKeeper host alerts.
      * **{{ mch-name }} — Host Overview** to configure host alerts.
   1. In the desired chart with metrics, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
|----------------------------------------------|:--------------------------------------------------:|:----------------------------:|:----------------------------:|
| Maximum number of data chunks in a partition | `ch_system_async_metrics_MaxPartCountForPartition` | `250` | `150` |
| Number of failed queries | `ch_system_events_FailedQuery_rate` | 20% of the total number of queries | 10% of the total number of queries |
| Storage space used | `disk.used_bytes` | 95% of storage size | 80% of storage size |
| Number of healthy hosts | `is_alive` | `<number of hosts> - 2` | `<number of hosts> - 1` |

To determine the threshold values for the `ch_system_events_FailedQuery_rate` metric, use `Total queries` [for the cluster](#monitoring-cluster).

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-clickhouse).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mch-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-clickhouse` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `replica`, `follower`, or `leader` |
| subcluster_name | Subcluster type: `clickhouse_subcluster`, `zookeeper_subcluster` |
| shard | Shard ID |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu-avg.md) %}

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

{% cut "System event metrics" %}

ClickHouse native metrics from the [system.events]({{ ch.docs }}/operations/system-tables/events) table. For each metric, the increment (`inc`) and change `rate` per unit of time are calculated.

| Name<br/>Type |
| ----- |
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` |
| `ch_system_events_CannotWriteToWriteBufferDiscard_inc`<br/>`DGAUGE` |
| `ch_system_events_CannotWriteToWriteBufferDiscard_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileFunction_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileFunction_rate`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_inc`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DuplicatedInsertedBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_DuplicatedInsertedBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_inc`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_rate`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_Merge_inc`<br/>`DGAUGE` |
| `ch_system_events_Merge_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_NotCreatedLogEntryForMerge_inc`<br/>`DGAUGE` |
| `ch_system_events_NotCreatedLogEntryForMerge_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ObsoleteReplicatedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_ObsoleteReplicatedParts_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_Query_inc`<br/>`DGAUGE` |
| `ch_system_events_Query_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_rate`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_inc`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_rate`<br/>`DGAUGE` |
| `ch_system_events_Seek_inc`<br/>`DGAUGE` |
| `ch_system_events_Seek_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperInit_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperInit_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperList_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperList_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperMulti_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperMulti_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperRemove_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperRemove_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperSet_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperSet_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperUserExceptions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperUserExceptions_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_rate`<br/>`DGAUGE` |

{% endcut %}

{% cut "Current event metrics" %}

ClickHouse native metrics from the [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/) table.

| Name<br/>Type |
| ----- |
| `ch_system_metrics_ActiveAsyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_ActiveSyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_AsyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` |
| `ch_system_metrics_Connection`<br/>`DGAUGE` |
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` |
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` |
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` |
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFileBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFiles`<br/>`DGAUGE` |
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_Merge`<br/>`DGAUGE` |
| `ch_system_metrics_MySQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkReceive`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkSend`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` |
| `ch_system_metrics_PartMutation`<br/>`DGAUGE` |
| `ch_system_metrics_PartsActive`<br/>`DGAUGE` |
| `ch_system_metrics_PartsCommitted`<br/>`DGAUGE` |
| `ch_system_metrics_PartsCompact`<br/>`DGAUGE` |
| `ch_system_metrics_PartsDeleteOnDestroy`<br/>`DGAUGE` |
| `ch_system_metrics_PartsDeleting`<br/>`DGAUGE` |
| `ch_system_metrics_PartsInMemory`<br/>`DGAUGE` |
| `ch_system_metrics_PartsOutdated`<br/>`DGAUGE` |
| `ch_system_metrics_PartsPreActive`<br/>`DGAUGE` |
| `ch_system_metrics_PartsPreCommitted`<br/>`DGAUGE` |
| `ch_system_metrics_PartsTemporary`<br/>`DGAUGE` |
| `ch_system_metrics_PartsWide`<br/>`DGAUGE` |
| `ch_system_metrics_PendingAsyncInsert`<br/>`DGAUGE` |
| `ch_system_metrics_PostgreSQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_Query`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` |
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` |
| `ch_system_metrics_Read`<br/>`DGAUGE` |
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` |
| `ch_system_metrics_Revision`<br/>`DGAUGE` |
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` |
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` |
| `ch_system_metrics_SyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` |
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` |
| `ch_system_metrics_Write`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` |

{% endcut %}

{% cut "Query queue metrics" %}

ClickHouse native metrics from the [system.query_log]({{ ch.docs }}/operations/system-tables/query_log) table. For each metric, the increment per unit of time (second) is calculated.

| Name<br/>Type |
| ----- |
| `ch_system_query_log_insert_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_read_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_read_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_select_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_rows_inc`<br/>`DGAUGE` |

{% endcut %}

{% cut "Zookeeper metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `zk_avg_latency`<br/>`DGAUGE`, ms | Zookeeper host average response delay. |
| `zk_ephemerals_count`<br/>`DGAUGE`, pcs | Number of Ephemeral nodes. |
| `zk_num_alive_connections`<br/>`DGAUGE`, pcs | Number of connections. |
| `zk_outstanding_requests`<br/>`DGAUGE`, pcs | Requests being handled. |
| `zk_watch_count`<br/>`DGAUGE`, pcs | Number of Watches. |
| `zk_znode_count`<br/>`DGAUGE`, pcs | Number of Znodes. |

{% endcut %}

{% cut "Replication metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_replication-future_parts`<br/>`DGAUGE`, pcs | Number of data parts after MERGE and INSERT operations are completed. |
| `ch_replication-inserts_in_queue`<br/>`DGAUGE`, pcs | Number of enqueued data parts to be inserted.  |
| `ch_replication-is_alive`<br/>`DGAUGE`, 0/1 | Replication performance indicator.<br/>`1` if DB replication is alive, `0` if not. |
| `ch_replication-max_absolute_delay`<br/>`DGAUGE`, seconds | Maximum replication delay. |
| `ch_replication-merges_in_queue`<br/>`DGAUGE`, pcs | Merges enqueued. |
| `ch_replication-parts_to_check`<br/>`DGAUGE`, pcs | Number of data parts to be checked.  |
| `ch_replication-queue_size`<br/>`DGAUGE`, pcs | Merge and insert queue size.  |
| `ch_replication-tables`<br/>`DGAUGE`, pcs | Number of replicated tables. |

{% endcut %}

{% cut "System metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, pcs | Threshold value of active data parts in a table. When exceeded, ClickHouse throws the `Too many parts ...` exception. Set in the [settings](https://cloud.yandex.ru/docs/managed-clickhouse/concepts/settings-list#setting-merge-tree). It makes sense to analyze it along with the `ch_system_async_metrics_MaxPartCountForPartition` metric. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, bytes | Local disk partition size. |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, pcs | Maximum number of data chunks in a partition. |
| `ch_system_async_metrics_ReplicasMaxAbsoluteDelay`<br/>`DGAUGE`, seconds | Maximum replication delay. |
| `ch_system_async_metrics_ReplicasMaxQueueSize`<br/>`DGAUGE`, pcs | Maximum size of the replication queue. |

{% endcut %}

{% cut "Other metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |

{% endcut %}

{% endif %}
