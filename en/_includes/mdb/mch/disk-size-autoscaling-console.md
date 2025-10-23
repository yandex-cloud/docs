* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, select one or both thresholds:
  * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}**: Scheduled increase threshold. When reached, the storage size increases during the next [maintenance window](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window).
    
    For scheduled increase, you need to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window) schedule.

  * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}**: Immediate increase threshold. When reached, the storage size increases immediately.
* Specify a threshold value (as a percentage of the total storage size). If you select both thresholds, make sure the immediate increase threshold is at last as high as the scheduled one.
* Set **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.