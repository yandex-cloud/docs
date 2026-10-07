By default, each external shard is assigned a weight of `100`. If some shards (either external or the cluster's own) in the group have weights different from `100`, the data within the shard group will be distributed between the shards according to their weights.

To calculate the shard's priority for data distribution within the group, the weight of each shard should be divided by the total weight of all shards in the group. For example, if an external shard has a weight of `100` and a cluster shard has a weight of `300`, then the first shard's priority is `1/4`, and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

For more information, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed).
