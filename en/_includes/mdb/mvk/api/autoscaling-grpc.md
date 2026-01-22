* `disk_size_autoscaling`: Automatic storage expansion settings:

  * `planned_usage_threshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../../managed-valkey/concepts/maintenance.md#maintenance-window).

    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

    If you set this condition, configure the `maintenance_window`.

  * `emergency_usage_threshold`: Storage usage percentage to trigger an immediate storage expansion.

    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

    {% note warning %}

    If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

    {% endnote %}

  * `disk_size_limit`: Maximum storage size after expansion, in bytes.
  
  
  {% include [warn-storage-resize](../warn-storage-resize.md) %}
