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

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mmy-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-mysql` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `replica` |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Disk metrics" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Disk operation metrics" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "RAM metrics" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Service metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk-used_bytes_mysql_binlogs`<br/>`DGAUGE`, bytes | Space used by MySQL service logs. |
| `disk-used_bytes_mysql_data`<br/>`DGAUGE`, bytes | Space used by data. |
| `disk-used_bytes_mysql_default_tablespace`<br/>`DGAUGE`, bytes | Space used by data in the default tablespace. |
| `disk-used_bytes_mysql_innodb_logs`<br/>`DGAUGE`, bytes | Space used by InnoDB logs. |
| `disk-used_bytes_mysql_relaylogs`<br/>`DGAUGE`, bytes | Space used by MySQL service logs. |
| `disk-used_bytes_mysql_temp_tablespace`<br/>`DGAUGE`, bytes | Space used by data in the temporary tablespace. |
| `disk-used_bytes_mysql_undo_tablespace`<br/>`DGAUGE`, bytes | Space used by data in the[InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html). |
| `mysql_Aborted_connects_rate`<br/>`DGAUGE`, connections per second | Number of failed attempts to connect to the DB. |
| `mysql_Binlog_cache_disk_use_rate`<br/>`DGAUGE`, transactions per second | Number of transactions that used the Binlog cache but exceeded its size and had to write data to a temporary disk file. |
| `mysql_Binlog_cache_use_rate`<br/>`DGAUGE`, transactions per second | Number of transactions that used the Binlog cache. |
| `mysql_Connections_rate`<br/>`DGAUGE`, connections per second | Attempts to connect to the DB (successful and failed). |
| `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, tables per second | Number of temporary tables created on disk when handling DB queries. |
| `mysql_Created_tmp_files_rate`<br/>`DGAUGE`, files per second | Number of temporary DB files. |
| `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, tables per second | Number of temporary tables created when handling DB queries. |
| `mysql_Fileio_read_bytes`<br/>`DGAUGE`, bytes per second | Data read speed.<br/>Additional labels: `filetype` |
| `mysql_Fileio_reads`<br/>`DGAUGE`, operations per second | Average speed of file reads per second.<br/>Additional labels: `filetype` |
| `mysql_Fileio_write_bytes`<br/>`DGAUGE`, bytes per second | Data write speed.<br/>Additional labels: `filetype` |
| `mysql_Fileio_writes`<br/>`DGAUGE`, operations per second | Average speed of file writes per second.<br/>Additional labels: `filetype` |
| `mysql_Handler_<handler>.*_rate`<br/>`DGAUGE`, pcs | Number of handlers of various operations. For more information, see the [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html). <br/>Additional labels: `handler` |
| `mysql_Innodb_buffer_pool_pages_data`<br/>`DGAUGE`, pcs | Number of pages with data in the InnoDB buffer. Includes `dirty` and `clean`. |
| `mysql_Innodb_buffer_pool_pages_dirty`<br/>`DGAUGE`, pcs | Number of `dirty` pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_free`<br/>`DGAUGE`, pcs | Number of free pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_misc`<br/>`DGAUGE`, pcs | Number of service pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_total`<br/>`DGAUGE`, pcs | Number of pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_read_requests_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB reads. |
| `mysql_Innodb_buffer_pool_reads_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB reads to handle which InnoDB has to access the disk. |
| `mysql_Innodb_checkpoint_age`<br/>`DGAUGE`, bytes | Size of data in InnoDB memory before being flushed to the disk. |
| `mysql_Innodb_checkpoint_max_age`<br/>`DGAUGE`, bytes | Maximum size of data in InnoDB memory before being flushed to the disk. |
| `mysql_Innodb_data_fsyncs_rate`<br/>`DGAUGE`, operations per second | Number of _fsync()_ operations when flushing data to the disk in InnoDB. |
| `mysql_Innodb_data_reads_rate`<br/>`DGAUGE`, operations per second | Number of disk reads in InnoDB. |
| `mysql_Innodb_data_writes_rate`<br/>`DGAUGE`, operations per second | Write rate in InnoDB. |
| `mysql_Innodb_page_size`<br/>`DGAUGE`, bytes | Page size in InnoDB (defaults to 16 KB). |
| `mysql_Innodb_row_lock_current_waits`<br/>`DGAUGE`, pcs | Number of row locks in InnoDB. |
| `mysql_Innodb_row_lock_time_rate`<br/>`DGAUGE`, ms | Total waiting time for row locks in InnoDB. |
| `mysql_Innodb_row_lock_waits_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB operations that had to wait for row locks. |
| `mysql_Innodb_rows_deleted_rate`<br/>`DGAUGE`, rows per second | Rows deleted in InnoDB. |
| `mysql_Innodb_rows_inserted_rate`<br/>`DGAUGE`, rows per second | Rows inserted in InnoDB. |
| `mysql_Innodb_rows_read_rate`<br/>`DGAUGE`, rows per second | Rows read from InnoDB tables. |
| `mysql_Innodb_rows_updated_rate`<br/>`DGAUGE`, rows per second | Rows updated in InnoDB. |
| `mysql_Open_table_definitions`<br/>`DGAUGE`, pcs | Number of cached table definitions. |
| `mysql_Open_tables`<br/>`DGAUGE`, pcs | Number of open tables. |
| `mysql_Opened_table_definitions_rate`<br/>`DGAUGE`, tables per second | Number of table definitions cached per unit of time. |
| `mysql_Opened_tables_rate`<br/>`DGAUGE`, tables per second | Number of table definitions opened per unit of time. |
| `mysql_Prepared_stmt_count`<br/>`DGAUGE`, pcs | Prepared statements. |
| `mysql_Queries_rate`<br/>`DGAUGE`, queries per second | Number of active queries, including user queries and stored procedures, per unit of time.  |
| `mysql_Questions_rate`<br/>`DGAUGE`, queries per second | Number of active user queries per unit of time. |
| `mysql_Rpl_semi_sync_master_clients`<br/>`DGAUGE`, pcs | Number of semi-sync replicas. |
| `mysql_Rpl_semi_sync_master_tx_avg_wait_time`<br/>`DGAUGE`, microseconds. | Average waiting time for a transaction by the replication source. |
| `mysql_Rpl_semi_sync_master_tx_wait_time_rate`<br/>`DGAUGE`, microseconds. | Total waiting time for a transaction by the replication source, per unit of time. |
| `mysql_Rpl_semi_sync_master_wait_sessions`<br/>`DGAUGE`, pcs | Number of sessions waiting for a response from replicas. |
| `mysql_Select_full_join_rate`<br/>`DGAUGE`, queries per second | Number of Joins that use table scans instead of indexes. |
| `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, queries per second | Number of Joins that search by range in a reference table. |
| `mysql_Session_<stage>.*`<br/>`DGAUGE`, pcs | Number of sessions at a certain stage. <br/>Additional labels: `stage` |
| `mysql_Slow_queries_rate`<br/>`DGAUGE`, queries per second | Number of slow queries that take more seconds than set in `long_query_time` to execute, per unit of time. |
| `mysql_Sort_range_rate`<br/>`DGAUGE`, queries per second | Number of sorts by range per unit of time. |
| `mysql_Sort_rows_rate`<br/>`DGAUGE`, queries per second | Number of rows sorted per unit of time. |
| `mysql_Sort_scan_rate`<br/>`DGAUGE`, queries per second | Number of sorts using table scans per unit of time. |
| `mysql_Table_locks_immediate`<br/>`DGAUGE`, pcs | Number of immediate table locks. |
| `mysql_Table_locks_waited`<br/>`DGAUGE`, pcs | Number of table locks that had to wait. |
| `mysql_Table_open_cache_hits_rate`<br/>`DGAUGE`, operations per second | Number of hits for a search in the cache of open tables per unit of time. |
| `mysql_Table_open_cache_misses_rate`<br/>`DGAUGE`, operations per second | Number of failed attempts to search in the cache of open tables per unit of time. |
| `mysql_Threads_cached`<br/>`DGAUGE`, pcs | Number of threads cached. |
| `mysql_Threads_connected`<br/>`DGAUGE`, pcs | Number of threads handling open DB connections. |
| `mysql_Threads_created_rate`<br/>`DGAUGE`, threads per second. | Number of threads created per unit of time. |
| `mysql_Threads_running`<br/>`DGAUGE`, pcs | Number of threads running at the moment. |
| `mysql_config_innodb_buffer_pool_size`<br/>`DGAUGE`, bytes | Size of the InnoDB buffer pool. |
| `mysql_config_innodb_log_file_size`<br/>`DGAUGE`, bytes | Log file size in the log group. |
| `mysql_config_max_connections`<br/>`DGAUGE`, pcs | Maximum number of concurrent connections. |
| `mysql_config_table_open_cache`<br/>`DGAUGE`, pcs | Number of open tables cache for all threads. |
| `mysql_config_thread_cache_size`<br/>`DGAUGE`, number | Number of threads that need to be cached to be reused. |
| `mysql_is_alive`<br/>`DGAUGE`, 0/1 | Host performance indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `mysql_is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if a DB host is a master, `0` if not. |
| `mysql_is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if a DB host is a replica, `0` if not. |
| `mysql_latency_query_0.5`<br/>`DGAUGE`, seconds. | Query execution time, median value. |
| `mysql_latency_query_0.75`<br/>`DGAUGE`, seconds | Query execution time, 0.75 procentile. |
| `mysql_latency_query_0.90`<br/>`DGAUGE`, seconds | Query execution time, 0.90 procentile. |
| `mysql_latency_query_0.95`<br/>`DGAUGE`, seconds | Query execution time, 0.95 procentile. |
| `mysql_latency_query_0.99`<br/>`DGAUGE`, seconds | Query execution time, 0.99 percentile. |
| `mysql_latency_query_avg`<br/>`DGAUGE`, seconds | Average query execution time. |
| `mysql_replication_lag`<br/>`DGAUGE`, seconds | Time that a replica lags behind the master. |

{% endcut %}

{% cut "Other metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if not. |

{% endcut %}

{% endif %}
