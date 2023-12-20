---
title: "Monitoring the state of PostgreSQL clusters and hosts"
description: "Using monitoring tools in the management console, you can track the status of a {{ mpg-name }} cluster and its individual hosts. These tools display diagnostic information as charts. You can also configure alerts in {{ monitoring-full-name }} to monitor cluster status automatically."
---

# Monitoring the state of {{ PG }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mpg-name }} cluster state:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts will open on the page:

* **Age of oldest transaction/statement**: Oldest transaction processing and operator execution time.
* **Average transaction/statement time**: Average transaction processing and operator execution time.
* **CPU usage**: Usage of processor cores.
* **Disk read/write bytes**: Disk read and write speed (bytes per second).
* **Disk read/write IOPS**: Disk read and write activity (ops per second).
* **Disk usage by DB**: Disk usage by database (bytes).
* **Disk usage on primary**: Disk usage on a master host (bytes).
* **Inode usage by host**: The used number of inodes by host.
* **Inode usage on primary**: The used number of inodes on a master host.
* **Is Primary, [boolean]**: Indicates which host is the master and for how long.
* **Free space**: Free disk space for each host (in bytes).
* **Log errors**: Number of logged errors per second.
* **Memory usage**: Use of RAM, in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network Bytes**: Network data transfer speed (bytes per second).
* **Packets received/sent**: Network packet transmission activity (packets per second).
* **Pooler is alive, [boolean]**: Connection pooler health for each host either as a master or as a replica.
* **PostgreSQL Alive, [boolean]**: PostgreSQL health for each host either as a master or as a replica.
* **Replication lag**: Replication delay.
* **Session CPU usage cores**: Number of utilized processor cores by session type.
* **Sessions per wait event**: Number of waiting sessions by wait type.
* **Sessions read bytes**: Amount of data read by session type (bytes).
* **Sessions write bytes**: Amount of data written by session type (bytes).
* **Statement quantiles**: Operator execution time by percentile.
* **TCP connections**: Number of TCP connections per second.
* **Total pooler connections**: Number of pooler connections, both client and server.
* **Total size of temporary files**: Total temporary file size (bytes).
* **Total size of WAL files**: Total [WAL file](../concepts/backup.md) size (bytes).
* **Transaction quantiles**: Transaction processing time by percentile.
* **Transactions/statements per second**: Number of transactions and operators per second.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mpg-name }} hosts:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
* **Disk IOPS**: Number of disk operations per second.
* **Disk read/write bytes**: Speed of disk operations, in bytes per second.
* **Memory usage**: Use of RAM, in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network bytes**: Speed of data exchange over the network, in bytes per second.
* **Network packets**: Number of packets exchanged over the network, per second.

The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

For hosts with the **Replica** role, **Received** is normally greater than **Sent** on the **Network Bytes** and **Network Packets** charts.


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
      * **{{ mpg-name }} Cluster Overview** to configure cluster alerts.
      * **{{ mpg-name }} Host Overview** to configure host alerts.
   1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud.common.continue }}**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds to trigger an alert.
   1. Click **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric | Parameter | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Replication delay | `postgres-replication_lag` | `60` | `5`   |
| Number of healthy hosts | `postgres-is_alive` | `<host_count>: 2` | `<host_count>: 1` |
| Average query execution time | `pooler-avg_query_time` | N/A | `2,000` |
| Storage space used | `disk.used_bytes` | 90% of the storage size | 80% of the storage size |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` and `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`: `85,899,345,920` bytes (80%)

You can view the current storage size in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-postgresql).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

