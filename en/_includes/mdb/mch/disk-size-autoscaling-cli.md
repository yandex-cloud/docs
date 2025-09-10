* `clickhouse-disk-size-limit`: Maximum storage size for a {{ CH }} subcluster, GB.

* `clickhouse-planned-usage-threshold`: {{ CH }} subcluster storage utilization threshold for storage to be increased during the next maintenance window, in percent. The default value is `0` (automatic increase disabled).
           
  The valid values range from `0` to `100`.
         
* `clickhouse-emergency-usage-threshold`: {{ CH }} subcluster storage utilization threshold for storage to be increased right away, in percent. The default value is `0` (automatic increase disabled).
           
  The valid values range from `0` to `100`.

* `zookeeper-disk-size-limit`: Maximum storage size for a {{ ZK }} subcluster, GB.

* `zookeeper-planned-usage-threshold`: {{ ZK }} subcluster storage utilization threshold for storage to be increased during the next maintenance window, in percent. The default value is `0` (automatic increase disabled).
           
  The valid values range from `0` to `100`.

* `zookeeper-emergency-usage-threshold`: {{ ZK }} subcluster storage utilization threshold for storage to be increased right away, in percent. The default value is `0` (automatic increase disabled).

  The valid values range from `0` to `100`.

{% note warning %}
         
* If you specify both thresholds for a {{ CH }} subcluster, `clickhouse-emergency-usage-threshold` must not be less than `clickhouse-planned-usage-threshold`.

* If you specify both thresholds for a {{ ZK }} subcluster, `zookeeper-emergency-usage-threshold` must not be less than `zookeeper-planned-usage-threshold`.

* When using `clickhouse-planned-usage-threshold` and `zookeeper-planned-usage-threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).

{% endnote %}

Autoscaling settings configured for a {{ CH }} subcluster apply to all existing shards within the subcluster. When adding a new shard, the settings ​​are taken from the oldest shard. These values are not saved in the subcluster configuration and are not displayed in the `{{ yc-mdb-ch }} cluster get` command output. 
         
To view information about a specific shard, including its autoscaling settings, use this command: 
         
```bash
{{ yc-mdb-ch }} shards get <shard_name> --cluster-id <cluster_ID>
```
You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.