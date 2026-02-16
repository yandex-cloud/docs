* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, select one or both thresholds:
  * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}**: Scheduled expansion threshold. When reached, the storage expands during the next [maintenance window](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window).
    
    For a scheduled expansion, you need to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md#maintenance-window) schedule.

  * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}**: Immediate expansion threshold. When reached, the storage expands immediately.
* Specify a threshold value (as a percentage of the total storage size). If you select both thresholds, make sure the immediate expansion threshold is not less than the scheduled one.
* Set **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.