* `clickhouse-disk-size-limit`: Maximum {{ CH }} storage size, in GB.

* `clickhouse-planned-usage-threshold`: {{ CH }} storage utilization threshold to trigger an increase during the next maintenance window, in percent. The default value is `0` (auto increasing disabled).
           
  The valid values range from `0` to `100`.
         
* `clickhouse-emergency-usage-threshold`: {{ CH }} storage utilization threshold to trigger an immediate increase, in percent. The default value is `0` (auto increasing disabled).
           
  The valid values range from `0` to `100`.

* `zookeeper-disk-size-limit`: Maximum {{ ZK }} storage size, in GB.

* `zookeeper-planned-usage-threshold`: {{ ZK }} storage utilization threshold to trigger an increase during the next maintenance window, in percent. The default value is `0` (auto increasing disabled).
           
  The valid values range from `0` to `100`.

* `zookeeper-emergency-usage-threshold`: {{ ZK }} storage utilization threshold to trigger an immediate increase, in percent. The default value is `0` (auto increasing disabled).

  The valid values range from `0` to `100`.

{% note warning %}
         
* If you specify both thresholds for {{ CH }}, `clickhouse-emergency-usage-threshold` must not be less than `clickhouse-planned-usage-threshold`.

* If you specify both thresholds for {{ ZK }}, `zookeeper-emergency-usage-threshold` must not be less than `zookeeper-planned-usage-threshold`.

* When using `clickhouse-planned-usage-threshold` and `zookeeper-planned-usage-threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).

{% endnote %}

The automatic storage size increase settings for {{ CH }} apply to all existing shards. If you add a new shard, it will use the settings of the oldest shard. These values are not saved in the {{ CH }} configuration and not displayed in the `{{ yc-mdb-ch }} cluster get` command output. 
         
To view a specific shard's info, including automatic storage size increase settings, use this command: 
         
```bash
{{ yc-mdb-ch }} shards get <shard_name> --cluster-id <cluster_ID>
```
You can get the cluster ID with the [list of clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

You can get the shard name with the [list of shards](../../../managed-clickhouse/operations/shards.md#list-shards) in the cluster.