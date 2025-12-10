* `disk_size_autoscaling`: [Storage autoscaling](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
         
  * `planned_usage_threshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`.

  * `emergency_usage_threshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`.

  * `disk_size_limit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `planned_usage_threshold`, make sure to set the `maintenance_window`.
        
  * If you specify both thresholds, `emergency_usage_threshold` must be greater than `planned_usage_threshold`.

  {% endnote %}