# Monitoring the state of clusters and hosts

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
   * **CPU cores usage**: The number processor cores used.
   * **CPU cores usage per host**: The number of processor cores used on each host.
   * **CPU usage per host**: Usage of processor cores on each host.
   * **Disk read per host:** Disk read rate on each host (bytes per second).
   * **Disk space usage**: Shows how much disk space is used (in bytes).
   * **Disk space usage per host**: Shows how much disk space is used on each host (two charts are displayed: in bytes and %).
   * **Disk usage per host**: The speed of disk operations on each host (bytes per second).
   * **Disk write per host**: Disk write rate on each host (bytes per second).
   * **Failed insert queries per host**: The number of failed insert queries per second on each host.
   * **Failed queries per host**: The total number of failed queries per second on each host.
   * **Failed select queries per host**: The number of failed select queries per second on each host.
   * **Inserted data**: Data insertion rate (bytes per second).
   * **Inserted data per host**: Data insertion rate on each host (bytes per second).
   * **Inserted rows per host**: Row insertion rate on each host (rows per second).
   * **Insert queries**: The number of insert queries per second.
   * **Insert queries per host**: The number of insert queries per second on each host.
   * **Max data parts per partition**: The largest number of data parts per partition across tables. The limit for this value is set in the [DBMS settings](../concepts/settings-list#setting-merge-tree). Approaching the limit indicates excessive load or low efficiency of data insertion.
   * **Max replication delay across tables**: The longest replication delay across tables. Values greater than a few seconds may indicate excessive load or replication issues.
   * **Max replication queue across tables**: The maximum length of a table replication queue. Values greater than a few units may indicate excessive load or replication issues.
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
   * **Read parts per host**: Data part read rate on each host (rows per second).
   * **Select queries**: The number of select queries per second.
   * **Select queries per host**: The number of select queries per second on each host.
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

   * **CPU**: The load on processor cores. As the load goes up, the **Idle** value goes down.
   * **Disk bytes**: The speed of disk operations (bytes per second).
   * **Disk IOPS**: The number of disk operations per second.
   * **Memory**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select.
      * **{{ mch-name }} Cluster Overview** to configure cluster alerts.
      * **{{ mch-name }} ZooKeeper** to configure ZooKeeper host alerts.
      * **{{ mch-name }} Host Overview** to configure host alerts.
   1. In the desired chart with metrics, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. {% if audience == "external" %}For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md). {% endif %}
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

{% if audience != "internal" %}
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
