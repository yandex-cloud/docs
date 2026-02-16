* Select **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** and specify the **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}** percentage at which the storage will be expanded in the next [maintenance window](../../../managed-mysql/concepts/maintenance.md#maintenance-window).
      
* Select **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** and specify the **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}** percentage at which the storage will be expanded immediately.

* In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set during autoscaling.

{% note warning %}
      
{% include [note-storage-resize](note-storage-resize.md) %}
* If you have configured storage scaling during a maintenance window, set the [maintenance window](../../../managed-mysql/concepts/maintenance.md#maintenance-window) schedule.

{% endnote %}

Learn more about storage autoscaling [here](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling).