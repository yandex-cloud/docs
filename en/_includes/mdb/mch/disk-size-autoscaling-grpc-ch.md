* `planned_usage_threshold`: {{ CH }} subcluster storage utilization threshold for storage to be increased during the next maintenance window, in percent. The default value is `0` (automatic increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergency_usage_threshold`: {{ CH }} subcluster storage utilization threshold for storage to be increased right away, in percent. The default value is `0` (automatic increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `disk_size_limit`: Maximum storage size for a {{ CH }} subcluster, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
                      
* When using `planned_usage_threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}
                      
Autoscaling settings configured for a {{ CH }} subcluster apply to all existing shards within the subcluster. When adding a new shard, the settings ​​are taken from the oldest shard. These values ​​are not saved in the subcluster configuration.
                      
To view information about a specific shard, including its autoscaling settings, use the [ClusterService.GetShard](../../../managed-clickhouse/api-ref/grpc/Cluster/getShard.md) method and provide the cluster ID and shard name in the request.
                      
You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.