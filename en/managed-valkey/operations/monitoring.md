---
title: Monitoring the state of a {{ VLK }} cluster and its hosts
description: You can monitor the state of a {{ mrd-name }} cluster and its individual hosts using the monitoring tools in the management console. These tools display diagnostic information as charts.
---

# Monitoring the state of a {{ VLK }} cluster and its hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring the cluster state {#monitoring-cluster}

To view detailed information on the state of a {{ mrd-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  You will see the following charts:

  * **Can Read**: Displays clusters available for reading.

  * **Can Write**: Displays clusters available for writing.

  * **Cache Hit Rate**: Percentage of cache hits on each host.

      Values close to 1 show efficient use of the cluster as a caching server. If the hit rate approaches 0, you may need to change your application logic, key lifetime, or the [RAM management policy](../concepts/settings-list.md#settings-maxmemory-policy) when low on memory.

  * **Client recent max input buffer size**: Amount of memory used to handle client write connections, in bytes.

  * **Client recent max output buffer size**: Amount of memory used to handle client read connections:

      * **Soft Limit**: Soft memory usage limit.
      * **Hard Limit**: Hard memory usage limit.

      If the **Soft Limit** value is exceeded, the cluster will wait a few seconds for it to decrease. If the value does not decrease, the connection will be closed.
      If the **Hard Limit** value is exceeded, the connection will be closed immediately.

  * **Commands Processed**: Average number of commands processed by each cluster host.

  * **Connected Clients**: Number of open connections for each cluster host.

      If the cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for inter-host communication within the cluster.
      If you encounter errors when connecting to the cluster, inactive applications may be keeping connections open for too long. If this is the case, [update the {{ VLK }} settings](../operations/update.md#change-valkey-config) by editing the [Timeout](../concepts/settings-list.md#settings-timeout) value.

  * **Copy-on-write allocation**: Memory consumption by {{ VLK }} processes when using [COW (copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write), in bytes.

      The chart shows the latest measured {{ VLK }} parameter values:

      * **module_fork_last_cow_size**: Amount of data copied during a `fork()` call using COW.
      * **aof_last_cow_size**: Size of data copied when creating an AOF file.
      * **rdb_last_cow_size**: Size of data copied when creating an RDB file.

      For more information, see [Backups](../concepts/backup.md).

  * **DB keys**: Number of keys stored in all cluster databases.

  * **Evicted keys**: Number of keys deleted from memory when inserting new data.

      By default, {{ VLK }} applies the **noeviction** memory policy, which prevents key deletion and returns an error if memory is too low to insert new data. To use a different memory management policy, adjust the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value in the [{{ VLK }} settings](./update.md#change-valkey-config).

  * **Inner memory limit**: Amount of RAM available for {{ VLK }} processes, in bytes:

      * **maxmemory**: Maximum amount of memory allocated for user data.
      * **used_memory**: Actual host memory usage.

      If **used_memory** reaches **maxmemory** when trying to insert new records, {{ VLK }} will apply the memory management mode defined by the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) setting.

      {% note info %}

      The value of **maxmemory** for {{ VLK }} hosts is set to {{ mrd-memory-used }} of the available memory. For more information, see [Memory management](../concepts/memory-management.md).

      {% endnote %}

  * **Outer memory limit**: Total amount of RAM available for use on hosts, in bytes:

      * **memory_limit**: Amount of memory allocated to each host.
      * **used_memory_rss**: Memory used by {{ VLK }} processes.

      If **used_memory_rss** approaches **memory_limit**, the operating system may forcibly terminate the relevant {{ VLK }} process. To avoid this:
      * Change the application logic to reduce the amount of data stored in {{ VLK }}.
      * Change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value defining the RAM management policy when low on memory in the [{{ VLK }} settings](./update.md#change-valkey-config).
      * [Upgrade the host to a higher class](./update.md#change-resource-preset).

  * **Redis Used Memory on Masters**: RAM usage on master hosts, in bytes:

      * **db_hashtable_overhead**: For storing hash tables of all databases.
      * **used_memory_scripts**: For storing and running [scripts](https://valkey.io/commands/script-load).
      * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
      * **mem_clients_normal**: For handling external client connections.
      * **mem_clients_slaves**: For handling replication connections.
      * **mem_replication_backlog**: For the replication backlog buffer.
      * **used_memory_startup**: For {{ VLK }} processes at startup, e.g., after restarting a cluster.
      * **used_memory_dataset**: For storing data.
      * **mem_cluster_links**: For network connections in cluster mode.

  * **Redis Used Memory on Replicas**: RAM usage on replica hosts, in bytes:

      * **db_hashtable_overhead**: For storing hash tables of all databases.
      * **used_memory_scripts**: For storing and running [scripts](https://valkey.io/commands/script-load).
      * **mem_aof_buffer**: For the [AOF](../concepts/replication.md#setting-appendonly) buffer.
      * **mem_clients_normal**: For handling external client connections.
      * **mem_clients_slaves**: For handling replication connections.
      * **mem_replication_backlog**: For the replication backlog.
      * **used_memory_startup**: For {{ VLK }} processes at startup, e.g., after restarting a cluster.
      * **used_memory_dataset**: For storing data.
      * **mem_cluster_links**: For network connections in cluster mode.

  * **Redis-server OOM kills (for last hour)**: Number of {{ VLK }} processes terminated due to _OOM_ (out-of-memory) for the last hour.

      To reduce the number of terminated processes:
      * Change the application logic to reduce the amount of data stored in {{ VLK }}.
      * Change the [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy) value defining the RAM management policy when low on RAM in the [{{ VLK }} settings](./update.md#change-valkey-config).
      * [Upgrade the host to a higher class](./update.md#change-resource-preset).

  * **Replication buffer size**: [Replication](../concepts/replication.md#replication) backlog size, in bytes:

      * **repl_backlog_size**: Maximum size of memory available for the replication backlog.
      * **repl_backlog_histlen**: Size of memory currently used by the replication backlog.

      When the replication backlog runs out of memory, full replication starts. This will reduce cluster performance because full replication significantly increases RAM usage as well as CPU and network workload.

  * **Replication Lag**: Replica's lag behind the master, in seconds.

      A non-zero value indicates either slow command execution on the replica or replica overload.

      For more information, see [{#T}](../concepts/replication.md).

  * **Slowlog top operations on Master**: List of the 5 slowest commands executed on the master host within one minute.
  
  * **Slowlog top operations on Replicas**: List of the 5 slowest commands executed on each replica host within one minute.

  * **Slowlog new records**: Displays new entries in the slow log.

      A slow command is a command whose runtime has exceeded the [Slowlog log slower than](../concepts/settings-list.md#settings-slowlog-slower-than) setting. The chart only shows the first part of the command and its call count per minute.

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information on the state of individual {{ mrd-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Select the host from the drop-down list.

  This page displays the charts showing workloads of individual cluster hosts:

  * **CPU usage**: Processor core workload. As the workload goes up, the `idle` value goes down.
  * **Disk read/write bytes**: Speed of disk operations, in bytes per second.
  * **Disk IOPS**: Number of disk operations per second.
  * **Disk space usage**: Amount of used and total disk space.
  * **Memory usage**: Amount of RAM used, in bytes. At high workloads, the `Free` value goes down, while the other values go up.
  * **Network bytes**: Network data exchange rate, in bytes per second.
  * **Network packets**: Number of network packets exchanged per second.

  The **Disk read/write bytes** and the **Disk IOPS** charts show the increase of the **Read** value during database read activity, and in **Write**, during database write activity..

  For **Replica** hosts, the **Received** value is normally greater than **Sent** on the **Network bytes** and **Network packets** charts.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure state indicator alerts for a [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster for which you want to set up alerts.
  1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
      * **{{ mrd-name }} — Cluster Overview** to set up cluster alerts.
      * **{{ mrd-name }} — Host Overview** to set up host alerts.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `Alarm` and `Warning` thresholds to trigger the alert.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Below are the recommended thresholds for some metrics:

| Metric                                                                                                   | Designation         | `Alarm`                  | `Warning`                |
|----------------------------------------------------------------------------------------------------------:|:-------------------:|:------------------------:|:------------------------:|
| Database write availability                                                                                  | `can_write`         | `Equal to 0`                | —                        |
| Number of out-of-memory errors, per hour                                                                   | `redis_oom_count`   | `More than 2`               | `More than 0`               |
| RAM utilization (only for the [noeviction policy](../concepts/settings-list.md#settings-maxmemory-policy)) | `redis_used_memory` | 90% of RAM        | 75% of RAM        |
| Storage space used                                                                          | `disk.used_bytes`   | 90% of the storage size | 80% of the storage size |

For the `disk.used_bytes` metric, the `Alarm` and `Warning` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

You can view the current RAM of the hosts in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-valkey-ref.md).


## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster’s state and status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

