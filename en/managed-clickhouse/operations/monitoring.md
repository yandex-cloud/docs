---
title: Monitoring the state of a {{ CH }} cluster and its hosts
description: In this guide, you will learn how to monitor the state of {{ CH }} clusters and their hosts.
---

# Monitoring the state of a {{ CH }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the state of a {{ mch-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** tab. 

      The page that opens will display the performance charts for your {{ CH }} cluster and its hosts.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

### Available charts {#monitoring-dashboards}

If the cluster consists of {{ CH }} and [{{ ZK }}](../concepts/replication.md#zk) hosts, the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** page will have the following tabs:

* **{{ ui-key.yacloud.clickhouse.title_clickhouse }}**: State information for whole {{ CH }} cluster and its hosts.
* **{{ ui-key.yacloud.clickhouse.title_zookeeper }}**: State information for {{ ZK }} hosts.

If the cluster consists of only {{ CH }} hosts, the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** page will have the **{{ ui-key.yacloud.clickhouse.switch_list }}** tab with information aligned with the **{{ ui-key.yacloud.clickhouse.title_clickhouse }}** tab.

Regardless of the cluster configuration, the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** page also has the **Hosts** tab for [detailed host state information](#monitoring-hosts).

{% list tabs %}

- {{ ui-key.yacloud.clickhouse.title_clickhouse }}

  The tab displays the following charts:

  * Under **Summary**:

    * **Select queries**: Number of select queries per second for a cluster.
    * **Insert queries**: Number of insert queries per second for a cluster.
    * **Total queries**: Total number of queries per second for a cluster.
    * **Inserted data**: Data insertion rate for a cluster.
    * **Read data**: Data read rate for a cluster.
    * **Merged data**: Data merge rate for a cluster.
    * **CPU usage**: Number of CPU cores used in a {{ CH }} subcluster.
    * **Memory usage**: Use of RAM in a {{ CH }} subcluster.
    * **Disk space usage**: Disk space used in a {{ CH }} subcluster.

  * Under **Queries**:

    * **Select queries per host**: Number of select queries per second for each cluster host.
    * **Insert queries per host**: Number of insert queries per second for each cluster host.
    * **Total queries per host**: Total number of queries per second for each host.
    * **Failed select queries per host**: Percentage of failed select queries per {{ CH }} subcluster host.
    * **Failed insert queries per host**: Percentage of failed insert queries per {{ CH }} subcluster host.
    * **Failed queries per host**: Percentage of failed queries per {{ CH }} subcluster host.
    * **Average select query time per host**: Average select query time per {{ CH }} subcluster host.
    * **Average insert query time per host**: Average insert query time per {{ CH }} subcluster host.
    * **Average query time per host**: Average query time per host per {{ CH }} subcluster host.

  * Under **Connections and locks**:

    * **Connections per host**: Number of connections per cluster host.
    * **Active locks per host**: Number of active locks per cluster host.
    * **Waiting locks per host**: Number of waiting locks per cluster host.

  * Under **Data Traffic**:
    
    * **Read data per host**: Data read rate per cluster host.
    * **Inserted data per host**: Data insertion rate per cluster host.
    * **Merged data per host**: Data merge rate per cluster host.
    * **Read rows per host**: Row read rate per second for each cluster host.
    * **Inserted rows per host**: Row insertion rate per second for each cluster host.
    * **Merged rows per host**: Row merge rate per second for each cluster host.

  * Under **Storage**:
    
    * **Disk space usage per host, bytes**: Disk space used per {{ CH }} subcluster host.
    * **Disk space usage per host, %**: Percentage of the disk space used per {{ CH }} subcluster host.
    * **Inode usage, %**: Percentage of inodes used per {{ CH }} subcluster host.
    * **Databases**: Number of databases per cluster host.
    * **Tables**: Number of tables per cluster host.
    * **Rows of MergeTree tables**: Number of rows in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables per cluster host.
    * **Data parts**: Number of data parts per cluster host.
    * **Detached data parts**: Number of separate data parts per cluster host.

  * Under **Replication and Background Data Processing**:

    * **Max replication delay across tables**: Maximum table replication delay per cluster host. Values greater than a few seconds may indicate excessive load or replication issues.
    * **Replication queue**: Replication queue size per cluster host.
    * **Max data parts per partition**: Maximum number of data parts per partition for each cluster host. This value is limited by the [DBMS settings](../concepts/settings-list.md#setting-merge-tree). Approaching the limit indicates excessive load or low efficiency of data insertion.
    * **Merges and mutations pool tasks**: Number of active merge and mutation tasks in the background pool per {{ CH }} subcluster host.
    * **Fetches pool tasks**: Number of active fetch tasks in the background pool per {{ CH }} subcluster host.
    * **Move pool tasks**: Number of active move tasks in the background pool per {{ CH }} subcluster host.

  * Under **System Resources**:
    
    * **CPU usage per host, cores**: Number of CPU cores used per {{ CH }} subcluster host.
    * **Memory usage per host, bytes**: RAM used per {{ CH }} subcluster host.
    * **CPU usage per host, %**: CPU core usage percentage per {{ CH }} subcluster host.
    * **Memory usage per host, %**: Percentage of RAM used per {{ CH }} subcluster host.
    * **Disk read per host**: Disk read rate per {{ CH }} subcluster host.
    * **Disk write per host**: Disk write rate per {{ CH }} subcluster host.
    * **Disk usage per host**: Speed of disk operations per {{ CH }} subcluster host.
    * **Network data received per host**: Network data receive rate per {{ CH }} subcluster host.
    * **Network data sent per host**: Network data send rate per {{ CH }} subcluster host.
    * **Network usage per host**: Network data exchange rate per {{ CH }} subcluster host.

- {{ ui-key.yacloud.clickhouse.title_zookeeper }}

  The tab displays the following charts:

  * **Transactions**: Number of transactions per second.
  * **Outstanding requests per {{ ZK }} host**: Number of requests being processed per {{ ZK }} host.
  * **Connections per {{ ZK }} host**: Number of connections per {{ ZK }} host.
  * **Transactions per {{ CH }} host**: Number of transactions per second for each {{ CH }} host.
  * **Average transaction time per {{ CH }} host**: Average transaction time per {{ CH }} host. It shows the time {{ CH }} spends to access {{ ZK }}.
  * **Average latency per {{ ZK }} host**: Average response latency per {{ ZK }} host.
  * **Znodes**: Number of znodes.
  * **Ephemeral nodes**: Number of ephemeral nodes.
  * **Watches**: Number of watches.
  
  {% note info %}

  For more information about znodes, ephemeral nodes, and watches, see [this {{ ZK }} guide](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

  {% endnote %}

  * **CPU cores usage**: Number of CPU cores used in a {{ ZK }} subcluster.
  * You can use the following charts to monitor RAM usage:
      * **Memory usage** for a {{ ZK }} subcluster.
      * **Memory usage** per {{ ZK }} subcluster host.
  * You can use the following charts to monitor disk space usage:
      * **Disk space usage** for a {{ ZK }} subcluster.
      * **Disk space usage** per {{ ZK }} subcluster host.
  * **CPU cores usage per host**: Number of CPU cores used per host.
  * **CPU usage per host**: CPU core workload per host.
  * **Memory usage per host**: RAM usage percentage per host.
  * **Disk space usage per host**: Disk space usage percentage per host.
  * **Disk read per host**: Disk read rate per host.
  * **Disk write per host**: Disk write rate per host.
  * **Disk usage per host**: Speed of disk operations per host.
  * **Network data received per host**: Network data receive rate per host.
  * **Network data sent per host**: Network data send rate per host.
  * **Network usage per host**: Network data exchange rate per host.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information on the state of individual {{ mch-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** tab.

  1. Navigate to the **Hosts** tab and select the host.
    
      Host type, `CLICKHOUSE` or `ZOOKEEPER`, is specified for each host.

      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

{% list tabs %}

- {{ CH }}

  The following charts are displayed for {{ CH }} hosts:

  * **Availability**: Host availability.
  * **Quearies**: Number of queries per second for each type.
  * **Connections**: Number of HTTP and TCP connections.
  * **Failed queries**: Percentage of failed queries for each type.
  * **Average query time**: Average query time for each type.
  * **Locks**: Number of active and waiting read and write locks.
  * **Processed data**: Speed of reading, inserting, and merging data.
  * **Processed rows**: Speed of reading, inserting, and merging rows per second.
  * **Background tasks**: Number of merge and mutation, extract and move tasks in the background pool.
  * **Max replication delay across tables**: Maximum replication delay across tables. Values greater than a few seconds may indicate excessive load or replication issues.
  * **Replication queue**: Replication queue size.
  * **Max data parts per partition**: Maximum number of data parts per partition. This value is limited by the [DBMS settings](../concepts/settings-list.md#setting-merge-tree). Approaching the limit indicates excessive load or low efficiency of data insertion.
  * **CPU usage, %**: CPU core usage percentage.
  * **Memory usage, %**: RAM usage percentage.
  * **Disk space usage, %**: Disk space usage percentage.
  * **CPU usage, cores**: Number of CPU cores used.
  * **Memory usage, bytes**: RAM usage.
  * **Disk space usage, bytes**: Disk space usage.
  * **Disk throughput**: Disk throughput.
  * **Disk IOPS**: Number of disk read and write operations.
  * **Network throughput**: Network throughput.

- {{ ZK }}

  The following charts are displayed for {{ ZK }} hosts:

  * **Availability**: Host availability.
  * **Role**: Host role, Leader or Follower, in a {{ ZK }} subcluster.
  * **Objects**: Number of znodes, ephemeral nodes, and watches.
  * **Connections**: Number of active database connections to the host.
  * **Outstanding requests**: Number of outstanding requests to {{ ZK }}.
  * **Request time**: Read and write operation processing time.
  * **CPU usage, %**: CPU core usage percentage.
  * **Memory usage, %**: RAM usage percentage.
  * **Disk space usage, %**: Disk space usage percentage.
  * **CPU usage, cores**: Number of CPU cores used.
  * **Memory usage, bytes**: RAM usage.
  * **Disk space usage, bytes**: Disk space usage.
  * **Disk throughput**: Disk throughput.
  * **Disk IOPS**: Number of disk read and write operations.
  * **Network throughput**: Network throughput.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to set up alerts for.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:
      * **{{ mch-name }} — Cluster Overview** to set up cluster alerts.
      * **{{ mch-name }} — ZooKeeper** to set up ZooKeeper host alerts.
      * **{{ mch-name }} — Host Overview** to set up host alerts.
  1. In the relevant metrics chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. For more information about the query language, see [this {{ monitoring-full-name }} guide](../../monitoring/concepts/querying.md).
  1. Set the `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` and `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` thresholds to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Below are the recommended thresholds for some metrics:

| Metric                                      | Internal metric name                                        | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`                      | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`                    |
|----------------------------------------------|:--------------------------------------------------:|:----------------------------:|:----------------------------:|
| Maximum number of data parts per partition   | `ch_system_async_metrics_MaxPartCountForPartition` | `250`                        | `150`                        |
| Number of failed queries | `ch_system_events_FailedQuery_rate`                | 20% of the total number of queries | 10% of the total number of queries |
| Storage space used             | `disk.used_bytes`                                  | 95% of the storage size     | 80% of the storage size     |
| Number of healthy hosts            | `is_alive`                                         | `<number_of_hosts> - 2`    | `<number_of_hosts> - 1`    |

To determine the thresholds for the `ch_system_events_FailedQuery_rate` metric, use `Total queries` for the [cluster](#monitoring-cluster).

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` and `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`: `102,005,473,280` bytes (95%)
* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`: `85,899,345,920` bytes (80%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-clickhouse-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
