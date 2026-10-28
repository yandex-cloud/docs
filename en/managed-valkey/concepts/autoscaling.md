---
title: Autoscaling in {{ mrd-name }}
description: Autoscaling is changing the number of {{ VLK }} cluster shards depending on current load.
---

# Autoscaling in {{ mrd-name }}

*Autoscaling* is changing the number of {{ VLK }} cluster shards depending on current load.

With autoscaling enabled, {{ mrd-name }} automatically adjusts the number of shards to match current load. This enables stable cluster operation without manually increasing or decreasing the number of shards.

For scaling, {{ mrd-name }} regularly collects [cluster shard utilization metrics](#settings). It can then take the following decisions based on these metrics:

* Increase the number of shards if the cluster is nearing overload.
* Decrease the number of shards if the cluster is consistently underloaded.
* Make no changes if utilization is within the specified thresholds.

To prevent reactions to brief load spikes, {{ k8s-ma }} takes decisions based on aggregated metrics over a few minutes. Scaling only gets initiated when the critical value persists for ten minutes.

When the number of shards is automatically changed, cluster rebalancing starts to redistribute the data. As a result, some existing slots will be moved to the new shards.

Autoscaling advantages:

* Cluster performance does not degrade as the load grows.
* When idling, excessive shards get deleted, so you pay less for you cluster.
* Query execution time does not increase as the cluster load grows and does not depend on the number of shards.
* Computing resource allocation becomes more efficient: shards adjust to the changing app needs.

## Autoscaling management {#settings}

You can enable or disable shard autoscaling when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#enable-autoscaling) a sharded {{ VLK }} cluster.

You can set the following:

* Autoscaling range:

  * Minimum number: at least 1.
  * Maximum number: maximum 10 and not less than the minimum number.

* Thresholds for monitored shard utilization metrics for upward and downward scaling.

  For autoscaling management, the following per-shard [{{ mrd-name }} metrics](../metrics.md) are used:
  
  * CPU usage
  * RAM usage

  You can set upper and lower thresholds for each metric. Based on the actual metric values, {{ mrd-name }} changes the number of shards as follows:
  
  * Scales the cluster up by one shard if any of the specified metrics continuously exceeds its threshold on at least one shard for ten minutes straight. None of the metrics has priority over others.
  * Scales the cluster down by one shard if all specified metrics on all shards remain below their lower thresholds for ten minutes straight.

  If you leave some thresholds unspecified, {{ mrd-name }} will use the default values for them. You can then edit the threshold values based on the results of cluster monitoring in autoscaling mode.
