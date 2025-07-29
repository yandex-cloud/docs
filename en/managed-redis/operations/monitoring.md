---
title: Monitoring the state of a {{ VLK }} cluster and hosts
description: You can track the state of a {{ mrd-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.
---

# Monitoring the state of a {{ VLK }} cluster and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed info on the state of a {{ mrd-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  The following charts will appear on the page:

  * **Can Read**: Displays clusters available for reading.

  * **Can Write**: Displays clusters available for writing.

  * **Cache Hit Rate**: Percentage of cache hits for each host.

      Values approaching 1 indicate efficient use of the cluster as a caching server. If the percentage of cache hits is close to 0, you may need to modify the application logic, the key lifetime, or the [RAM management policy](../concepts/settings-list.md#settings-maxmemory-policy) in case of memory pressure.

  * **Client recent max input buffer size**: Memory usage (in bytes) to support client connections for data writes.

  * **Client recent max output buffer size**: Memory usage to handle client connections to retrieve data:

      * **Soft Limit**: Soft memory usage limit.
      * **Hard Limit**: Hard memory usage limit.

      If the **Soft Limit** value is exceeded, the cluster will wait a few seconds for it to decrease. If the value does not decrease, the connection will be closed.
      If the **Hard Limit** value is exceeded, the connection will be closed immediately.

  * **Commands Processed**: Average number of commands processed by each cluster host.

  * **Connected Clients**: Number of open connections for each cluster host.

      If a cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for exchanging data between cluster hosts.
      Errors occuring when connecting to a cluster may result from inactive applications keeping connections open too long. If this is the case, [update the {{ VLK }} settings](../operations/update.md#change-redis-config) by editing the [Timeout](../concepts/settings-list.md#settings-timeout) value.

  * **Copy-on-write allocation**: Memory consumption by {{ VLK }} processes when using [COW (copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write) (in bytes).

      The graph shows the most recent parameter values measured by {{ VLK }}:

      * **module_fork_last_cow_size**: Amount of data copied during a `fork()` call using COW.
      * **aof_last_cow_size**: Amount of data copied when creating an AOF file.
      * **rdb_last_cow_size**: Amount of data copied when creating an RDB file.

      For more information, see [Backups](../concepts/backup.md).

  * **DB keys**: Number of keys stored in all the cluster's databases.

  * **Evicted keys**: Number of keys deleted from memory when inserting new data.

      By default, memory management uses a **noeviction** policy: do not delete keys and return an error if there is insufficient memory to insert new data. To use a different memory management policy, [modify the {{ VLK }} settings](./update.md#change-redis-config) to change the value of the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) parameter.

  * **Inner memory limit**: Amount of RAM (in bytes) available for {{ VLK }} processes:

      * **maxmemory**: Maximum amount of memory allocated for user data.
      * **used_memory**: Actual memory usage by a host.

      If **used_memory** reaches **maxmemory** when trying to insert new records, {{ VLK }} will apply the memory management mode controlled by the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) setting.

      {% note info %}

      The value of **maxmemory** for {{ VLK }} hosts is set to {{ mrd-memory-used }} of the available memory. For more information, see [Memory management](../concepts/memory-management.md).

      {% endnote %}

  * **Outer memory limit**: Shows the total amount of RAM (in bytes) available for use on hosts:

      * **memory_limit**: Amount of memory allocated to each host.
      * **used_memory_rss**: Process memory usage by {{ VLK }} processes.

      When the value of **used_memory_rss** approaches the value of **memory_limit**, a {{ VLK }} process may be killed by the operating system. To avoid this:
      * Change the application logic to reduce the amount of data stored in {{ VLK }}.
      * [Go to the {{ VLK }} settings](./update.md#change-redis-config) and change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value responsible for the RAM management policy in case of memory pressure.
      * [upgrade the host to a higher class](./update.md#change-resource-preset).

  * **Redis Used Memory on Masters**: RAM usage on master hosts (in bytes):

      * **db_hashtable_overhead**: To store all database hash tables.
      * **used_memory_scripts**: To store and run [scripts](https://valkey.io/commands/script-load).
      * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
      * **mem_clients_normal**: To serve external connections.
      * **mem_clients_slaves**: To serve replication connections.
      * **mem_replication_backlog**: For a circular replication buffer.
      * **used_memory_startup**: For {{ VLK }} processes at startup (for example, after a cluster reboot).
      * **used_memory_dataset**: For data storage.
      * **mem_cluster_links**: For network connections in cluster mode.

  * **Redis Used Memory on Replicas**: RAM usage on replicas (in bytes):

      * **db_hashtable_overhead**: To store all database hash tables.
      * **used_memory_scripts**: To store and run [scripts](https://valkey.io/commands/script-load).
      * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
      * **mem_clients_normal**: To serve external connections.
      * **mem_clients_slaves**: To serve replication connections.
      * **mem_replication_backlog**: For a circular replication buffer.
      * **used_memory_startup**: For {{ VLK }} processes at startup (for example, after a cluster reboot).
      * **used_memory_dataset**: For data storage.
      * **mem_cluster_links**: For network connections in cluster mode.

  * **Redis-server OOM kills (for last hour)**: Number of {{ VLK }} processes terminated because of a RAM shortage (_OOM_ stands for out-of-memory) for the last hour.

      To reduce the number of terminations:
      * Change the application logic to reduce the amount of data stored in {{ VLK }}.
      * [Go to the {{ VLK }} settings](./update.md#change-redis-config) and change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value responsible for the RAM management policy in case of memory pressure.
      * [upgrade the host to a higher class](./update.md#change-resource-preset).

  * **Replication buffer size**: [Replication](../concepts/replication.md#replication) buffer size (in bytes):

      * **repl_backlog_size**: Maximum amount of memory available for the replication buffer.
      * **repl_backlog_histlen**: Portion of the replication buffer currently in use by data.

      When the circular buffer runs out of memory, complete replication starts. This will reduce cluster performance since full replication significantly increases RAM usage as well as CPU and network workload.

  * **Replication Lag**: Replica's lag behind the master (in seconds).

      A non-zero value indicates that commands take a long time to execute on a replica or that the replica is overloaded.

      For more information, see [{#T}](../concepts/replication.md).

  * **Slowlog top operations on Master**: List of the 5 slowest commands executed on the master host within one minute.
  
  * **Slowlog top operations on Replicas**: List of the 5 slowest commands executed on each replica host within one minute.

  * **Slowlog new records**: Displays new entries in the slow log.

      A slow command is a command whose runtime has exceeded the [Slowlog log slower than](../concepts/settings-list.md#settings-slowlog-slower-than) setting. The graph shows only the first part of a command as well as the number of times it was called in one minute.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed info on the state of individual {{ mrd-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
  1. Select the host from the drop-down list.

  This page displays charts showing the load on an individual host in the cluster:

  * **CPU usage**: Usage of processor cores. As the load goes up, the `idle` value goes down.
  * **Disk read/write bytes**: Speed of disk operations, in bytes per second.
  * **Disk IOPS**: Number of disk operations per second.
  * **Disk space usage**: Amount of used and total disk space.
  * **Memory usage**: Use of RAM, in bytes. At high loads, the `Free` value goes down, while the other values go up.
  * **Network bytes**: Speed of network data exchange (bytes per second).
  * **Network packets**: Network packet transmission activity (packets per second).

  The **Disk read/write bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

  For hosts with the **Replica** role, **Received** is normally greater than **Sent** on the **Network bytes** and **Network packets** charts.

{% endlist %}


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

To configure state indicator alerts for the [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you want to configure alerts for.
  1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
      * **{{ mrd-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mrd-name }} — Host Overview** to configure host alerts.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
  1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric                                                                                                   | Parameter         | `Alarm`                  | `Warning`                |
|----------------------------------------------------------------------------------------------------------:|:-------------------:|:------------------------:|:------------------------:|
| DB write availability                                                                                  | `can_write`         | `Equals 0`                | —                        |
| Number of Out of Memory errors, per hour                                                                   | `redis_oom_count`   | `More than 2`               | `Greater than 0`               |
| RAM utilization (only for [noeviction policy](../concepts/settings-list.md#settings-maxmemory-policy)) | `redis_used_memory` | 90% RAM        | 75% RAM        |
| Storage space used                                                                          | `disk.used_bytes`   | 90% of the storage size | 80% of the storage size |

For the `disk.used_bytes` metric, the `Alarm` and `Warning` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

You can view a host's current RAM amount in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} article](../../monitoring/metrics-ref/managed-redis-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Hover over the indicator in the cluster row of the **{{ ui-key.yacloud.common.availability }}** column.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

