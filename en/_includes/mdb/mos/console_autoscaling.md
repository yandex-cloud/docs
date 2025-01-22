* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions to:

    * Increase the storage size during the [next maintenance window](../../../managed-opensearch/concepts/maintenance.md#maintenance-window) if the storage is more than the specified percent (%) full.
    * Increase the storage size right away if the storage is more than the specified percent (%) full.

    You can set both conditions, but the threshold for immediate increase must be higher than that for increase during the maintenance window.

* In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set when increasing the storage size automatically.

    {% include [storage-resize-steps](storage-resize-steps.md) %}

    
    {% include [warn-storage-resize](warn-storage-resize.md) %}


If you have set up the storage size to increase within the maintenance window, set up a schedule for the maintenance window.
