* `planned-usage-threshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../managed-valkey/concepts/maintenance.md#maintenance-window).

  Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

  If you set this condition, [configure](../../../managed-valkey/operations/update.md#change-additional-settings) the maintenance schedule.

* `emergency-usage-threshold`: Storage usage percentage to trigger an immediate storage expansion.

  Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

  {% note warning %}

  If you specify both thresholds, `emergency-usage-threshold` must not be less than `planned-usage-threshold`.

  {% endnote %}

* `disk-size-limit`: Maximum storage size after expansion, in GB.


{% include [warn-storage-resize](warn-storage-resize.md) %}
