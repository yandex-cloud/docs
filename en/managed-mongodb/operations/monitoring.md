---
title: "How to view detailed information about the {{ mmg-name }} cluster state"
description: "This guide describes how you can view detailed information about the state of a {{ mmg-name }} cluster."
---

# Monitoring the state of {{ MG }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#cluster}

To view detailed information about the {{ mmg-name }} cluster state:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts will open on the page:

* **Asserts total**: Number of [asserts](https://docs.mongodb.com/manual/reference/command/serverStatus/#mongodb-serverstatus-serverstatus.asserts) triggered in the cluster.
* **Average operation time per host**: Average time of operation execution by each host (in microseconds).
* **Average operations time on primary**: Average operation execution time on primary replicas (in microseconds).
* **Average operations time on secondaries**: Average operation execution time on secondary replicas (in microseconds).
* **CPU usage per host**: vCPU usage on each host (in thousandths).
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
* **Read operations count, top 5 collections**: 5 collections with the longest time spent in reads.
* **Readers/writers active queue per host, top 5**: Total size of the 5 largest queues for each host:
   * With read requests
   * With write requests
* **Replicated queries**: Average number of replicated queries in the cluster.
* **Replication lag per host and write_concern wait**: Replication lag on each host and waiting time for [write concern](https://docs.mongodb.com/manual/reference/write-concern/) (in seconds).
* **Scan and order per host**: Number of data sorts without index usage on each host.
* **Scanned / returned**: Shows the following ratios:
   * `scanned_docs / returned_docs`: Documents scanned to documents returned.
   * `scanned_keys / returned_docs`: Index keys scanned to documents returned.
* **TTL indexes activity**: Total number of [TTL indexes](https://docs.mongodb.com/manual/core/index-ttl/).
* **Total operations count on cluster**: Total number of operations performed in the cluster.
* **Total operations time on cluster**: Total operation execution time in the cluster (in milliseconds).
* **WiredTiger cache pages evicted on primary**: Average number of memory pages evicted on the primary replica.
* **WiredTiger cache state on primary**: WiredTiger cache usage on the primary replica (in bytes).
* **WiredTiger checkpoint time on primary**: Time it takes to create WiredTiger checkpoints on the primary replica (in milliseconds).
* **WiredTiger concurrent transactions on primary**: Average number of parallel transactions on the primary replica.
* **WiredTiger transactions state on primary**: Average number of transactions on each level on the primary replica.
* **Write conflicts per host**: Number of write conflicts on each host.
* **Write operations count, top 5 collections**: 5 collections with the longest time spent in writes.

## Monitoring the state of hosts {#hosts}

To view detailed information about the state of individual {{ mmg-name }} hosts:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
1. Select the host from the drop-down list. You will see the host role (`PRIMARY` or `SECONDARY`) and type (`MONGOCFG`, `MONGOD`, `MONGOINFRA`, or `MONGOS`) next to the host name.

This page displays charts showing the load on an individual host in the cluster:

* **CPU**: Load on processor cores. As the load goes up, the **Idle** value goes down.
* **Memory**: Use of RAM, in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Disk bytes**: Speed of disk operations (bytes per second).
* **Disk IOPS**: Number of disk operations per second.
* **Network bytes**: Speed of data exchange over the network, in bytes per second.
* **Network packets**: Number of packets exchanged over the network, per second.


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.

   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

   1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

      * **{{ mmg-name }}** to configure cluster alerts.
      * **{{ mmg-name }} Host Overview** to configure host alerts.

   1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).

   1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds to trigger an alert.

   1. Click **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric | Parameter | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
|---------------------------------|:-------------------------------:|:----------------------------------------------------:|:---------------------------------------------------:|
| DB write availability | `can_write` | `Equals 0` | — |
| Replication delay | `replset_status-replicationLag` | `180` | `30` |
| Storage space used | `disk.used_bytes` | 90% of the storage size | 70% of the storage size |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75,161,927,680` bytes (70%)

You can view the current storage size in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-mongodb).


### Monitoring the switch to read-only mode {#read-only-alert}

To monitor storage usage on cluster hosts and get notifications when free space is about to run out:

1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
1. Add the `disk.free_bytes` status metric.

   To do this, create a query in the query builder:

   `service=managed-mongodb` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Set the alert threshold values in the alert settings:
   * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for the size of free disk space to trigger an alert.

      The recommended threshold values depending on the storage size are as follows:

      | Storage size, GB | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
      |---------------------|-------------|------------------|
      | ⩽ 600 | `1G` (1 GB) | `1500M` (1.5 GB) |
      | > 600 | `6G` (6 GB) | `10G` (10 GB) |

   * **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}** → **{{ ui-key.yacloud_monitoring.service.field.function }}**: Select `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (a minimum metric value for the period).

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

