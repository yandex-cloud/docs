---
title: Monitoring the state of a {{ MY }} cluster and its hosts
description: You can monitor the state of a {{ mmy-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.
---

# {{ MY }} cluster and host state monitoring

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the health state of a {{ mmy-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.
      
      The page that opens will display performance charts for the cluster.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The following charts are displayed for a cluster:

  * **Queries per second**: Number of user queries per second for each cluster host.
  * **Average query time**: Average query time for each cluster host.
  * **Slow queries per second**: Number of queries per second that are longer than specified in [long_query_time](../concepts/settings-list.md#setting-long-query-time). The information is displayed for each cluster host.
  * **Connections**: Number of connections for each cluster host.
  * **Threads running**: Number of running threads for each cluster host.
  * **Disk usage**: Disk space usage for each host and the entire cluster.
  * **Is Primary, [boolean]**: Shows whether the host is the master.
  * **Is Alive, [boolean]**: Shows the availability of each cluster host.
  * **Replication lag**: Replica lag time behind the master.
  * **Free space**: Free disk space for each host and the entire cluster.
  * **OOM Count**: Number of out-of-memory events on each cluster host. 

  The **Master overview** section shows the master details:

  * **Query quantiles**: Query execution time, percentiles.
  * **Threads**: Number of threads. The following is displayed separately:
   
    * **Threads cached**: Number of cached threads.
    * **Threads connected**: Number of open DB connections.

      The maximum number of open connections is set in [max_connections](../concepts/settings-list.md#setting-max-connections).

    * **Threads running**: Number of running threads.

  * **Thread states**: Number of threads in each state.
  * **Disk usage**: Disk space usage. The following is displayed separately:
   
    * **data**: Amount of space used by data.
    * **default tablespace**: Amount of space used by data in the tablespace.
    * **innodb logs**: Amount of space used by InnoDB logs.
    * **relaylogs**, **binlogs**: Amount of space used by {{ MY }} service logs.
    * **temp tablespace**: Amount of space used by data in the temporary tablespace.
    * **undo tablespace**: Amount of space used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
  
  * **InnoDB rows operation**: Number of InnoDB row operations.
  * **InnoDB locks**: Row lock waits in InnoDB. The following is displayed separately:
    
    * **innodb_row_lock_current_waits**: Current number of row lock waits.
    * **innodb_row_lock_waits**: Number of operations with row lock waits per second.

  * **Temp tables**: Number of temporary tables and files created per second.
  * **Sorts and joins**: Number of sort and join operations per second.
  * **Table cache**: Table caching. The following is displayed separately:
   
    * **open_tables**: Number of open tables.
    * **opened_tables**: Number of open tables per second.
    * **table_open_cache_hits**: Number of open table cache hits per second.
    * **table_open_cache_misses**: Number of open table cache misses per second.

{% endlist %}

## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ mmy-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.
  1. Navigate to the **Hosts** tab and select the host.

      The page that opens will display performance charts for the cluster hosts.

      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The following charts are displayed for the hosts:
 
  * **CPU usage**: CPU usage percentage by consumption type.
  * **Memory usage**: RAM usage by consumption type.
  * **Disk IOPS**: Number of read and write operations per second.
  * **Network Packets**: Number of packets sent and received over the network per second.
  * **Network Bytes**: Network data transmit and receive rate.
  
    For **Replica** hosts, the **Received** value is normally greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

  The **MySQL overview** section shows detailed information about the DBMS state on the host:

  * **Query quantiles**: Query execution time, percentiles.
  * **Queries per second**: Number of user queries per second.
  * **Slow queries per second**: Number of queries per second that are longer than specified in [long_query_time](../concepts/settings-list.md#setting-long-query-time).
  * **Threads**: Number of threads. The following is displayed separately:
   
    * **Threads cached**: Number of cached threads.
    * **Threads connected**: Number of open DB connections.

      The maximum number of open connections is set in [max_connections](../concepts/settings-list.md#setting-max-connections).

    * **Threads running**: Number of running threads.

  * **Thread states**: Number of threads in each state.
  * **Handlers**: Number of operation handlers.
  * **Replication lag**: Replica lag time behind the master.
  * **File IO write bytes**: Data write rate by file type.
  * **File IO read bytes**: Data read rate by file type.
  * **Disk usage**: Disk space usage. The following is displayed separately:
   
    * **data**: Amount of space used by data.
    * **default tablespace**: Amount of space used by data in the tablespace.
    * **innodb logs**: Amount of space used by InnoDB logs.
    * **relaylogs**, **binlogs**: Amount of space used by {{ MY }} service logs.
    * **temp tablespace**: Amount of space used by data in the temporary tablespace.
    * **undo tablespace**: Amount of space used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).

  * **File IO write operations**: Number of write operations per second by file type.
  * **File IO read operations**: Number of read operations per second by file type.
  * **Temp tables**: Number of temporary tables and files created per second.
  * **Sorts and joins**: Number of sort and join operations per second.
  * **Table cache**: Table caching. The following is displayed separately:
   
    * **open_tables**: Number of open tables.
    * **opened_tables**: Number of open tables per second.
    * **table_open_cache_hits**: Number of open table cache hits per second.
    * **table_open_cache_misses**: Number of open table cache misses per second.

  * **InnoDB rows operation**: Number of InnoDB row operations.
  * **InnoDB locks**: Row lock waits in InnoDB. The following is displayed separately:
   
    * **innodb_row_lock_current_waits**: Current number of row lock waits.
    * **innodb_row_lock_waits**: Number of operations with row lock waits per second.

  * **InnoDB lock time**: Maximum InnoDB row lock wait time.
  * **InnoDB cache efficiency**: Efficiency of the InnoDB buffer. The following is displayed separately:
   
    * **innodb_buffer_pool_reads**: Number of read operations per second where InnoDB had to access the disk.
    * **innodb_buffer_pool_read_requests**: Total number of read operations per second.

  * **InnoDB data operations**: Number of InnoDB operations per second. The following is displayed separately:
   
    * **innodb data fsyncs**: Number of `fsync()` operations when flushing data to disk.
    * **innodb data reads**: Number of disk reads.
    * **innodb data writes**: Number of disk writes.

  * **SemiSync latency**: Maximum transaction commit latency in [semi-synchronous replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html).
  * **Inode usage**: Inode usage as a percentage of the total.

  Under **MySQL overview** → **Disk Metrics Details**:

  * **Disk write latency (percentiles)**: Disk write latency, percentiles.
  * **Disk write bytes**: Average and maximum disk write rate.
  * **Disk write operations**: Average and maximum number of write operations per second.
  * **Disk read latency (percentiles)**: Disk read latency, percentiles.
  * **Disk read bytes**: Average and maximum disk read rate.
  * **Disk read operations**: Average and maximum number of read operations per second.
  * **Disk write throttler latency (percentiles)**: Write delay introduced by exceeding disk quota, percentiles.
  * **Disk read throttler latency (percentiles)**: Read delay introduced by exceeding disk quota, percentiles.
  * **Disk used quota**: Average and maximum quota used percentage for disk operations.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster for which you want to set up alerts.

    1. Navigate to ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

    1. Under **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**, select:

        * **{{ mmy-name }} — Cluster Overview** to set up cluster alerts.
        * **{{ mmy-name }} — Host Overview** to set up host alerts.

    1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

    1. If the chart displays multiple metrics, select the data query for the relevant metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. To learn more about the query language, see [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).

    1. Set the `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` alert thresholds.

    1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values for selected metrics:

| Metric                             | Internal metric name               | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`                 |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Replication lag                 | `mysql_replication_lag`   | `600`                     | `60`                      |
| Number of healthy hosts   | `mysql_is_alive`          | `<number_of_hosts> - 2` | `<number_of_hosts> - 1` |
| Average query execution time   | `mysql_latency_query_avg` | —                         | `2,000`                    |
| Storage space used    | `disk.used_bytes`         | 90% of the storage size  | 80% of the storage size  |
| CPU usage                      | `cpu.idle`                | `10`                      | `20`                      |

The `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` and `{{ ui-key.yacloud_monitoring.alert.status_warn }}` thresholds for the `disk.used_bytes` metric are specified exclusively in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)

You can check the current storage size in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-mysql-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view the health state and status of a cluster:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

