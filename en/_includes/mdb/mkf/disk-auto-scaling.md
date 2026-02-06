Where:

* `planned-usage-threshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../managed-kafka/concepts/maintenance.md#maintenance-window).

   Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

   If you set this condition, configure the maintenance schedule.

* `emergency-usage-threshold`: Storage usage percentage to trigger an immediate storage expansion.

   Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled. The value of this setting must be greater than or equal to `planned-usage-threshold`.

* `disk-size-limit`: Maximum storage size, in bytes, that can be set when storage usage reaches one of the specified thresholds.

   If you set it to `0`, automatic storage expansion will be disabled.
