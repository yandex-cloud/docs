* `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next [maintenance window](../../../../managed-kafka/concepts/maintenance.md#maintenance-window).

    Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

    If you set this parameter, configure the maintenance window schedule.

* `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

  Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `planned_usage_threshold`.

* `disk_size_limit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.
