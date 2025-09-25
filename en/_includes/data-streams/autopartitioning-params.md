* **{{ ui-key.yacloud.data-streams.label_shards }}**: Minimum and maximum number of [data shards](../../data-streams/concepts/glossary.md#shard).
* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-mode }}**:

    * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-scale-up }}`: Number of shards can be scaled up to the specified maximum value.
    * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-paused }}`: Number of shards will remain the same.

* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-stabilization-window }}**: Period of time in seconds after which the number of shards will start to scale when the load changes.
* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-up-utilization }}**: Load threshold percentage at which the number of shards will scale up.