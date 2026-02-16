* `diskSizeAutoscaling`: [Storage autoscaling](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
  * `plannedUsageThreshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`.

  * `emergencyUsageThreshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`. 

  * `diskSizeLimit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `plannedUsageThreshold`, make sure to set the `maintenanceWindow`.
        
  * If you specify both thresholds, `emergencyUsageThreshold` must be greater than `plannedUsageThreshold`.

  {% endnote %}