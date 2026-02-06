1. In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, select one or both thresholds:
    * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}**: Scheduled expansion threshold. When reached, the storage expands during the next [maintenance window](../../../managed-kafka/concepts/maintenance.md#maintenance-window).
    * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}**: Immediate expansion threshold. When reached, the storage expands immediately.
1. Specify a threshold value (as a percentage of the total storage size). If you select both thresholds, make sure the immediate expansion threshold is higher than the scheduled one.
1. Set the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.
