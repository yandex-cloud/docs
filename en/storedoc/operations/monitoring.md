---
title: Cluster, host, and shard state monitoring in {{ mmg-name }}
description: In this tutorial, you will learn how to view {{ mmg-name }} cluster health status details.
---

# Cluster, host, and shard state monitoring in {{ mmg-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Cluster health state monitoring {#cluster}

To view detailed information on the health state of a {{ mmg-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.
      
      The page that opens will display performance charts for the cluster.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  The following charts are displayed for a cluster:

  * **Hosts available for write**: Cluster host write availability.
  * **Hosts available for read**: Cluster host read availability.

  Under **Traffic**:

  * **Queries on primary**: Increase in commands and operations on cluster primary replicas.
  * **Queries on secondaries**: Increase in commands and operations on cluster secondary replicas.
  * **Replicated queries**: Increase in replicated commands and operations on cluster secondary replicas.
  * **Documents affected on primary**: Increase in documents added, updated, deleted, or returned by queries on cluster primary replicas.
  * **Documents affected on secondaries**: Increase in documents added, updated, deleted, or returned by queries on cluster secondary replicas.
  * **Documents affected per host**: Increase in documents added, updated, deleted, or returned by queries on each cluster host.
  * **Total operations count on cluster**: Total increase in commands and operations in the cluster.
  * **Connections per host**: Number of available and incoming connections on each cluster host.
  * **Readers/writers active queue per host, top 5**: Number of read and write operations in the five largest lock queues on each cluster host.

  Under **Latency**:
   
  * **Average operations time on primary**: Average execution time for commands and operations on cluster primary replicas.
  * **Average operations time on secondaries**: Average execution time for commands and operations on cluster secondary replicas.
  * **Average operation time per host**: Average time it takes each cluster host to execute operations.
  * **Total operations time on Primaries**: Total execution time for all operations on cluster primary replicas.
  * **Total operations time on Secondaries**: Total execution time for all operations on cluster secondary replicas.
  * **Total operations time on Cluster**: Total execution time for all operations in the cluster.
  * **Write operations time, top 5 collections**: Total time spent on write operations for the five largest collections in the cluster.
  * **Read operations time, top 5 collections**: Total time spent on read operations for the five largest collections in the cluster.

  Under **DB Metrics**:

  * **Replication lag per host and write_concern wait**: Replication delay and write concern timeout on each cluster host.
  * **Scanned / returned**: Average ratio of scanned keys and documents to returned documents in the cluster.
  * **Scan and order per host**: Increase in the number of non-index-based data sorts on each cluster host.
  * **Data size on primary, top 5 databases**: Data size for the five largest databases on cluster primary replicas.
  * **Index size on primary, top 5 indexes**: Index size for the five largest databases on cluster primary replicas.
  * **TTL indexes activity**: Increase in deleted documents and background deletion operations using TTL indexes.
  * **Configured oplog size per host**: Maximum operation log size on each cluster host.
  * **Oplog window**: Time interval for retaining replication data in the `oplog` collection on each cluster host.
  * **Open cursors total**: Total number of open cursors on cluster hosts. The following is displayed separately:
    
    * Total cursors.
    * Pinned cursors.
    * No-timeout cursors.
  
  Under **Resources** → **CPU**:
  
  * **CPU usage per host**: CPU usage percentage per cluster host.
  * **CPU usage on Primaries**: CPU load on cluster primary replicas.
  * **CPU usage on Secondaries**: CPU load on cluster secondary replicas.
  
  Under **Resources** → **Memory**:
   
  * **Memory usage per host**: RAM usage per cluster host as a percentage.
  * **Memory usage on Primaries**: RAM usage on cluster primary replicas.
  * **Memory usage on Secondaries**: RAM usage on cluster secondary replicas.

  Under **Resources** → **Network**:

  * **Network usage per host**: Total network load on each cluster host.
  * **Network data sent per host**: Network data send rate on each cluster host.
  * **Network data received per host**: Network data receive rate on each cluster host.

  Under **Resources** → **Data**:
  
  * **Disk space usage per host**: Disk space usage per cluster host as a percentage of the total storage size.
  * **Disk space usage on Primaries**: Disk space usage on cluster primary replicas.
  * **Disk space usage on Secondaries**: Disk space usage on cluster secondary replicas.
  * **Disk usage per host**: Total disk read and write rate on each cluster host.
  * **Disk write per host**: Disk write rate on each cluster host.
  * **Disk read per host**: Disk read rate on each cluster host.

  Under **Errors**:

  * **Write conflicts per host**: Increase in write conflicts on each cluster host.
  * **Page faults per host**: Number of page faults on each cluster host.
  * **Asserts total**: Increase in triggered asserts in the cluster.

  Under **WiredTiger**:

  * **WiredTiger checkpoint time on primary**: Time required to create checkpoints on cluster primary replicas.
  * **WiredTiger cache state on primary**: Cache usage on cluster primary replicas.
  * **WiredTiger transactions state on primary**: Increase in transactions on cluster primary replicas.
  * **WiredTiger concurrent transactions on primary**: Current number of parallel transaction tickets on cluster primary replicas.
  * **WiredTiger cache pages evicted on primary**: Increase in evicted cache pages (both modified and not) on cluster primary replicas.
  
  Under **Mongos**:
   
  * **Mongos in balancer round**: Indicates whether _mongos_ is involved in the current balancing round.
  * **Mongos active migrations**: Maximum number of active chunk migration operations via _mongos_.
  * **Mongos migrations**: Maximum number of chunk migration operations (both successful and not) via _mongos_.

{% endlist %}

## Host state monitoring {#hosts}

To view detailed information on the state of individual {{ mmg-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.
  1. Navigate to the **Hosts** tab and select the host.

      The page that opens will display performance charts for the cluster hosts.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  The following charts are displayed for the hosts:

  * **CPU usage**: CPU usage percentage by consumption types: `user`, `system`, `steal`, `softirq`, `nice`, `irq`, `iowait`, `idle`, and `guest`.
  * **Memory usage**: RAM usage by consumption type: `used`, `total`, `shared`, `free`, `cached`, `buffers`, `available`, and `active`.
  * **Disk IOPS**: Number of read and write operations per second.
  * **Network bytes**: Network data transmit and receive rate.
  * **Network packets**: Network packet transmit and receive rate (packets per second).
  * **Disk space usage**: Used and available disk space.

  Under **Disk Metrics Details**:

  * **Disk write latency (percentiles)**: Disk write latency, in percentiles.
  * **Disk write bytes**: Average and maximum disk write rate.
  * **Disk write operations**: Average and maximum number of write operations per second.
  * **Disk read latency (percentiles)**: Disk read latency, in percentiles.
  * **Disk read bytes**: Average and maximum disk read rate.
  * **Disk read operations**: Average and maximum number of read operations per second.
  * **Disk write throttler latency (percentiles)**: Write delay introduced by exceeding disk quota, in percentiles.
  * **Disk read throttler latency (percentiles)**: Read delay introduced by exceeding disk quota, in percentiles.
  * **Disk used quota**: Percentage of disk operation quota usage.

{% endlist %}

## Shard state monitoring {#monitoring-shards}

To view detailed information on the health state of {{ mmg-name }} shards:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.
  1. Navigate to the **Shards** tab and select a shard.
      
      The page that opens will display health state charts for the selected shard and its hosts.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  The following charts are displayed for shards:

  * **Hosts available for write**: Shard host write availability.
  * **Hosts available for read**: Shard host read availability.

  Under **Traffic**:

  * **Queries on primary**: Increase in commands and operations on shard primary replicas.
  * **Queries on secondaries**: Increase in commands and operations on shard secondary replicas.
  * **Replicated queries**: Increase in replicated commands and operations on shard secondary replicas.
  * **Documents affected on primary**: Increase in documents added, updated, deleted, or returned by queries on shard primary replicas.
  * **Documents affected on secondaries**: Increase in documents added, updated, deleted, or returned by queries on shard secondary replicas.
  * **Documents affected per host**: Increase in documents added, updated, deleted, or returned by queries on each shard host.
  * **Total operations count on cluster**: Total increase in commands and operations executed on the shard.
  * **Connections per host**: Number of available and incoming connections on each shard host.
  * **Readers/writers active queue per host, top 5**: Number of read and write operations in the five largest lock queues on each shard host.

  Under **Latency**:
   
  * **Average operations time on primary**: Average execution time for commands and operations on shard primary replicas.
  * **Average operations time on secondaries**: Average execution time for commands and operations on shard secondary replicas.
  * **Average operation time per host**: Average time it takes each shard host to execute operations.
  * **Total operations time on Primaries**: Total execution time for all operations on shard primary replicas.
  * **Total operations time on Secondaries**: Total execution time for all operations on shard secondary replicas.
  * **Total operations time on Cluster**: Total execution time for all operations on the shard.
  * **Write operations time, top 5 collections**: Total time spent on write operations for the five largest collections on the shard.
  * **Read operations time, top 5 collections**: Total time spent on read operations for the five largest collections on the shard.

  Under **DB Metrics**:

  * **Replication lag per host and write_concern wait**: Replication delay and write concern timeout on each shard host.
  * **Scanned / returned**: Average ratio of scanned keys and documents to returned documents on the shard.
  * **Scan and order per host**: Increase in the number of non-index-based data sorts on each shard host.
  * **Data size on primary, top 5 databases**: Data size for the five largest databases on shard primary replicas.
  * **Index size on primary, top 5 indexes**: Index size for the five largest databases on shard primary replicas.
  * **TTL indexes activity**: Increase in deleted documents and background deletion operations using TTL indexes on the shard.
  * **Configured oplog size per host**: Maximum operation log size on each shard host.
  * **Oplog window**: Time interval for retaining replication data in the `oplog` collection on each shard host.
  * **Open cursors total**: Total number of open cursors on shard hosts. The following is displayed separately:
    
    * Total cursors
    * Pinned cursors
    * No-timeout cursors
  
  Under **Resources** → **CPU**:
  
  * **CPU usage per host**: CPU usage percentage per shard host.
  * **CPU usage on Primaries**: CPU load on shard primary replicas.
  * **CPU usage on Secondaries**: CPU load on shard secondary replicas.
  
  Under **Resources** → **Memory**:
   
  * **Memory usage per host**: RAM usage per shard host as a percentage.
  * **Memory usage on Primaries**: RAM usage on shard primary replicas.
  * **Memory usage on Secondaries**: RAM usage on shard secondary replicas.

  Under **Resources** → **Network**:

  * **Network usage per host**: Total network load on each shard host.
  * **Network data sent per host**: Network data send rate on each shard host.
  * **Network data received per host**: Network data receive rate on each shard host.

  Under **Resources** → **Data**:
  
  * **Disk space usage per host**: Disk space usage per shard host as a percentage of the total storage size.
  * **Disk space usage on Primaries**: Disk space usage on shard primary replicas.
  * **Disk space usage on Secondaries**: Disk space usage on shard secondary replicas.
  * **Disk usage per host**: Total disk read and write rate on each shard host.
  * **Disk write per host**: Disk write rate on each shard host.
  * **Disk read per host**: Disk read rate on each shard host.

  Under **Errors**:

  * **Write conflicts per host**: Increase in write conflicts on each shard host.
  * **Page faults per host**: Number of page faults on each shard host.
  * **Asserts total**: Increase in triggered asserts on the shard.

  Under **WiredTiger**:

  * **WiredTiger checkpoint time on primary**: Time required to create checkpoints on shard primary replicas.
  * **WiredTiger cache state on primary**: Cache usage on shard primary replicas.
  * **WiredTiger transactions state on primary**: Increase in transactions on shard primary replicas.
  * **WiredTiger concurrent transactions on primary**: Current number of parallel transaction tickets on shard primary replicas.
  * **WiredTiger cache pages evicted on primary**: Increase in evicted cache pages (both modified and not) on shard primary replicas.
  
  Under **Mongos**:
   
  * **Mongos in balancer round**: Indicates whether _mongos_ is involved in the current balancing round on the shard.
  * **Mongos active migrations**: Maximum number of active chunk migration operations via _mongos_ on the shard.
  * **Mongos migrations**: Maximum number of chunk migration operations (both successful and not) via _mongos_ on the shard.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster where you want to set up alerts.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}** service.
    1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

        * **{{ mmg-name }}** to set up cluster alerts.
        * **{{ mmg-name }} — Host Overview** to set up host alerts.

    1. On the relevant chart, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. If the chart displays multiple metrics, select the data query for the relevant metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. To learn more about the query language, see [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
    1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` alert thresholds.
    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values for selected metrics:

| Metric                         | Internal metric name                     | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
|---------------------------------|:-------------------------------:|:----------------------------------------------------:|:---------------------------------------------------:|
| Database write availability        | `can_write`                     | `0`                                            | —                                                   |
| Replication lag             | `replset_status-replicationLag` | `180`                                                | `30`                                                |
| Storage space used | `disk.used_bytes`               | 90% of the storage size                             | 70% of the storage size                            |

The `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for the `disk.used_bytes` metric are specified exclusively in bytes. For example, recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75,161,927,680` bytes (70%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-mongodb-ref.md).


### Monitoring read-only mode transitions {#read-only-alert}

To track storage fill levels on the cluster hosts and receive notifications when free space is about to run out:

1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
1. Add the `disk.free_bytes` metric.

    To do this, create a query in the query builder:

    `service=managed-mongodb` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Configure alert notification thresholds:
   * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for free disk space that will trigger the alert.

       Recommended thresholds relative to storage size are as follows:
  
       | Storage size, GB | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`     | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`        |
       |---------------------|-------------|------------------|
       | ⩽ 600               | `1G`: 1 GB | `1500M`: 1.5 GB |
       | > 600               | `6G`: 6 GB | `10G`: 10 GB    |

   * **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}** → **{{ ui-key.yacloud_monitoring.service.field.function }}**: Select `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` the metric’s minimum value over the period.

## Cluster health and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the health state and status of a cluster:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Locate the cluster you need in the list and hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

