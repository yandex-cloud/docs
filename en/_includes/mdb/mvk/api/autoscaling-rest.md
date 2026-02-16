* `diskSizeAutoscaling`: Automatic storage expansion settings:

  * `plannedUsageThreshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../../managed-valkey/concepts/maintenance.md#maintenance-window).

    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

    If you set this condition, configure the `maintenanceWindow`.

  * `emergencyUsageThreshold`: Storage usage percentage to trigger an immediate storage expansion.

    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

    {% note warning %}

    If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

    {% endnote %}

  * `diskSizeLimit`: Maximum storage size after expansion, in bytes.

  
  {% include [warn-storage-resize](../warn-storage-resize.md) %}


  