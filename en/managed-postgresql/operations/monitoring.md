---
title: PostgreSQL cluster and host state monitoring
description: You can monitor the state of a {{ mpg-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure {{ monitoring-full-name }} alerts for automated cluster health monitoring.
---

# {{ PG }} cluster and host state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}


To identify potential issues in a cluster, [use other cluster diagnostic tools](../tutorials/performance-problems.md) alongside monitoring.


## Cluster state monitoring {#monitoring-cluster}

To view detailed information on the state of a {{ mpg-name }} cluster:

1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

You will see the following charts:

* Under **Cluster**:

   * **PostgreSQL Alive, [boolean]**: PostgreSQL health for each host either as a master or as a replica.
   * **Is Primary, [boolean]**: Shows which host is the master and for how long.
   * **Replication lag**: Replication delay time.

       {% note warning %}

       The replication lag is calculated with one-second accuracy. A lag of less than one second cannot be tracked using this metric.

       {% endnote %}
    
   * **Average CPU usage**: Average transaction processing and operator execution time.
   * **Maximum CPU usage**: Peak processor core load.
   * **Maximum memory usage**: Peak RAM usage (in bytes). At high loads, the value of the **Free space** metric decreases, while the others increase.
   * **Log errors**: Number of errors logged per second.
   * **OOM Count**: Indicates the presence of Out-Of-Memory Killer processes. OOM Killer mechanism terminates memory exhausting applications, preventing the OS from crashing.

* Under **Disk**:

   * **Disk usage on primary**: Disk space utilization on the master host (bytes).
   * **Disk read/write bytes**: Speed of disk read and write operations (bytes per second).
   * **Disk read/write IOPS**: Intensity of disk read and write operations (operations per second).
   * **Disk usage by DB**: Disk space utilization, broken down by database (bytes).
   * **Inode usage on primary**: Number of inodes used on the master host.
   * **Inode usage by host**: Number of inodes used by each host.
   * **Total size of temporary files**: Total size of temporary files in bytes.
   * **Total size of WAL files**: Total size of [WAL files](../concepts/backup.md) in bytes.
   * **Free space**: Free disk space broken down by host, in bytes.
   * **WAL rate in bytes**: WAL file write speed in bytes per second.

* Under **Transactions**:

   * **Transactions/statements per second**: Number of transactions and statements per second.
   * **Average transaction/statement time**: Average transaction/statement processing time.
   * **Age of oldest transaction/statement**: Age of the oldest transaction/request.
   * **Statement quantiles**: Statement execution time, broken down by percentile.
   * **Transaction quantiles**: Transaction processing time, broken down by percentile.
   * **Used/Free Transaction IDs**: Used/free transaction IDs.
   * **Transaction IDs left**: Remainder of available transaction IDs.

* Under **Vacuum**:

   * **Vacuum processes**: Number of processes performing the vacuuming operation.
   * **Scanning progress**: Scanning progress during vacuuming.
   * **Vacuuming progress**: Progress of the vacuuming operation.

* Under **Sessions**:

   * **Sessions read bytes per second**: Amount of data read in bytes, broken down by session type.
   * **Sessions write bytes per second**: Amount of data written in bytes, broken down by session type.
   * **Session CPU usage cores**: Number of used processor cores, broken down by session type.
   * **Sessions per wait event**: Number of waiting sessions, broken down by wait event type.

* Under **Connections**:

   * **Pooler is alive, [boolean]**: Connection pooler health for each host either as a master or as a replica.
   * **Total pooler connections**: Number of pooler connections, both client and server.
   * **TCP connections**: Number of TCP connections per second.

* Under **Network**:

   * **Packets received/sent**: Network packet rate (packets per second).
   * **Network received/sent bytes**: Network data exchange rate (bytes per second).


## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ mpg-name }} hosts:

1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
1. Click the line of the host in the list.

This page displays the charts showing workloads of individual cluster hosts:

* **CPU usage**: Processor core workload. With increased workload, the **Idle** value drops.
* **Memory usage**: Amount of RAM used, in bytes. At high loads, the value of the **Free space** metric decreases, while the others increase.
* **Disk usage**: Disk space usage (in bytes).
* **Disk usage by DB**: Disk space utilization, broken down by database (bytes).
* **Disk read/write bytes**: Speed of disk operations, in bytes per second.
* **Disk IOPS**: Number of disk operations per second.
* **Network packets**: Network packet rate, in packets per second.
* **Network bytes**: Network data exchange rate, in bytes per second.

The **Disk read/write bytes** and the **Disk IOPS** charts show the increase of the **Read** value during database read activity, and in **Write**, during database write activity..

For **Replica** hosts, the value of the **Received** metric on the **Network Bytes** and **Network Packets** charts is usually higher than the **Sent** metric.


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
    1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
        * **{{ mpg-name }} — Cluster Overview** to set up cluster alerts.
        * **{{ mpg-name }} — Host Overview** to set up host alerts.
    1. Locate the chart you need, click its ![options](../../_assets/console-icons/ellipsis.svg) icon, and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud.common.continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} guides](../../monitoring/concepts/querying.md).
    1. Set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds to trigger the alert.
    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Below are the recommended thresholds for some metrics:

| Metric                               | Designation                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Replication delay                   | `postgres-replication_lag` | `60`                      | `5`                       |
| Number of healthy hosts     | `postgres-is_alive`        | `<number_of_hosts> - 2` | `<number_of_hosts> - 1` |
| Average query execution time     | `pooler-avg_query_time`    | —                         | `2,000`                    |
| Storage space used      | `disk.used_bytes`          | 90% of the storage size  | 80% of the storage size  |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`: `85899345920` bytes (80%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-postgresql-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

