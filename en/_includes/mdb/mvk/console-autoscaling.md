* In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions for the actions below:

    * Storage expansion during the [next maintenance window](../../../managed-valkey/concepts/maintenance.md#maintenance-window) if and when the specified storage space utilization percentage is exceeded. If you set this condition, configure the maintenance schedule.

    * Storage expansion immediately if and when the specified storage space utilization percentage is exceeded.

        {% note warning %}

        If you set both conditions, make sure the immediate expansion threshold is higher than the scheduled one.

        {% endnote %}

* In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set during autoscaling.


{% include [warn-storage-resize](warn-storage-resize.md) %}


