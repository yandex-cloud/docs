* `diskSizeAutoscaling`: [Automatic storage size increase](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
  * `plannedUsageThreshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`.

  * `emergencyUsageThreshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`. 

  * `diskSizeLimit`: Maximum object size after increase, in bytes. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `plannedUsageThreshold`, make sure to specify the `maintenanceWindow` setting.
        
  * If you specify both thresholds, `emergencyUsageThreshold` must be greater than `plannedUsageThreshold`.

  {% endnote %}