---
title: "Monitoring the state of Redis clusters and hosts"
description: "Using monitoring tools in the management console, you can track the state of a {{ mrd-name }} cluster and its individual hosts. These tools display diagnostic information as charts."
---

# Monitoring the state of {{ RD }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster state {#monitoring-cluster}

To view detailed information about the {{ mrd-name }} cluster state:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   The following charts will open on the page:

   * **Cache Hit Rate**: Percentage of cache hits for each host.

      Values approaching 1 indicate efficient use of the cluster as a caching server. If the percentage of cache hits is close to 0, you may need to modify the application logic, the key lifetime, or the [RAM management policy](../concepts/settings-list.md#settings-maxmemory-policy) in case of memory pressure.

   * **Client recent max input buffer size**: Memory usage (in bytes) to support client connections for data writes.

   * **Client recent max output buffer size**: Memory usage to handle client connections to retrieve data:

      * **soft_limit**: Soft memory usage limit.
      * **hard_limit**: Hard memory usage limit.
      * **buffer**: Current amount of data in buffer.

      If the value of **buffer** reaches the **soft_limit**, the cluster will wait a few seconds for it to decrease. If the value of **buffer** does not decrease, the connection will be closed.

      If the value of **buffer** becomes equal to the value of **hard_limit**, the connection will shut down immediately.

   * **Commands Processed**: Average number of commands processed by each cluster host.

   * **Connected Clients**: Number of open connections for each cluster host.

      If a cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for exchanging data between cluster hosts.

      Errors occuring when connecting to a cluster may result from inactive applications keeping connections open too long. If this is the case, [modify the {{ RD }} settings](../operations/update.md#change-redis-config) to change the value of the [Timeout](../concepts/settings-list.md#settings-timeout) parameter.

   * **Copy-on-write allocation**: Memory usage (in bytes) by {{ RD }} processes when using the [COW (Copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write) mechanism.

      The graph shows the most recent parameter values measured by {{ RD }}:

      * **module_fork_last_cow_size**: Amount of data copied during a `fork()` call using the COW mechanism.
      * **aof_last_cow_size**: Amount of data copied when creating an AOF file.
      * **rdb_last_cow_size**: Amount of data copied when creating an RDB file.

      For more information, see [{#T}](../concepts/backup.md).

   * **DB keys**: Number of keys stored in all the cluster's databases.

   * **Evicted keys**: Number of keys deleted from memory when inserting new data.

      By default, memory management uses a **noeviction** policy: do not delete keys and return an error if there is insufficient memory to insert new data. To use a different memory management policy, [modify the {{ RD }} settings](./update.md#change-redis-config) to change the value of the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) parameter.

   * **Inner memory limit**: Amount of RAM (in bytes) available for {{ RD }} processes:

      * **maxmemory**: The maximum amount of memory allocated for user data.
      * **used_memory**: Actual memory usage by a host.

      If the value of the **used_memory** parameter reaches **maxmemory** when trying to insert new records, {{ RD }} will apply the memory management mode defined by the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) setting.

      {% note info %}

      The value of **maxmemory** for Redis hosts is set to {{ mrd-memory-used }} of the available memory. For more information, see [{#T}](../concepts/memory-management.md).

      {% endnote %}

   * **Is Alive**: Indicates cluster accessibility as the sum of its hosts' states.

      Each **Alive** host increases the overall availability by 1. When one of the hosts fails, the overall availability is reduced by 1.

      To increase the availability of a cluster, [add hosts](hosts.md#add).

   * **Is Master**: Shows which host is and how long it has been master.

      With [sharding](../concepts/sharding.md) enabled, the graph will display information on master hosts in each shard.

   * **Outer memory limit**: Shows the total amount of RAM (in bytes) available for use on hosts:

      * **memory_limit**: The amount of memory allocated to each host.
      * **used_memory_rss**: Process memory usage by {{ RD }} processes.

      When the value of **used_memory_rss** approaches the value of **memory_limit**, a {{ RD }} process may be killed by the operating system. To avoid this:
      * Change the application logic to reduce the amount of data stored in {{ RD }}.
      * [Go to the {{ RD }} settings](./update.md#change-redis-config) and change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value responsible for the RAM management policy in case of memory pressure.
      * [upgrade the host to a higher class](./update.md#change-resource-preset).

   * **Redis Used Memory on Masters**: RAM usage on master hosts (in bytes):

      * **db_hashtable_overhead**: To store all database hash tables.
      * **used_memory_scripts**: To store and run [scripts](https://redis.io/commands/script-load).
      * **mem_aof_buffer**: for the [AOF](../concepts/replication.md#setting-appendonly) buffer;
      * **mem_clients_normal**: To service external connections.
      * **mem_clients_slaves**: To service replication connections.
      * **mem_replication_backlog**: For a circular replication buffer.
      * **used_memory_startup**: For {{ RD }} processes at startup (for example, after a cluster reboot).
      * **used_memory_dataset**: For data storage.

   * **Redis Used Memory on Replicas**: RAM usage on replicas (in bytes):

      * **db_hashtable_overhead**: To store all database hash tables.
      * **used_memory_scripts**: To store and run [scripts](https://redis.io/commands/script-load).
      * **mem_aof_buffer**: for the [AOF](../concepts/replication.md#setting-appendonly) buffer;
      * **mem_clients_normal**: To service external connections.
      * **mem_clients_slaves**: To service replication connections.
      * **mem_replication_backlog**: For a circular replication buffer.
      * **used_memory_startup**: For {{ RD }} processes at startup (for example, after a cluster reboot).
      * **used_memory_dataset**: For data storage.

   * **Redis-server OOM kills**: Number of {{ RD }} processes terminated because of a shortage of RAM (_OOM_ stands for out-of-memory).

      To reduce the number of terminations:
      * Change the application logic to reduce the amount of data stored in {{ RD }}.
      * [Go to the {{ RD }} settings](./update.md#change-redis-config) and change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value responsible for the RAM management policy in case of memory pressure.
      * [upgrade the host to a higher class](./update.md#change-resource-preset).

   * **Replication buffer size**: [Replication](../concepts/replication.md#replication) buffer size (in bytes):

      * **repl_backlog_size**: Maximum amount of memory available for the replication buffer.
      * **repl_backlog_histlen**: Portion of the replication buffer currently in use by data.

      When the circular buffer runs out of memory, complete replication starts. This will reduce cluster performance since full replication significantly increases RAM usage as well as CPU and network workload.

   * **Replication lag**: The number of seconds that the replica lags behind the master.

      A non-zero value indicates that commands take a long time to execute on a replica or that the replica is overloaded.

      For more information, see [{#T}](../concepts/replication.md).

   * **Slowlog top operations**: List of the 5 slowest commands executed on each host in the course of one minute.

      A slow command is a command whose running time has exceeded the [Slowlog log slower than](../concepts/settings-list.md#settings-slowlog-slower-than) setting. The graph shows only the first part of a command as well as the number of times it was called in one minute.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the state of individual {{ mrd-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** tab.
   1. Select the host from the drop-down list.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU**: Load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk bytes**: Speed of disk operations (bytes per second).
   * **Disk IOPS**: Number of disk operations per second.
   * **Memory**: Use of RAM, in bytes. At high loads, the `Free` value goes down, while the other values go up.
   * **Network bytes**: Speed of data exchange over the network, in bytes per second.
   * **Network packets**: Number of packets exchanged over the network, per second.

   The **Disk bytes** and the **Disk IOPS** charts show that the **Read** property increases when active database reads are in progress, and that **Write** increases when database writes are in progress.

   For hosts with the **Replica** role, **Received** is normally greater than **Sent** on the **Network Bytes** and **Network Packets** charts.

{% endlist %}


## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
      * **{{ mpg-name }} — Cluster Overview** to configure cluster alerts.
      * **{{ mpg-name }} — Host Overview** to configure host alerts.
   1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
   1. If the chart shows multiple metrics, select a data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

The recommended thresholds are as follows:

| Metric | Parameter | `Alarm` | `Warning` |
|----------------------------------------------------------------------------------------------------------:|:-------------------:|:------------------------:|:------------------------:|
| DB write availability | `can_write` | `Equals 0` | — |
| Number of Out of Memory errors, per hour | `redis_oom_count` | `Greater than 2` | `Greater than 0` |
| RAM utilization (only for [noeviction policy](../concepts/settings-list.md#settings-maxmemory-policy)) | `redis_used_memory` | 90% RAM | 75% RAM |
| Storage space used | `disk.used_bytes` | 90% of the storage size | 80% of storage size |

For the `disk.used_bytes` metric, the values of the `Alarm` and `Warning` metrics are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96,636,764,160` bytes (90%).
* `Warning`: `85,899,345,920` bytes (80%).

You can view a host's current RAM amount in the [cluster details](cluster-list.md#get-cluster). For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-redis).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column in the required cluster row.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

