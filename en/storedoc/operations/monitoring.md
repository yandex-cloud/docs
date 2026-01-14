---
title: How to view detailed information about a {{ mmg-name }} cluster state
description: Follow this guide to view detailed information about a {{ mmg-name }} cluster state.
---

# Monitoring the state of a {{ SD }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#cluster}

To view detailed information on the state of a {{ mmg-name }} cluster:

1. Go to the [folder]({{ link-console-main }}) page.
1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.
1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

You will see the following charts:

* **Asserts total**: Number of asserts triggered in the cluster.
* **Average operation time per host**: Average time of operation execution by each host (in microseconds).
* **Average operations time on primary**: Average operation execution time on primary replicas (in microseconds).
* **Average operations time on secondaries**: Average operation execution time on secondary replicas (in microseconds).
* **CPU usage per host**: vCPU utilization per host (as a ratio of the number of vCPU cores).
* **CPU usage per host, top 5 hosts**: 5 hosts with the highest vCPU utilization (%).
* **Configured oplog size per host**: Size of the oplog on each cluster host (in GB).
* **Connections per host**: Average number of connections to each host.
* **Data size on primary, top 5 databases**: Size of the five largest DBs on the primary replica (in bytes). The chart counts data without [compression](../concepts/settings-list.md#setting-wired-tiger).
* **Disk read per host, top 5 hosts**: 5 hosts with the highest load on reading from the disk subsystem (bytes per second).
* **Disk space usage per host, top 5 hosts**: 5 hosts that take up the most disk space (two charts are displayed: in bytes and %). The chart counts data after [compression](../concepts/settings-list.md#setting-wired-tiger).
* **Disk usage per host, top 5 hosts**: 5 hosts with the highest load on the storage I/O subsystem (bytes per second).
* **Disk write per host, top 5 hosts**: 5 hosts with the highest load on writing to the disk subsystem (kilobytes per second).
* **Documents affected on primary**: Average number of documents affected by queries on the primary replica.
* **Documents affected on secondaries**: Average number of documents affected by queries on all secondary replicas.
* **Documents affected per host**: Average number of documents affected by queries on each host.
* **Hosts available for read**: Number of hosts that accept read data queries.
* **Hosts available for write**: Number of hosts that accept write data queries.
* **Index size on primary, top 5 indexes**: Size of the five largest indexes on the primary replica (in bytes).
* **Memory usage per host**: Amount of RAM used by each host (in bytes).
* **Memory usage per host, top 5 hosts**: 5 hosts that use the most RAM (%).
* **Network data received per host, top 5 hosts**: 5 hosts with the highest network load on reading (kilobytes per second).
* **Network data sent per host, top 5 hosts**: 5 hosts with the highest network load on writing (kilobytes per second).
* **Network usage per host, top 5 hosts**: 5 hosts with the highest total network load (kilobytes per second).
* **Open cursors total**: Number of open cursors in the cluster.
* **Oplog window**: Time interval, for which replication data is stored in each host's oplog collection.
* **Page faults per host**: Number of [page faults](https://en.wikipedia.org/wiki/Page_fault) on each host.
* **Queries on secondaries**: Average number of queries of each type on secondary replicas.
* **Queries on primary**: Average number of each type of query on primary replicas.
* **Read operations time, top 5 collections**: Five collections with the longest time spent on read operations.
* **Readers/writers active queue per host, top 5**: Total size of the 5 largest queues for each host:
    * With read requests
    * With write requests
* **Replicated queries**: Average number of replicated queries in the cluster.
* **Replication lag per host and write_concern wait**: Replication lag on each host and write confirmation timeout (in seconds).
* **Scan and order per host**: Number of data sorts without index usage on each host.
* **Scanned / returned**: Shows the following ratios:
    * `scanned_docs / returned_docs`: Documents scanned to documents returned.
    * `scanned_keys / returned_docs`: Index keys scanned to documents returned.
* **TTL indexes activity**: Total number of TTL indexes.
* **Total operations count on cluster**: Total number of operations performed in the cluster.
* **Total operations time on cluster**: Total operation execution time in the cluster (in milliseconds).
* **WiredTiger cache pages evicted on primary**: Average number of memory pages evicted on the primary replica.
* **WiredTiger cache state on primary**: WiredTiger cache usage on the primary replica (in bytes).
* **WiredTiger checkpoint time on primary**: Time it takes to create WiredTiger checkpoints on the primary replica (in milliseconds).
* **WiredTiger concurrent transactions on primary**: Average number of parallel transactions on the primary replica.
* **WiredTiger transactions state on primary**: Average number of transactions on each level on the primary replica.
* **Write conflicts per host**: Number of write conflicts on each host.
* **Write operations time, top 5 collections**: Five collections with the longest time spent on write operations.

## Monitoring the state of hosts {#hosts}

To view detailed information on the state of individual {{ mmg-name }} hosts:

1. Go to the [folder]({{ link-console-main }}) page.
1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the name of your cluster and select **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Select the host from the drop-down list. You will see the host role (`PRIMARY` or `SECONDARY`) and type (`MONGOCFG`, `MONGOD`, `MONGOINFRA`, or `MONGOS`) next to the host name.

This page displays the charts showing workloads of individual cluster hosts:

* **CPU**: Processor core workload. With increased workload, the **Idle** value drops.
* **Memory**: Use of RAM, in bytes. At high loads, the value of the **Free space** metric decreases, while the others increase.
* **Disk bytes**: Speed of disk operations, in bytes per second.
* **Disk IOPS**: Number of disk operations per second.
* **Network bytes**: Network data transfer rate, in bytes per second.
* **Network packets**: Number of network packets exchange per second.


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
    1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

        * **{{ mmg-name }}** to configure cluster alerts.
        * **{{ mmg-name }} — Host Overview** to set up host alerts.

    1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
    1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds to trigger the alert.
    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Below are the recommended thresholds for some metrics:

| Metric                         | Internal metric name                     | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
|---------------------------------|:-------------------------------:|:----------------------------------------------------:|:---------------------------------------------------:|
| Database write availability        | `can_write`                     | `Equal to 0`                                            | —                                                   |
| Replication lag             | `replset_status-replicationLag` | `180`                                                | `30`                                                |
| Storage space used | `disk.used_bytes`               | 90% of the storage size                             | 70% of the storage size                            |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75,161,927,680` bytes (70%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-mongodb-ref.md).


### Monitoring the transition to <q>read only</q> mode {#read-only-alert}

To monitor cluster host storage utilization and get notified if running out of free space:

1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
1. Add the `disk.free_bytes` status metric.

    To do this, create a query in the query builder:

    `service=managed-mongodb` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Set the alert threshold values in the alert settings:
   * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for the size of free disk space to trigger an alert.

       The recommended threshold values depending on the storage size are as follows:
  
       | Storage size, GB | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`     | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`        |
       |---------------------|-------------|------------------|
       | ⩽ 600               | `1G`: 1 GB | `1500M`: 1.5 GB |
       | > 600               | `6G`: 6 GB | `10G`: 10 GB    |

   * **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}** → **{{ ui-key.yacloud_monitoring.service.field.function }}**: Select `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (a minimum metric value for the period).

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

1. Go to the [folder]({{ link-console-main }}) page.
1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

