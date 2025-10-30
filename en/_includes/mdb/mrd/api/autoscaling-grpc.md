* `disk_size_autoscaling`: Automatic storage size increase settings:

  * `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next [maintenance window](../../../../managed-redis/concepts/maintenance.md#maintenance-window).

    Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

    If you set this condition, configure the maintenance schedule with the help of `maintenance_window`.

  * `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

    Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

    {% note warning %}

    If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

    {% endnote %}

  * `disk_size_limit`: Maximum storage size after the increase, in bytes.
  
  
  {% include [warn-storage-resize](../warn-storage-resize.md) %}
