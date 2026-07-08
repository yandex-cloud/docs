* `disk_size_autoscaling`: Automatic storage expansion settings:
         
  * `planned_usage_threshold`: Storage utilization threshold to trigger a storage expansion during the next maintenance window, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.
           
    The valid values range from `0` to `100`.

  * `emergency_usage_threshold`: Storage utilization threshold to trigger an immediate expansion, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.
           
    The valid values range from `0` to `100`.

  * `disk_size_limit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  * When using the `planned_usage_threshold` setting, make sure to specify `maintenance_window`.
        
  * If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

  {% endnote %}

  Learn more about the storage expansion criteria [here](../../../managed-postgresql/concepts/storage.md#auto-rescale).