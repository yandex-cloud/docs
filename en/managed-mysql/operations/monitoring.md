---
title: "Monitoring the state of MySQL clusters and hosts"
description: "Using monitoring tools in the management console, you can track the status of a {{ mmy-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts."
---

# Monitoring the state of {{ MY }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mmy-name }} cluster status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

The following charts are displayed on the tab:

* **Average query time**: The average time it takes to execute queries on each host (in milliseconds).
* **Connections**: The number of connections on each host.
* **Disk usage**: Shows how much disk space (in bytes) is used on each host and in the entire cluster.
* **Is Alive, [boolean]**: Indicates cluster accessibility as the sum of its hosts' states.

   Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.


   To increase the availability of a cluster, [add hosts](hosts.md#add).

* **Is Primary, [boolean]**: Indicates which host is the master and for how long.
* **Free space**: Free disk space for each host (in bytes).
* **Queries per second**: The total number of queries per second on each host.
* **Replication lag**: The number of seconds that the replica lags behind the master.
* **Slow queries per second**: The number of SQL queries per second running longer than specified in the `long_query_time` [parameter](../concepts/settings-list.md#setting-long-query-time) for each host.
* **Threads running**: The number of active threads on each host. As the load on the cluster increases, this value rapidly grows.

The **Master overview** section shows detailed information about the master:

* **Disk usage**: Details of the disk space used (in bytes):
   * **data**: The volume used by data.
   * **default tablespace**: The volume used by data in the default tablespace.
   * **innodb logs**: The volume used by InnoDB logs.
   * **relaylogs**, **binlogs**: The volume used by {{ MY }} service logs. For more information about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the {{ MY }} documentation.
   * **temp tablespace**: The volume used by data in the temporary tablespace.
   * **undo tablespace**: The volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **InnoDB locks**: The number of InnoDB table locks. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB rows operations**: The number of operations with InnoDB table rows. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Query quantiles**: The quantiles of the average query execution time.
* **Sorts and joins**: The proportion of sort and join operations in the total number of operations. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Table cache**: Cached table characteristics. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Temp tables**: The number of temporary tables. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Thread states**: The number of threads in a certain status started by the `mysqld` daemon. For more information about states, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Threads**: The number of threads started by the `mysqld` daemon.
   * **Threads cached**: The number of cached threads.

      During normal cluster operation, the `mysqld` process caches most of the connections.

   * **Threads connected**: The number of open threads.

      If the chart is close to the maximum value, it may mean that open connections can't be closed.

      The maximum value is set by the `max_connections` [parameter](../concepts/settings-list.md#setting-max-connections).

   * **Threads running**: The number of running threads.

      As the load on the cluster increases, this value rapidly grows.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mmy-name }} hosts:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

* **CPU usage**: Usage of processor cores. As the load goes up, the **idle** value goes down.
* **Disk read/write bytes**: The speed of disk operations (bytes per second).
* **Disk IOPS**: The number of disk operations per second.

   The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

* **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
* **Network Bytes**: The speed of data exchange over the network (bytes per second).
* **Network Packets**: The number of packets exchanged over the network per second.

   For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

The **MySQL overview** section shows detailed information about the DBMS state on the host:

* **Disk usage**: Details of the disk space used (in bytes):
   * **data**: The volume used by data.
   * **default tablespace**: The volume used by data in the default tablespace.
   * **innodb logs**: The volume used by InnoDB logs.
   * **relaylogs**, **binlogs**: The volume used by {{ MY }} service logs. For more information about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the {{ MY }} documentation.
   * **temp tablespace**: The volume used by data in the temporary tablespace.
   * **undo tablespace**: The volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **Inode usage**: The used number of inodes.
* **File IO read bytes**: Data read rate (bytes per second).
* **File IO read operations**: The average number of file read operations (per second). For more information about operations, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **File IO write bytes**: Data write rate (bytes per second).
* **File IO write operations**: The average number of file write operations (per second). For more information about operations, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Handlers**: The number of handlers of various operations. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB cache efficiency**: InnoDB cache performance indicators. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB data operations**: The number of InnoDB operations:
   * **innodb data fsyncs**: The `fsync()` operations when data is flushed to disk.
   * **innodb data reads**: Disk read operations.
   * **innodb data writes**: Write operations.
* **InnoDB lock time**: InnoDB table lock wait timeout (in seconds).
* **InnoDB locks**: The number of InnoDB table locks. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **InnoDB rows operation**: The number of operations with InnoDB table rows. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Queries per second**: The total number of queries per second.
* **Query quantiles**: The quantiles of the average query execution time.
* **Replication lag**: The number of seconds that the replica lags behind the master.
* **SemiSync latency**: The delay before a transaction's commit under [semisynchronous replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html) (in seconds). For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Slow queries per second**: The number of SQL queries per second running longer than specified in the `long_query_time` [parameter](../concepts/settings-list.md#setting-long-query-time).
* **Sorts and joins**: The proportion of sort and join operations in the total number of operations. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Table cache**: Cached table characteristics. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Temp tables**: The number of temporary tables. For more information about metrics, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Thread states**: The number of threads in a certain status started by the `mysqld` daemon. For more information about states, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
* **Threads**: The number of threads started by the `mysqld` daemon.
   * **Threads cached**: The number of cached threads.

      During normal host operation, the `mysqld` process caches most of the connections.
   * **Threads connected**: The number of open threads.

      If the chart is close to the maximum value, it may mean that open connections can't be closed.

      The maximum value is set by the `max_connections` [parameter](../concepts/settings-list.md#setting-max-connections).

   * **Threads running**: The number of running threads.

      As the load on the host increases, this value grows rapidly.

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.

   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.

   1. Under **Service dashboards**, select.

      * **{{ mmy-name }} Cluster Overview** to configure cluster alerts.
      * **{{ mmy-name }} Host Overview** to configure host alerts.

   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.

   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).

   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.

   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter                | `Alarm` | `Warning` |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Replication delay | `mysql_replication_lag` | `600` | `60` |
| Number of healthy hosts | `mysql_is_alive` | `<number of hosts> - 2` | `<number of hosts> - 1` |
| Average query execution time | `mysql_latency_query_avg` | — | `2000` |
| Storage space used | `disk.used_bytes` | 90% of storage size | 80% of storage size |
| CPU usage | `cpu.idle` | `10` | `20` |

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-mysql).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the folder page and select **{{ mmy-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
