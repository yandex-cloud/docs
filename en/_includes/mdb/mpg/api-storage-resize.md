1. Storage usage threshold value at which the storage size will be increased during the next maintenance window, in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

    It is set between `0` and `100`%. The default value is `0` (the threshold is disabled).

1. Storage usage threshold value at which the storage size will be increased immediately, in the `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` parameter.

    It is set between `0` and `100`%. The default value is `0` (the threshold is disabled). If the value is greater than `0`, it cannot be less than the value provided in the `configSpec.diskSizeAutoscaling.plannedUsageThreshold` parameter.

1. New storage size, in bytes, to be set upon reaching one of the specified thresholds, in the `configSpec.diskSizeAutoscaling.diskSizeLimit` parameter.
