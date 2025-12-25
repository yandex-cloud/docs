* `diskSizeAutoscaling`: Storage autoscaling setting:
  * `plannedUsageThreshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (autoscale disabled).
           
    Values for this setting can range from `0` to `100`.

  * `emergencyUsageThreshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (autoscale disabled).
           
    Values for this setting can range from `0` to `100`. 

  * `diskSizeLimit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  * When using the `plannedUsageThreshold` setting, make sure to specify `maintenanceWindow`.
        
  * If you specify both thresholds, make sure `emergencyUsageThreshold` is greater than or equal to `plannedUsageThreshold`.

  {% endnote %}

    For more information about storage scaling rules, see [this section](../../../managed-postgresql/concepts/storage.md#auto-rescale). 