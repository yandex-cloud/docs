---
title: "Monitoring the state of a MySQL cluster and hosts"
description: "You can monitor the health of a Managed Service for MySQL cluster and its individual hosts using the monitoring tools in the management console. These tools provide diagnostic information in the form of graphs."
---

# Monitoring the state of a cluster and hosts

Using monitoring tools in the management console, you can track the status of a {{ mmy-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

{% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mmy-name }} cluster status:

1. Go to the folder page and select **{{ mmy-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The following charts are displayed on the tab:

- **Average query time**: The average time it takes to execute queries on each host (in milliseconds).
- **Connections**: The number of connections on each host.
- **Disk usage**: Shows how much disk space (in bytes) is used on each host and in the entire cluster.
- **Is Alive**: Shows cluster availability as the sum of its hosts' states.

    Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.
    To increase the availability of a cluster, [add hosts](hosts.md#add).

- **Is Primary**: Shows which host is the master and for how long.
- **Queries per second**: The total number of queries per second on each host.
- **Replication lag**: The number of seconds that the replica lags behind the master.
- **Slow queries per second**: The number of SQL queries per second running longer than specified in the [parameter](../concepts/settings-list.md#setting-long-query-time) `long_query_time` on each host.
- **Threads running**: The number of active threads on each host. As the load on the cluster increases, this value rapidly grows.

The **Master overview** section shows detailed information about the master:

- **Disk usage**: Details of the disk space used (in bytes):
   - **data**: The volume used by data.
   - **default tablespace**: The volume used by data in the default tablespace.
   - **innodb logs**: The volume used by InnoDB logs.
   - **relaylogs**, **binlogs**: The volume used by  {{ MY }} service logs. To learn more about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the documentation for {{ MY }}.
   - **temp tablespace**: The volume used by data in the temporary tablespace.
   - **undo tablespace**: The volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
- **InnoDB locks**: The number of InnoDB table locks. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **InnoDB rows operation**: The number of operations with InnoDB table rows. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Query quantiles**: The quantiles of the average query execution time.
- **Sorts and joins**: The proportion of sort and join operations in the total number of operations. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Table cache**: Cached table characteristics. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Temp tables**: The number of temporary tables. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Thread states**: The number of threads in a certain status started by the `mysqld` daemon. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Threads**: The number of threads started by the `mysqld` daemon.
   - **Threads cached**: The number of cached threads.

      During normal cluster operation, the `mysqld` process caches most of the connections.

   - **Threads connected**: The number of open threads.

       If the chart is close to the maximum value, it may mean that open connections can't be closed.

       The maximum value is set by the [parameter](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   - **Threads running**: The number of active threads.

       As the load on the cluster increases, this value rapidly grows.

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mmy-name }} hosts:

1. Go to the folder page and select **{{mmy-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Go to the **Monitoring** page.
1. Select the host from the drop-down list.

This page displays charts showing the load on an individual host in the cluster:

- **CPU usage**: Usage of processor cores. As the load goes up, the **Idle** value goes down.
- **Disk read/write bytes**: The speed of disk operations (bytes per second).
- **Disk IOPS**: The number of disk operations per second.

    The **Disk  read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

- **Memory usage**: The use of RAM in bytes. At high loads, the value of the **Free** parameter goes down while those of other parameters go up.
- **Network Bytes**: The speed of data exchange over the network (bytes per second).
- **Network Packets**: The number of packets exchanged over the network per second.

   For hosts with the **Replica** role, it's normal that **Received** is greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

The **MySQL overview** section shows detailed information about the DBMS state on the host:

- **Disk usage**: Details of the disk space used (in bytes):
   - **data**: The volume used by data.
   - **default tablespace**: The volume used by data in the default tablespace.
   - **innodb logs**: The volume used by InnoDB logs.
   - **relaylogs**, **binlogs**: The volume used by  {{ MY }} service logs. To learn more about [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) and [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html), see the documentation for {{ MY }}.
   - **temp tablespace**: The volume used by data in the temporary tablespace.
   - **undo tablespace**: The volume used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
- **File IO read bytes**: Data read rate (bytes per second).
- **File IO read operations**: The average number of file read operations (per second). For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **File IO write bytes**: Data write rate (bytes per second).
- **File IO write operations**: The  average number of file write operations (per second). For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Handlers**: The number of handlers of various operations. For more information, see [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **InnoDB cache efficiency**: InnoDB cache performance indicators. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **InnoDB data operations**: The number of InnoDB operations:
   - **innodb data fsyncs**: The `fsync()` operations when data is flushed to disk.
   - **innodb data reads**: Disk read operations.
   - **innodb data writes**: Write operations.
- **InnoDB lock time**: InnoDB table lock wait timeout (in seconds).
- **InnoDB locks**: The number of InnoDB table locks. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **InnoDB rows operation**: The number of operations with InnoDB table rows. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Queries per second**: The total number of queries per second.
- **Query quantiles**: The quantiles of the average query execution time.
- **Replication lag**: The number of seconds that the replica lags behind the master.
- **SemiSync latency**: The delay before a transaction acknowledgment under [semisynchronous replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html) (in seconds). For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Slow queries per second**: The number of SQL queries per second running longer than specified in the [parameter](../concepts/settings-list.md#setting-long-query-time) `parameter`.
- **Sorts and joins**: The proportion of sort and join operations in the total number of operations. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Table cache**: Cached table characteristics. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Temp tables**: The number of temporary tables. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Thread states**: The number of threads in a certain status started by the `mysqld` daemon. For more information, see the [{{ MY }} documentation]({{ mysql-vars-uri }}).
- **Threads**: The number of threads started by the `mysqld` daemon.
   - **Threads cached**: The number of cached threads.

      During normal host operation, the `mysqld` process caches most of the connections.

   - **Threads connected**: The number of open threads.

       If the chart is close to the maximum value, it may mean that open connections can't be closed.

       The maximum value is set by the [parameter](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   - **Threads running**: The number of active threads.

       As the load on the host increases, this value grows rapidly.

