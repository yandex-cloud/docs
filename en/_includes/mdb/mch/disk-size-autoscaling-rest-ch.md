* `plannedUsageThreshold`: Utilization threshold for the {{ CH }} storage capacity, in percent, to trigger an increase during the next maintenance window. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

* `emergencyUsageThreshold`: Utilization threshold for the {{ CH }} storage capacity, in percent, to trigger an immediate increase. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

* `diskSizeLimit`: Maximum {{ CH }} storage size, in bytes.

{% note warning %}

* If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

* When using `plannedUsageThreshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).

{% endnote %}

The automatic storage expansion settings for {{ CH }} apply to all existing shards. If you add a new shard, it will use the settings of the oldest shard. These values are not saved in the {{ CH }} configuration.

To view information about a specific shard, including automatic storage size increase settings, use the [Cluster.GetShard](../../../managed-clickhouse/api-ref/Cluster/getShard.md) method and provide the cluster ID and shard name in the request.

You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.
