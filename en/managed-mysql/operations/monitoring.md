---
title: Monitoring the state of a {{ MY }} cluster and its hosts
description: You can monitor the state of a {{ mmy-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.
---

# Monitoring the state of a {{ MY }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

For detailed {{ mmy-name }} cluster state information:

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The tab displays the following charts:

* **Average query time**: Average query time for each host, in milliseconds.
* **Connections**: Number of connections for each host.
* **Disk usage**: Disk space used for each host and the entire cluster, in bytes.
* **Is Alive, [boolean]**: Shows the cluster availability as the sum of its hosts' states.

    Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.

    To increase the cluster’s availability, [add more hosts](hosts.md#add).

* **Is Primary, [boolean]**: Shows which host is the master and for how long.
* **Free space**: Free disk space broken down by host, in bytes.
* **Queries per second**: Total number of queries per second for each host.
* **Replication lag**: Replica's lag behind the master, in seconds.
* **Slow queries per second**: Number of SQL queries per second that run longer than the specified [`long_query_time`](../concepts/settings-list.md#setting-long-query-time), for each host.
* **Threads running**: Number of threads currently running on each host. This value increases rapidly as the cluster workload grows.

The **Master overview** section shows master details:

* **Disk usage**: Breakdown of used disk space, in bytes:
   * **data**: Amount of space used by data.
   * **default tablespace**: Amount of space used by data in the default tablespace.
   * **innodb logs**: Amount of space used by InnoDB logs.
   * **relaylogs**, **binlogs**: Amount of space used by {{ MY }} service logs. The {{ MY }} reference manual provides detailed info on [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html).
   * **temp tablespace**: Amount of space used by data in the temporary tablespace.
   * **undo tablespace**: Amount of space used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **InnoDB locks**: Number of InnoDB table locks. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **InnoDB rows operations**: Number of operations on InnoDB table rows. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Query quantiles**: Quantiles of average query execution time.
* **Sorts and joins**: Proportions of sort and join operations in the total number of operations. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Table cache**: Details of cached tables. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Temp tables**: Number of temporary tables. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Thread states**: Number of threads in a given state started by the `mysqld` daemon. For state descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Threads**: Number of threads started by the `mysqld` daemon.
   * **Threads cached**: Number of cached threads.

      During normal cluster operation, `mysqld` caches most connections.

   * **Threads connected**: Number of open threads.

       If the chart approaches the maximum value, it may signal that connections are staying active.

       The `max_connections` [setting](../concepts/settings-list.md#setting-max-connections) defines the maximum value.

   * **Threads running**: Number of running threads.

       This value increases rapidly as the cluster workload grows.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information on the state of individual {{ mmy-name }} hosts:

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page.
1. Select the host you need from the drop-down list.

This page displays the charts showing workloads of individual cluster hosts:

* **CPU usage**: Processor core utilization. As the workload increases, the **idle** value goes down.
* **Disk read/write bytes**: Speed of disk operations, in bytes per second.
* **Disk IOPS**: Number of disk operations per second.

    The **Disk read/write bytes** and **Disk IOPS** charts show the increase in the **Read** value during database read activity, and in **Write**, during database write activity.

* **Memory usage**: Amount of RAM used, in bytes. At high loads, the **Free** value decreases, while the other values increase.
* **Network bytes**:Network data transfer rate, in bytes per second.
* **Network packets**: Network packet rate, in packets per second.

   For **Replica** hosts, the **Received** value is normally greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

The **MySQL overview** section shows detailed information about the DBMS state on the host:

* **Disk usage**: Breakdown of used disk space, in bytes:
   * **data**: Amount of space used by data.
   * **default tablespace**: Amount of space used by data in the default tablespace.
   * **innodb logs**: Amount of space used by InnoDB logs.
   * **relaylogs**, **binlogs**: Amount of space used by {{ MY }} service logs. The {{ MY }} reference manual provides detailed info on [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html).
   * **temp tablespace**: Amount of space used by data in the temporary tablespace.
   * **undo tablespace**: Amount of space used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **Inode usage**: Number of inodes used.
* **File IO read bytes**: Data read rate, in bytes per second.
* **File IO read operations**: Average number of file read operations per second. For more information about operations, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **File IO write bytes**: Data write rate, in bytes per second.
* **File IO write operations**: Average number of file write operations per second. For more information about operations, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Handlers**: Number of handlers for various operations. For more information, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **InnoDB cache efficiency**: Measures of InnoDB buffer performance. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **InnoDB data operations**: Number of InnoDB operations:
   * **innodb data fsyncs**: `fsync()` operations when flushing data to disk.
   * **innodb data reads**: Disk reads.
   * **innodb data writes**: Disk writes.
* **InnoDB lock time**: InnoDB table lock wait time, in seconds.
* **InnoDB locks**: Number of InnoDB table locks. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **InnoDB rows operation**: Number of operations on InnoDB table rows. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Queries per second**: Total number of queries per second.
* **Query quantiles**: Quantiles of the average query execution time.
* **Replication lag**: Replica's lag behind the master, in seconds.
* **SemiSync latency**: Details of transaction commit latency in [semi-synchronous replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html), in seconds. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Slow queries per second**: Number of SQL queries per second that run longer than the specified [`long_query_time`](../concepts/settings-list.md#setting-long-query-time).
* **Sorts and joins**: Proportions of sort and join operations in the total number of operations. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Table cache**: Details of cached tables. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Temp tables**: Number of temporary tables. For metric descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Thread states**: Number of threads in a given state started by the `mysqld` daemon. For state descriptions, see [this {{ MY }} article]({{ mysql-vars-uri }}).
* **Threads**: Number of threads started by the `mysqld` daemon.
   * **Threads cached**: Number of cached threads.

      During normal host operation, `mysqld` caches most connections.
   * **Threads connected**: Number of open threads.

       If the chart approaches the maximum value, it may signal that connections are staying active.

       The `max_connections` [setting](../concepts/settings-list.md#setting-max-connections) defines the maximum value.

   * **Threads running**: Number of running threads.

       This value increases rapidly as the host workload grows.


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.

    1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

    1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

        * **{{ mmy-name }} — Cluster Overview** to set up cluster alerts.
        * **{{ mmy-name }} — Host Overview** to set up host alerts.

    1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

    1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).

    1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds to trigger the alert.

    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Below are recommended thresholds for some metrics:

| Metric                             | Internal metric name               | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`                 |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Replication lag                 | `mysql_replication_lag`   | `600`                     | `60`                      |
| Number of healthy hosts   | `mysql_is_alive`          | `<number_of_hosts> - 2` | `<number_of_hosts> - 1` |
| Average query execution time   | `mysql_latency_query_avg` | —                         | `2,000`                    |
| Storage space used    | `disk.used_bytes`         | 90% of the storage size  | 80% of the storage size  |
| CPU usage                      | `cpu.idle`                | `10`                      | `20`                      |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-mysql-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Locate the cluster you need in the list, and hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

