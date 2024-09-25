* Storage utilization percentage to trigger a storage increase in the next maintenance window, in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

    Use a value between `0` and `100`%. The default value is `0` (automatic increase is disabled).

    If you set this parameter, configure the maintenance window schedule.

* Storage utilization percentage to trigger an immediate storage increase, in the `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` parameter.

    Use a value between `0` and `100`%. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `configSpec.diskSizeAutoscaling.plannedUsageThreshold`.

* Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages, in the `configSpec.diskSizeAutoscaling.diskSizeLimit` parameter.
