* `plannedUsageThreshold`: {{ CH }} subcluster storage utilization threshold to trigger a storage expansion during the next maintenance window, in percent. The default value is `0` (automatic expansion disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergencyUsageThreshold`: {{ CH }} subcluster storage utilization threshold to trigger an immediate storage expansion, in percent. The default value is `0` (automatic expansion disabled).
                      
  The valid values range from `0` to `100`.
                      
* `diskSizeLimit`: Maximum storage size for a {{ CH }} subcluster, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.
                      
* When using `plannedUsageThreshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}
                      
Autoscaling settings configured for a {{ CH }} subcluster apply to all existing shards within the subcluster. If you add a new shard, it will use the settings of the oldest shard. These values are not saved in the subcluster configuration.
                      
To view information about a specific shard, including autoscaling settings, use the [Cluster.GetShard](../../../managed-clickhouse/api-ref/Cluster/getShard.md) method and provide the cluster ID and shard name in the request.
                      
You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.