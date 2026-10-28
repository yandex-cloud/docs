* `enabled`: Enable shard autoscaling, `true` or `false`. The default value is `false` (disabled).
* `min_shards`: Minimum number of shards per cluster. The default value is `1`.
* `max_shards`: Maximum number of shards per cluster. The default value is `10`.
* `cpu_threshold`: CPU utilization thresholds, as a percentage, for scaling the number of shards:
  * `down_threshold`: Downscaling threshold. The default value is `40`.
  * `up_threshold`: Upscaling threshold. The default value is `80`.
* `memory_threshold`: RAM usage thresholds, as a percentage, for scaling the number of shards:
  * `down_threshold`: Downscaling threshold. The default value is `40`.
  * `up_threshold`: Upscaling threshold. The default value is `80`.

{% include [default values](../note-autoscaling-default-params.md) %}
