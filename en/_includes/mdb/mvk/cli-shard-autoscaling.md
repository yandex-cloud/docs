* `enabled`: Enable shard autoscaling, `true` or `false`. The default value is `false` (disabled).
* `min-shards`: Minimum number of shards per cluster.
* `max-shards`: Maximum number of shards per cluster.
* `cpu-down-threshold`: CPU downscaling threshold as a percentage. The default value is `40`.
* `cpu-up-threshold`: CPU upscaling threshold as a percentage. The default value is `80`.
* `memory-down-threshold`: Memory downscaling threshold as a percentage. The default value is `40`.
* `memory-up-threshold`: Memory upscaling threshold as a percentage. The default value is `80`.

{% include [default values](note-autoscaling-default-params.md) %}
