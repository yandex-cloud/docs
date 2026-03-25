---
title: Cluster, host, and shard state monitoring in {{ mrd-name }}
description: You can monitor the state of a {{ mrd-name }} cluster and its hosts and shards using the monitoring tools in the management console. These tools display diagnostic information as charts.
---

# Cluster, host, and shard state monitoring in {{ mrd-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Cluster health state monitoring {#monitoring-cluster}

To view detailed information on the health state of a {{ mrd-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab.
      
      The page that opens will display performance charts for the cluster.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  The following charts are displayed for a cluster:

  * **Hosts available for read**: Cluster host read availability.
  * **Hosts available for write**: Cluster host write availability.

  Under **Traffic**:

  * **Connected Clients**: Number of open connections to services on cluster hosts.

      If the cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for inter-host communication within the cluster.
      If you encounter errors when connecting to the cluster, inactive applications may be keeping connections open for too long. If this is the case, [update the {{ VLK }} settings](../operations/update.md#change-valkey-config) by editing the [Timeout](../concepts/settings-list.md#settings-timeout) value.

  * **Commands Processed**: Rate of command processing on each cluster host.
  * **Commandstats**: Rate of command calls on each cluster host.

  Under **Latency**:

  * **Latencystats, p50**: Median command execution time. 
  * **Latencystats, p99**: Command execution time in the 99th percentile.
  * **Latencystats, p99.9**: Command execution time in the 99.9th percentile.

  Under **DB Metrics**:

  * **DB keys**: Number of keys on each cluster host.
  * **Evicted keys**: Number of keys deleted from memory when inserting new data. Information is displayed for each cluster host.
  * **Cache Hit Rate**: Percentage of requests for which data was retrieved from the cache. Information is displayed for each cluster host.
  * **Replication Lag**: Replica's lag behind the master, in seconds.
  * **IO threads active**: Number of active threads on each cluster host.
  * **Valkey-server OOM kills (for last hour)**: Number of `Out of Memory` errors on each cluster host.

  Under **Resources** → **Memory**:

  * **Outer memory limit**: Limit and RAM usage by processes on each cluster host.
  * **Inner Memory limit**: Limit and RAM usage on each cluster host.
  * **Memory fragmentation ratio**: Ratio of allocated memory to actually used memory on each cluster host.
  * **Valkey Used Memory on Masters**: RAM usage on master hosts of the cluster.
  * **Valkey Used Memory on Replicas**: RAM usage in replicated cluster hosts.
  * **Replication buffer size**: Size of used and available memory for the [replication](../concepts/replication.md#replication) buffer on each cluster host.
  * **Client recent max input buffer size**: Maximum buffer size for handling incoming client connections on each cluster host.
  * **Client recent max output buffer size**: Maximum buffer size for handling outgoing client connections on each cluster host.
  * **Copy-on-write allocations**: Amount of memory allocated by the COW mechanism when creating child processes. Information is displayed for each cluster host.

  Under **Resources** → **CPU**:

  * **CPU usage main thread**: CPU time, system and user, consumed by the main thread on each cluster host.
  * **CPU usage main thread on Masters**: CPU time, system and user, consumed by the main thread on the cluster's master hosts. 
  * **CPU usage main thread on Replicas**: CPU time, system and user, consumed by the main thread on the cluster's replica hosts. 

  Under **Resources** → **Network**:

  * **Network usage**: Amount of incoming and outgoing network traffic on each cluster host.
  * **Network usage on Masters**: Amount of incoming and outgoing network traffic on the cluster's master hosts.
  * **Network usage on Replicas**: Amount of incoming and outgoing network traffic on the cluster's replica hosts.
  * **Replication network usage**: Amount of incoming and outgoing network traffic for replication on each cluster host.
  * **Replication network usage on Masters**: Amount of incoming and outgoing network traffic for replication on the cluster's master hosts.
  * **Replication network usage on Replicas**: Amount of incoming and outgoing network traffic for replication on the cluster's replica hosts.

  Under **Resources** → **Data**:

  * **Disk IO**: Rate of disk operations on each cluster host.
  * **Disk space usage percentage**: Percentage of disk space used on each cluster host.
  * **Disk space usage**: Amount of disk space used on each cluster host.

  Under **Errors**:

  * **Errorstats**: Rate of failed queries on each cluster host.
  * **Sentinel error replies**: Number of {{ RD }} Sentinel's error responses on each cluster host.
  * **ACL errors**: Rate of access errors on each cluster host.

  Under **Slowlog**:

  * **Slowlog top operations on Master**: Number of records for each command in the Slowlog on the cluster's master hosts.
  * **Slowlog top operations on Replicas**: Number of records for each command in the Slowlog on the cluster's replica hosts.
  * **Slowlog new records**: Number of new records in the Slowlog on each cluster host.

{% endlist %}

## Host state monitoring {#monitoring-hosts}

To view detailed information on the state of individual {{ mrd-name }} hosts:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
  1. Click the name of your cluster and select **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Select the host from the drop-down list.

  This page displays the charts showing workloads of individual cluster hosts:

  * **CPU usage**: Processor core workload. As the workload goes up, the `idle` value goes down.
  * **Disk read/write bytes**: Speed of disk operations, in bytes per second.
  * **Disk IOPS**: Number of disk operations per second.
  * **Disk space usage**: Amount of used and total disk space.
  * **Memory usage**: Amount of RAM used, in bytes. At high workloads, the `Free` value goes down, while the other values go up.
  * **Network bytes**: Network data exchange rate, in bytes per second.
  * **Network packets**: Network packet exchange rate, in packets per second.

  The **Disk read/write bytes** and the **Disk IOPS** charts show the increase of the **Read** value during database read activity, and in **Write**, during database write activity.

  For **Replica** hosts, the **Received** value is normally greater than **Sent** on the **Network bytes** and **Network packets** charts.

{% endlist %}

## Shard state monitoring {#monitoring-shards}

To view detailed information on the health state of {{ mrd-name }} shards:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}** tab.
  1. Navigate to the **Shards** tab and select a shard.
      
      The page that opens will display health state charts for the selected shard and its hosts.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  The following charts are displayed for shards:

  * **Hosts available for read**: Shard host read availability.
  * **Hosts available for write**: Shard host write availability.

  Under **Traffic**:

  * **Connected Clients**: Number of open connections to services on shard hosts.

      If the cluster is [sharded](../concepts/sharding.md) or uses [replication](../concepts/replication.md), some of the connections will be used for inter-host communication within the cluster.
      If you encounter errors when connecting to the cluster, inactive applications may be keeping connections open for too long. If this is the case, [update the {{ VLK }}](../operations/update.md#change-valkey-config) settings by editing the [Timeout](../concepts/settings-list.md#settings-timeout) value.

  * **Commands Processed**: Rate of command processing on each shard host.
  * **Commandstats**: Rate of command calls on each shard host.

  Under **Latency**:

  * **Latencystats, p50**: Median command execution time on the shard. 
  * **Latencystats, p99**: Command execution time in the 99th percentile on the shard.
  * **Latencystats, p99.9**: Command execution time in the 99.9th percentile on the shard.

  Under **DB Metrics**:

  * **DB keys**: Number of keys on each shard host.
  * **Evicted keys**: Number of keys deleted from memory when inserting new data. Information is displayed for each shard host.
  * **Cache Hit Rate**: Percentage of requests for which data was retrieved from the cache. Information is displayed for each shard host.
  * **Replication Lag**: Replica's lag behind the master, in seconds.
  * **IO threads active**: Number of active threads on each shard host.
  * **Valkey-server OOM kills (for last hour)**: Number of `Out of Memory` errors on each shard host.

  Under **Resources** → **Memory**:

  * **Outer memory limit**: Limit and RAM usage by processes on each shard host.
  * **Inner Memory limit**: Limit and RAM usage on each shard host.
  * **Memory fragmentation ratio**: Ratio of allocated memory to actually used memory on each shard host.
  * **Valkey Used Memory on Masters**: RAM usage on the shard's master hosts.
  * **Valkey Used Memory on Replicas**: RAM usage in replicated shard hosts.
  * **Replication buffer size**: Size of used and available memory for the [replication](../concepts/replication.md#replication) buffer on each shard host.
  * **Client recent max input buffer size**: Maximum buffer size for handling incoming client connections on each shard host.
  * **Client recent max output buffer size**: Maximum buffer size for handling outgoing client connections on each shard host.
  * **Copy-on-write allocations**: Amount of memory allocated by the COW mechanism when creating child processes. Information is displayed for each shard host.

  Under **Resources** → **CPU**:

  * **CPU usage main thread**: CPU time, system and user, consumed by the main thread on each shard host.
  * **CPU usage main thread on Masters**: CPU time, system and user, consumed by the main thread on the shard's master hosts. 
  * **CPU usage main thread on Replicas**: CPU time, system and user, used by the main thread on the shard's replica hosts. 

  Under **Resources** → **Network**:

  * **Network usage**: Amount of incoming and outgoing network traffic on each shard host.
  * **Network usage on Masters**: Amount of incoming and outgoing network traffic on the shard's master hosts.
  * **Network usage on Replicas**: Amount of incoming and outgoing network traffic on the shard's replica hosts.
  * **Replication network usage**: Amount of incoming and outgoing network traffic for replication on each shard host.
  * **Replication network usage on Masters**: Amount of incoming and outgoing network traffic for replication on the shard's master hosts.
  * **Replication network usage on Replicas**: Amount of incoming and outgoing network traffic for replication on the shard's replica hosts.

  Under **Resources** → **Data**:

  * **Disk IO**: Rate of disk operations on each shard host.
  * **Disk space usage percentage**: Percentage of disk space used on each shard host.
  * **Disk space usage**: Amount of disk space used on each shard host.

  Under **Errors**:

  * **Errorstats**: Rate of failed queries on each shard host.
  * **Sentinel error replies**: Number of {{ RD }} Sentinel's error responses on each shard host.
  * **ACL errors**: Rate of access errors on each shard host.

  Under **Slowlog**:

  * **Slowlog top operations on Master**: Number of records for each command in the Slowlog on the shard's master hosts.
  * **Slowlog top operations on Replicas**: Number of records for each command in the Slowlog on the shard's replica hosts.
  * **Slowlog new records**: Number of new records in the Slowlog on each shard host.

{% endlist %}


## Setting up alerts in {{ monitoring-full-name }} {#monitoring-integration}

To configure state indicator alerts for a [cluster](#monitoring-cluster) and [hosts](#monitoring-hosts):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster where you want to set up alerts.
  1. [Go to](../../console/operations/select-service.md#select-service) ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Under **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}**, select:
      * **{{ mrd-name }} — Cluster Overview** to set up cluster alerts.
      * **{{ mrd-name }} — Host Overview** to set up host alerts.
  1. In the chart you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. If the chart shows multiple metrics, select the data query to generate a metric and click **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. You can learn more about the query language in [this {{ monitoring-full-name }} article](../../monitoring/concepts/querying.md).
  1. Set the `Alarm` and `Warning` alert thresholds.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values for selected metrics:

| Metric                                                                                                   | Internal metric name         | `Alarm`                  | `Warning`                |
|----------------------------------------------------------------------------------------------------------:|:-------------------:|:------------------------:|:------------------------:|
| Database write availability                                                                                  | `can_write`         | `Equal to 0`                | —                        |
| Number of out-of-memory errors, per hour                                                                   | `redis_oom_count`   | `More than 2`               | `More than 0`               |
| RAM utilization (only for the [noeviction policy](../concepts/settings-list.md#settings-maxmemory-policy)) | `redis_used_memory` | 90% of RAM        | 75% of RAM        |
| Storage space used                                                                          | `disk.used_bytes`   | 90% of the storage size | 80% of the storage size |

For the `disk.used_bytes` metric, the `Alarm` and `Warning` thresholds are only set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

You can view the current RAM of the hosts in the [detailed information about the cluster](cluster-list.md#get-cluster). For a complete list of supported metrics, see [this {{ monitoring-name }} guide](../../monitoring/metrics-ref/managed-valkey-ref.md).


## Cluster health and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To check the cluster state and status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
  1. In the cluster row, hover over the indicator in the **{{ ui-key.yacloud.common.availability }}** column.

{% endlist %}

### Cluster health states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

