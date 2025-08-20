* `diskSizeAutoscaling`: Automatic storage size increase settings:
  * `plannedUsageThreshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).
           
    The possible values range from `0` to `100`.

  * `emergencyUsageThreshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).
           
    The possible values range from `0` to `100`. 

  * `diskSizeLimit`: Maximum object size after increase, in bytes. 

  {% note warning %}
  
  * When using `plannedUsageThreshold`, make sure to specify the `maintenanceWindow` setting.
        
  * If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

  {% endnote %}

    For more information about storage increase conditions, see [this section](../../../managed-postgresql/concepts/storage.md#auto-rescale). 