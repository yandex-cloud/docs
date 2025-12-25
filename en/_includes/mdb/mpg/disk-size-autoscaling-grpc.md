* `disk_size_autoscaling`: Storage autoscaling settings:
         
  * `planned_usage_threshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (autoscale disabled).
           
    Values for this setting can range from `0` to `100`.

  * `emergency_usage_threshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (autoscale disabled).
           
    Values for this setting can range from `0` to `100`.

  * `disk_size_limit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  * When using the `planned_usage_threshold` setting, make sure to specify `maintenance_window`.
        
  * If you specify both thresholds, make sure that `emergency_usage_threshold` is greater than or equal to `planned_usage_threshold`.

  {% endnote %}

  For more information on storage scaling rules, see [this section](../../../managed-postgresql/concepts/storage.md#auto-rescale). 