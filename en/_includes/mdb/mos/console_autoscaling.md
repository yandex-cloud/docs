* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, specify the conditions for the actions below:

    * Storage size increase during the [next maintenance window](../../../managed-opensearch/concepts/maintenance.md#maintenance-window) once the fill level exceeds the specified percentage. If you set this condition, configure the maintenance window schedule.
    * Storage size increase immediately once the fill level exceeds the specified percentage.
    
        {% note warning %}

        If you set both conditions, make sure the immediate increase threshold is higher than the scheduled one.

        {% endnote %}

* Specify maximum storage size after the increase in the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field.


{% include [warn-storage-resize](warn-storage-resize.md) %}

