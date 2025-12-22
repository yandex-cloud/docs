* `planned_usage_threshold`: Utilization threshold for the {{ CH }} storage capacity, in percent, to trigger an expansion during the next maintenance window. The default value is `0` (auto increasing disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergency_usage_threshold`: Utilization threshold for the {{ CH }} storage capacity, in percent, to trigger an immediate expansion. The default value is `0` (auto increasing disabled).
                      
  The valid values range from `0` to `100`.
                      
* `disk_size_limit`: Maximum {{ CH }} storage size, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
                      
* When using `planned_usage_threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}
                      
The automatic storage size increase settings for {{ CH }} apply to all existing shards. If you add a new shard, it will use the settings of the oldest shard. These values are not saved in the {{ CH }} configuration.
                      
To view information about a specific shard, including automatic storage expansion settings, use the [ClusterService.GetShard](../../../managed-clickhouse/api-ref/grpc/Cluster/getShard.md) method and provide the cluster ID and shard name in the request.
                      
You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.