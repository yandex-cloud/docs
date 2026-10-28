* `enabled`: Enable shard autoscaling, `true` or `false`. The default value is `false` (disabled).
* `minShards`: Minimum number of shards per cluster. The minimum and default value is `1`.
* `maxShards`: Maximum number of shards per cluster. The maximum and default value is `10`.
* `cpuThreshold`: CPU utilization thresholds, as a percentage, for scaling the number of shards:
  * `downThreshold`: Downscaling threshold.
  * `upThreshold`: Upscaling threshold.
* `memoryThreshold`: RAM usage thresholds, as a percentage, for scaling the number of shards:
  * `downThreshold`: Downscaling threshold.
  * `upThreshold`: Upscaling threshold.

{% include [default values](../note-autoscaling-default-params.md) %}
