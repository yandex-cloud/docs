1. Storage usage percentage to trigger storage increase in the next maintenance window, in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

   It is set between `0` and `100`%. The default value is `0` (automatic expansion is disabled).

1. Storage usage percentage to trigger immediate storage increase, in the `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` parameter.

   It is set between `0` and `100`%. The default value is `0` (automatic expansion is disabled). If the value is greater than `0`, it cannot be less than the value provided in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

1. New storage size, in bytes, set upon reaching one of the specified usage percentages, in the `configSpec.diskSizeAutoscaling.diskSizeLimit` parameter.
