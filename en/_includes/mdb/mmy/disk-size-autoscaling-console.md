* Select **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** and specify the **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}** percentage at which the storage will be increased in the next [maintenance window](../../../managed-mysql/concepts/maintenance.md#maintenance-window).
      
* Select **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** and specify the **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}** percentage at which the storage will be increased immediately.

* In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the storage size limit for automatic storage size increase.

{% note warning %}
      
{% include [note-storage-resize](note-storage-resize.md) %}
* If you choose to increase storage size during a maintenance window, set the [maintenance window](../../../managed-mysql/concepts/maintenance.md#maintenance-window) schedule.

{% endnote %}

[Learn more about automatic storage size increase](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling).