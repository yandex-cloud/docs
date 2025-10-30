* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, specify the conditions for the actions below:

    * Storage size increase during the [next maintenance window](../../../managed-redis/concepts/maintenance.md#maintenance-window) once the fill level exceeds the specified percentage. If you set this condition, configure the maintenance schedule.

    * Storage size increase immediately once the fill level exceeds the specified percentage.

        {% note warning %}

        If you set both conditions, make sure the immediate increase threshold is higher than the scheduled one.

        {% endnote %}

* In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set during automatic scaling.


{% include [warn-storage-resize](warn-storage-resize.md) %}


