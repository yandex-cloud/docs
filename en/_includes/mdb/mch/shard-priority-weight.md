By default, each shard is assigned a weight of `100`. If you assign another weight to any of the shards, data will be distributed across the shards according to their weights.

To calculate shard priority for data distribution, the weight of each shard is divided by the total weight of all shards. For example, if one shard has a weight of `100` and another has a weight of `300`, then the first shard's priority is `1/4` and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

For more information, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed).
