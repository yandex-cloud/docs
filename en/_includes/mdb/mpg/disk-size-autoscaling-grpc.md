* `disk_size_autoscaling`: Automatic storage size increase settings:
         
  * `planned_usage_threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).
           
    The possible values range from `0` to `100`.

  * `emergency_usage_threshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).
           
    The possible values range from `0` to `100`.

  * `disk_size_limit`: Maximum object size after an increase, in bytes. 

  {% note warning %}
  
  * When using `planned_usage_threshold`, make sure to specify the `maintenance_window` setting.
        
  * If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

  {% endnote %}

  For more information about storage increase conditions, see [this section](../../../managed-postgresql/concepts/storage.md#auto-rescale). 