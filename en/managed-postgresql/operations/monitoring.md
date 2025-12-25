---
title: PostgreSQL cluster and host status monitoring
description: You can monitor the status of a {{ mpg-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure {{ monitoring-full-name }} alerts for automated cluster health monitoring.
---

# {{ PG }} cluster and host status monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}


To identify potential issues in a cluster, [use other cluster diagnostic tools](../tutorials/performance-problems.md) alongside monitoring.


## Cluster status monitoring {#monitoring-cluster}

For detailed {{ mpg-name }} cluster status information:

1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

You will see the following charts:

* **Age of oldest transaction/statement**: Oldest transaction/statement execution time.
* **Average transaction/statement time**: Average transaction/statement processing time.
* **CPU usage**: Processor core utilization.
* **Disk read/write bytes**: Speed of disk read and write operations (bytes per second).
* **Disk read/write IOPS**: Intensity of disk read and write operations (operations per second).
* **Disk usage by DB**: Disk space utilization, broken down by database (bytes).
* **Disk usage on primary**: Disk space utilization on the master host (bytes).
* **Inode usage by host**: Number of inodes used by each host.
* **Inode usage on primary**: Number of inodes used on the master host.
* **Is Primary, [boolean]**: Shows which host is the master and for how long.
* **Free space**: Free disk space, broken down by host (bytes).
* **Log errors**: Number of errors logged per second.
* **Memory usage**: RAM utilization (bytes). At high loads, the value of the **Free** metric decreases, while the others increase.
* **Network received/sent bytes**: Network data transfer speed (bytes per second).
* **OOM Count**: Indicates the presence of Out-Of-Memory Killer processes. These processes kill memory-exhausting applications, which prevents the OS from crashing.
* **Packets received/sent**: Network packet rate (packets per second).
* **Pooler is alive, [boolean]**: Connection pooler health status for each host in both master and replica roles.
* **PostgreSQL Alive, [boolean]**: PostgreSQL health status for each host in both master and replica roles.
* **Replication lag**: Replication delay time.

    {% note warning %}

    The replication lag is calculated with one-second accuracy. A lag of less than one second cannot be tracked using this metric.

    {% endnote %}

* **Session CPU usage cores**: Number of used processor cores, broken down by session type.
* **Sessions per wait event**: Number of waiting sessions, broken down by wait event type.
* **Sessions read bytes**: Volume of data read in bytes, broken down by session type.
* **Sessions write bytes**: Volume of data written in bytes, broken down by session type.
* **Statement quantiles**: Statement execution time, broken down by percentile.
* **TCP connections**: Number of TCP connections per second.
* **Total pooler connections**: Total number of client and server pooler connections.
* **Total size of temporary files**: Total size of temporary files in bytes.
* **Total size of WAL files**: Total size of [WAL files](../concepts/backup.md) in bytes.
* **Transaction quantiles**: Transaction processing time, broken down by percentile.
* **Transactions/statements per second**: Number of transactions and statements per second.

## Host status monitoring {#monitoring-hosts}

To view detailed information about the status of individual {{ mpg-name }} hosts:

1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
1. Select the host you need from the drop-down list.

This page displays charts showing workloads of individual cluster hosts:

* **CPU usage**: Processor core utilization. With increased workload, the **Idle** value drops.
* **Disk IOPS**: Number of disk operations per second.
* **Disk read/write bytes**: Speed of disk operations in bytes per second.
* **Memory usage**: RAM utilization in bytes. At high loads, the value of the **Free** metric decreases, while the others increase.
* **Network bytes**: Network data transfer speed in bytes per second.
* **Network packets**: Number of packets transferred over the network, per second.

The **Disk read/write bytes** and the **Disk IOPS** charts show the increase of the **Read** metric during database read activity, and the increase of the **Write** metric during database write activity..

For **Replica** hosts, the value of the **Received** metric on the **Network Bytes** and **Network Packets** charts is usually higher than the **Sent** metric.


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the target cluster for setting up alerts.
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

The recommended thresholds are as follows:

| Metric                               | Parameter                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Replication delay                   | `postgres-replication_lag` | `60`                      | `5`                       |
| Number of healthy hosts     | `postgres-is_alive`        | `<number_of_hosts> - 2` | `<number_of_hosts> - 1` |
| Average query execution time     | `pooler-avg_query_time`    | —                         | `2,000`                    |
| Storage space utilization      | `disk.used_bytes`          | 90% of the storage size  | 80% of the storage size  |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`: `85899345920` bytes (80%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-postgresql-ref.md).


## Cluster health and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s health and status:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Locate the cluster you need in the list, and hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

