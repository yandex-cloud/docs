* `planned-usage-threshold`: Storage utilization percentage to trigger a storage increase during the next [maintenance window](../../../managed-redis/concepts/maintenance.md#maintenance-window).

  Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

  If you set this condition, [configure](../../../managed-redis/operations/update.md#change-additional-settings) the maintenance schedule.

* `emergency-usage-threshold`: Storage utilization percentage to trigger an immediate storage increase.

  Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

  {% note warning %}

  If you specify both thresholds, `emergency-usage-threshold` must not be less than `planned-usage-threshold`.

  {% endnote %}

* `disk-size-limit`: Maximum storage size after the increase, in GB.


{% include [warn-storage-resize](warn-storage-resize.md) %}
