---
title: Viewing {{ mmg-name }} cluster health status details
description: In this tutorial, you will learn how to view {{ mmg-name }} cluster health status details.
---

# Monitoring the health status of a {{ SD }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster health status {#cluster}

To view the {{ mmg-name }} cluster health status details:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}** tab.
1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

You will see the following charts:

* **Asserts total**: Number of asserts triggered in the cluster.
* **Average operation time per host**: Average time it takes each host to execute operations, in microseconds.
* **Average operations time on primary**: Average execution time for operations on primary replicas, in microseconds.
* **Average operations time on secondaries**: Average execution time for operations on secondary replicas, in microseconds.
* **CPU usage per host**: vCPU utilization rate on each host, as a fraction of the total vCPU cores.
* **CPU usage per host, top 5 hosts**: 5 hosts with the highest vCPU utilization, in percent.
* **Configured oplog size per host**: Size of the operation log on each cluster host, in GB.
* **Connections per host**: Average number of connections to each host.
* **Data size on primary, top 5 databases**: Size of the five largest databases on the primary replica, in bytes. The chart is based on the raw, [uncompressed](../concepts/settings-list.md#setting-wired-tiger) data.
* **Disk read per host, top 5 hosts**: 5 hosts with the highest disk read throughput, in bytes per second.
* **Disk space usage per host, top 5 hosts**: 5 hosts with the highest storage space usage (displayed in two charts: in bytes and in percent). The chart is based on the [compressed](../concepts/settings-list.md#setting-wired-tiger) data.
* **Disk usage per host, top 5 hosts**: 5 hosts with the highest storage I/O throughput, in bytes per second.
* **Disk write per host, top 5 hosts**: 5 hosts with the highest disk write throughput, in KB/s.
* **Documents affected on primary**: Average number of documents affected by queries on the primary replica.
* **Documents affected on secondaries**: Average number of documents affected by queries on all secondary replicas.
* **Documents affected per host**: Average number of documents affected by queries on each host.
* **Hosts available for read**: Number of hosts accepting read queries.
* **Hosts available for write**: Number of hosts accepting write queries.
* **Index size on primary, top 5 indexes**: Size of the five largest indexes on the primary replica, in bytes.
* **Memory usage per host**: Amount of RAM used by each host, in bytes.
* **Memory usage per host, top 5 hosts**: 5 hosts with the highest RAM usage, in percent.
* **Network data received per host, top 5 hosts**: 5 hosts with the highest inbound network throughput, in KB/s.
* **Network data sent per host, top 5 hosts**: 5 hosts with the highest outbound network thoughput, in KB/s.
* **Network usage per host, top 5 hosts**: 5 hosts with the highest total network throughput, in KB/s.
* **Open cursors total**: Number of open cursors in the cluster.
* **Oplog window**: Time interval defining how long replication data is stored in each host's oplog collection.
* **Page faults per host**: Number of [page faults](https://en.wikipedia.org/wiki/Page_fault) on each host.
* **Queries on secondaries**: Average number of queries broken down by type, processed on the secondary replicas.
* **Queries on primary**: Average number of queries broken down by type, processed on the primary replica.
* **Read operations time, top 5 collections**: Five collections with the longest time spent on read operations.
* **Readers/writers active queue per host, top 5**: Total size of the 5 largest queues for each host:
    * With read queries
    * With write queries
* **Replicated queries**: Average number of replicated queries in the cluster.
* **Replication lag per host and write_concern wait**: Replication delay on each host and write concern timeout, in seconds.
* **Scan and order per host**: Number of data sorts without using an index on each host.
* **Scanned / returned**: Shows the following ratios:
    * `scanned_docs / returned_docs`: Scanned documents to returned documents.
    * `scanned_keys / returned_docs`: Scanned index keys to returned documents.
* **TTL indexes activity**: Total number of TTL indexes.
* **Total operations count on cluster**: Total number of operations performed in the cluster.
* **Total operations time on cluster**: Total execution time of cluster operations, in ms.
* **WiredTiger cache pages evicted on primary**: Average number of memory pages evicted from the cache on the primary replica.
* **WiredTiger cache state on primary**: WiredTiger cache usage on the primary replica, in bytes.
* **WiredTiger checkpoint time on primary**: Time required to create WiredTiger checkpoints on the primary replica, in ms.
* **WiredTiger concurrent transactions on primary**: Average number of concurrent transactions on the primary replica.
* **WiredTiger transactions state on primary**: Average number of transactions at each level on the primary replica.
* **Write conflicts per host**: Number of write conflicts on each host.
* **Write operations time, top 5 collections**: Five collections with the longest total time spent on write operations.

## Host status monitoring {#hosts}

To view the detailed status of individual {{ mmg-name }} hosts:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Click the name of your cluster and select **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Select the required host from the drop-down list. Next to the host name, you will see its role, i.e., `PRIMARY` or `SECONDARY`, and type, i.e., `MONGOCFG`, `MONGOD`, `MONGOINFRA`, or `MONGOS`.

This page displays workload charts for an individual cluster host:

* **CPU**: Processor core workload. With increased workload, the **Idle** value drops.
* **Memory**: RAM usage, in bytes. At high loads, the value of the **Free space** metric decreases, while the others increase.
* **Disk bytes**: Speed of disk operations, in bytes per second.
* **Disk IOPS**: Number of disk operations per second.
* **Network bytes**: Network data transfer rate, in bytes per second.
* **Network packets**: Network packet exchange rate, in packets per second.


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


### <q>Read-only</q> mode transition monitoring {#read-only-alert}

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

To check the cluster’s health and status:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Locate the cluster you need in the list and hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

### Cluster metrics {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

