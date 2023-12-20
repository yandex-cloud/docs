---
title: "Monitoring the state of MySQL clusters and hosts"
description: "Using monitoring tools in the management console, you can track the status of a {{ mmy-name }} cluster and its individual hosts. These tools display diagnostic information as charts."
---

# Monitoring the state of {{ MY }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mmy-name }} cluster state:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts are displayed on the tab:

* **Average query time**: Average time it takes to execute queries on each host (in milliseconds).
* **Connections**: Number of connections on each host.
* **Disk usage**: Shows how much disk space (in bytes) is used on each host and in the entire cluster.
* **Is Alive, [boolean]**: Indicates cluster accessibility as the sum of its hosts' states.

   Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.

   To increase the availability of a cluster, [add hosts](hosts.md#add).

* **Is Primary, [boolean]**: Indicates which host is the master and for how long.
* **Free space**: Free disk space for each host (in bytes).
* **Queries per second**: Total number of queries per second on each host.
* **Replication lag**: Number of seconds that the replica lags behind the master.
* **Slow queries per second**: Number of SQL queries per second running longer than specified in the `long_query_time` [parameter](../concepts/settings-list.md#setting-long-query-time) for each host.
* **Threads running**: Number of active threads on each host. As the load on the cluster increases, this value rapidly grows.

The **Master overview** section shows detailed information about the master:

* **Disk usage**: Details of the disk space used (in bytes):
   * **data**: Volume used by data.
   * **default tablespace**: Volume used by data in the default tablespace.
   * **innodb logs**: Volume used by InnoDB logs.
   * **relaylogs**, **binlogs**: Volume used by {{ MY }} service logs. For more information about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the {{ MY }} documentation.
   * **temp tablespace**: Volume used by data in the temporary tablespace.
   * **undo tablespace**: Volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **InnoDB locks**: Number of InnoDB table locks. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB rows operations**: Number of operations with InnoDB table rows. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Query quantiles**: Quantiles of the average query execution time.
* **Sorts and joins**: Proportion of sort and join operations in the total number of operations. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Table cache**: Cached table characteristics. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Temp tables**: Number of temporary tables. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Thread states**: Number of threads in a certain status started by the `mysqld` daemon. For more information about states, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Threads**: Number of threads started by the `mysqld` daemon.
   * **Threads cached**: Number of cached threads.

      During normal cluster operation, the `mysqld` process caches most of the connections.

   * **Threads connected**: Number of open threads.

      If the chart is close to the maximum value, it may mean that open connections cannot be closed.

      The maximum value is set by the `max_connections` [parameter](../concepts/settings-list.md#setting-max-connections).

   * **Threads running**: Number of running threads.

      As the load on the cluster increases, this value rapidly grows.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mmy-name }} hosts:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU usage**: Usage of processor cores. As the load goes up, the **idle** value goes down.
* **Disk read/write bytes**: Speed of disk operations, in bytes per second.
* **Disk IOPS**: Number of disk operations per second.

   The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

* **Memory usage**: Use of RAM, in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network bytes**: Speed of data exchange over the network, in bytes per second.
* **Network packets**: Number of packets exchanged over the network, per second.

   For hosts with the **Replica** role, **Received** is normally greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

The **MySQL overview** section shows detailed information about the DBMS state on the host:

* **Disk usage**: Details of the disk space used (in bytes):
   * **data**: Volume used by data.
   * **default tablespace**: Volume used by data in the default tablespace.
   * **innodb logs**: Volume used by InnoDB logs.
   * **relaylogs**, **binlogs**: Volume used by {{ MY }} service logs. For more information about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the {{ MY }} documentation.
   * **temp tablespace**: Volume used by data in the temporary tablespace.
   * **undo tablespace**: Volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **Inode usage**: Number of inodes used.
* **File IO read bytes**: Data read rate (bytes per second).
* **File IO read operations**: Average number of file read operations (per second). For more information about operations, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **File IO write bytes**: Data write rate (bytes per second).
* **File IO write operations**: Average number of file write operations (per second). For more information about operations, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Handlers**: Number of handlers of various operations. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB cache efficiency**: InnoDB cache performance indicators. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB data operations**: Number of InnoDB operations:
   * **innodb data fsyncs**: `fsync()` operations when data is flushed to disk.
   * **innodb data reads**: Disk read operations.
   * **innodb data writes**: Write operations.
* **InnoDB lock time**: InnoDB table lock wait timeout (in seconds).
* **InnoDB locks**: The number of InnoDB table locks. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB rows operation**: Number of operations with InnoDB table rows. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Queries per second**: Total number of queries per second.
* **Query quantiles**: The quantiles of the average query execution time.
* **Replication lag**: The number of seconds that the replica lags behind the master.
* **SemiSync latency**: Transaction's commit delay under [semisynchronous replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html) (in seconds). For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Slow queries per second**: Number of SQL queries per second running longer than specified in the `long_query_time` [parameter](../concepts/settings-list.md#setting-long-query-time).
* **Sorts and joins**: The proportion of sort and join operations in the total number of operations. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Table cache**: Cached table characteristics. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Temp tables**: Number of temporary tables. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Thread states**: Number of threads in a certain status started by the `mysqld` daemon. For more information about states, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Threads**: Number of threads started by the `mysqld` daemon.
   * **Threads cached**: Number of cached threads.

      During normal host operation, the `mysqld` process caches most of the connections.
   * **Threads connected**: Number of open threads.

      If the chart is close to the maximum value, it may mean that open connections cannot be closed.

      The maximum value is set by the `max_connections` [parameter](../concepts/settings-list.md#setting-max-connections) .

   * **Threads running**: The number of running threads.

      As the load on the host increases, this value grows rapidly.


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.

   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

   1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

       * **{{ mmy-name }}: Cluster Overview** to configure cluster alerts.
       * **{{ mmy-name }}: Host Overview** to configure host alerts.

   1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).

   1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds to trigger an alert.

   1. Click **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric | Parameter                | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Replication delay | `mysql_replication_lag` | `600` | `60` |
| Number of healthy hosts | `mysql_is_alive` | `<host_count>: 2` | `<host_count>: 1` |
| Average query execution time | `mysql_latency_query_avg` | N/A | `2,000` |
| Storage space used | `disk.used_bytes` | 90% of the storage size | 80% of the storage size |
| CPU usage | `cpu.idle` | `10` | `20` |

For the `disk.used_bytes` metric, the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)

You can view the current storage size in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-mysql).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column in the required cluster row.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

