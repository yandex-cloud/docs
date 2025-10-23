* `disk_size_autoscaling`: [Automatic storage size increase](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
         
  * `planned_usage_threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`.

  * `emergency_usage_threshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`.

  * `disk_size_limit`: Maximum object size after increase, in bytes. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `planned_usage_threshold`, make sure to specify the `maintenance_window` setting.
        
  * If you specify both thresholds, `emergency_usage_threshold` must be greater than `planned_usage_threshold`.

  {% endnote %}