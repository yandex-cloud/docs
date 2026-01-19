* `diskSizeAutoscaling`: Automatic storage size increase settings:

  * `plannedUsageThreshold`: Storage utilization percentage to trigger a storage increase during the next [maintenance window](../../../../managed-valkey/concepts/maintenance.md#maintenance-window).

    Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

    If you set this condition, configure the maintenance schedule with the help of `maintenanceWindow`.

  * `emergencyUsageThreshold`: Storage utilization percentage to trigger an immediate storage increase.

    Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

    {% note warning %}

    If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

    {% endnote %}

  * `diskSizeLimit`: Maximum storage size after the increase, in bytes.

  
  {% include [warn-storage-resize](../warn-storage-resize.md) %}


  