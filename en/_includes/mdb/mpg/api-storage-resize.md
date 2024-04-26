1. Storage utilization percentage to trigger a storage increase in the next [maintenance window](../../../managed-postgresql/concepts/maintenance.md#maintenance-window), in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

   Use a value between `0` and `100`%. The default value is `0` (automatic expansion is disabled).

1. Storage utilization percentage to trigger an immediate storage increase, in the `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` parameter.

   Use a value between `0` and `100`%. The default value is `0` (automatic expansion is disabled). If the value is greater than `0`, it cannot be less than the value provided in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

1. Maximum storage size, in bytes, that can be set upon reaching one of the specified utilization percentages, in the `configSpec.diskSizeAutoscaling.diskSizeLimit` parameter.
