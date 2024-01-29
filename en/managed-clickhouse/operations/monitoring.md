---
title: "Monitoring the state of {{ CH }} clusters and hosts"
description: "In this tutorial, you will learn how to monitor the state of {{ CH }} clusters and their hosts."
---

# Monitoring the state of {{ CH }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mch-name }} cluster state:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   If the cluster uses a mechanism for replication and distribution of queries using [{{ ZK }}](../concepts/replication.md#zk), the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** tab displays the following two tabs:

   * **{{ ui-key.yacloud.clickhouse.title_clickhouse }}**: Charts that show the operation of the entire {{ CH }} cluster and hosts.
   * **{{ ui-key.yacloud.clickhouse.title_zookeeper }}**: Charts that indicate the performance of {{ ZK }} hosts.

   If replication is not used or [{{ CK }}](../concepts/replication.md#ck) is used, charts from the **{{ ui-key.yacloud.clickhouse.title_clickhouse }}** tab are displayed on the general **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** tab.

{% endlist %}

{% list tabs %}

- {{ ui-key.yacloud.clickhouse.title_clickhouse }}

   * **Active locks per host**: Number of active locks per host.
   * **Average insert query time per host**: Average time it takes to execute insert queries on each host.
   * **Average query time per host**: Average time it takes to execute queries on each host.
   * **Average select query time per host**: Average time it takes to execute select queries on each host.
   * **Connections per host**: Number of connections on each host.
   * **Data parts**: Number of data parts.
   * **Databases**: Number of databases.
   * **CPU cores usage**: Number of processor cores used.
   * **CPU cores usage per host**: Number of processor cores used on each host.
   * **CPU usage per host**: Usage of processor cores on each host.
   * **Disk read per host:** Disk read rate on each host (in bytes per second).
   * **Disk space usage**: Shows how much disk space is used (in bytes).
   * **Disk space usage per host**: Shows how much disk space is used on each host (two charts are displayed in bytes and %).
   * **Disk usage per host**: Speed of disk operations on each host (in bytes per second).
   * **Disk write per host**: Disk write rate on each host (in bytes per second).
   * **Failed insert queries per host**: Percentage of failed insert queries per second on each host.
   * **Failed queries per host**: Total percentage of failed queries per second on each host.
   * **Failed select queries per host**: Percentage of failed select queries per second on each host.
   * **Inode usage**: Number of inodes used (two charts are displayed in pieces and %).
   * **Insert queries**: Number of insert queries per second.
   * **Insert queries per host**: Number of insert queries per second on each host.
   * **Inserted data**: Data insertion rate (in bytes per second).
   * **Inserted data per host**: Data insertion rate on each host (in bytes per second).
   * **Inserted rows per host**: Row insertion rate on each host (in rows per second).
   * **Max data parts per partition**: Highest number of data parts per partition among all tables. The limit for this value is set in the [DBMS settings](../concepts/settings-list#setting-merge-tree). Approaching the limit indicates excessive load or low efficiency of data insertion.
   * **Max replication delay across tables**: Longest replication delay across tables. Values greater than a few seconds may indicate excessive load or replication issues.
   * **Memory usage**: Use of RAM, in bytes.
   * **Memory usage per host**: Shows how much RAM is used on each host (two charts are displayed in bytes and %).
   * **Merged data**: Data merge rate (in bytes per second).
   * **Merged data per host**: Data merge rate on each host (in bytes per second).
   * **Merged rows per host**: Row merge rate on each host (in rows per second).
   * **Network data received per host**: Network data receipt rate on each host (in bytes per second).
   * **Network data sent per host**: Network data send rate on each host (in bytes per second).
   * **Network usage per host**: Rate of data exchange over the network on each host (in bytes per second).
   * **Read data**: Data read rate (in bytes per second).
   * **Read data per host**: Data read rate on each host (in bytes per second).
   * **Read rows per host**: Data read rate on each host (in rows per second).
   * **Replication queue**: Total replication queue of all tables.
   * **Rows of MergeTree tables**: Number of rows in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.
   * **Select queries**: Number of select queries per second.
   * **Select queries per host**: Number of select queries per second on each host.
   * **Tables**: Number of tables.
   * **Total queries**: Total number of queries per second.
   * **Queries per host**: Total number of queries per second on each host.
   * **Waiting locks per host**: Number of pending locks on each host.

- {{ ui-key.yacloud.clickhouse.title_zookeeper }}

   * **Average latency per ZooKeeper host**: Average time it takes each ZooKeeper host to respond.
   * **Average transaction time per {{ CH }} host**: Average time it takes each {{ CH }} host to execute a transaction. It indicates the time {{ CH }} spends to access ZooKeeper.
   * **Connections per ZooKeeper host**: Number of connections on each ZooKeeper host.
   * **CPU cores usage**: Number of processor cores used.
   * **CPU cores usage per host**: Number of processor cores used on each host.
   * **CPU usage per host**: Usage of processor cores on each host.
   * **Disk read per host**: Disk read rate on each host (in bytes per second).
   * **Disk space usage**: Shows how much disk space is used (in bytes). Two charts are displayed: one for each host and one for all hosts.
   * **Disk space usage per host**: Shows how much disk space is used on each host (%).
   * **Disk usage per host**: Speed of disk operations on each host (in bytes per second).
   * **Disk write per host**: Disk write rate on each host (in bytes per second).
   * **Ephemeral nodes**: Number of Ephemeral nodes.

   {% note info %}

   For more information about Znodes, Ephemeral nodes, and Watches, see the [{{ ZK }} documentation](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

   {% endnote %}

   * **Memory usage**: Use of RAM, in bytes.
   * **Memory usage per host**: Shows how much RAM is used on each host (two charts are displayed: in bytes and %).
   * **Network data received per host**: Network data receipt rate on each host (in bytes per second).
   * **Network data sent per host**: Network data send rate on each host (in bytes per second).
   * **Network usage per host**: Rate of data exchange over the network on each host (in bytes per second).
   * **Outstanding requests per ZooKeeper host**: Number of requests being processed on each ZooKeeper host.
   * **Transactions**: Number of transactions per second.
   * **Transactions per {{ CH }} host**: Number of transactions per second on each {{ CH }} host.
   * **Watches**: Number of Watches.
   * **Znodes**: Number of Znodes.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mch-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Select the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
   1. Select the host from the drop-down list. The host type is shown next to its name: `CLICKHOUSE` or `ZOOKEEPER`.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
   * **Disk read/write bytes**: Speed of disk operations, in bytes per second.
   * **Disk IOPS**: Number of disk operations per second.
   * **Memory usage**: Use of RAM, in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
   * **Network bytes**: Speed of data exchange over the network, in bytes per second.
   * **Network packets**: Number of packets exchanged over the network, per second.

{% endlist %}


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mch-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mch-name }} — ZooKeeper** to configure ZooKeeper host alerts.
      * **{{ mch-name }} — Host Overview** to configure host alerts.
   1. In the appropriate chart with metrics, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` and `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` threshold values to trigger the alert.
   1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric | Parameter | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` |
|----------------------------------------------|:--------------------------------------------------:|:----------------------------:|:----------------------------:|
| Maximum number of data parts per partition | `ch_system_async_metrics_MaxPartCountForPartition` | `250` | `150` |
| Number of failed queries | `ch_system_events_FailedQuery_rate` | 20% of the total number of queries | 10% of the total number of queries |
| Storage space used | `disk.used_bytes` | 95% of the storage size | 80% of the storage size |
| Number of healthy hosts | `is_alive` | `<host_count>: 2` | `<host_count>: 1` |

To determine the threshold values for the `ch_system_events_FailedQuery_rate` metric, use `Total queries` [for the cluster](#monitoring-cluster).

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` and `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`: `102,005,473,280` bytes (95%)
* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`: `85,899,345,920` bytes (80%)

You can view the current storage size in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-clickhouse).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column in the required cluster row.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
