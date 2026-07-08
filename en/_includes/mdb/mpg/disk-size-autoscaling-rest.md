* `diskSizeAutoscaling`: Automatic storage expansion settings:
  * `plannedUsageThreshold`: Storage utilization threshold to trigger a storage expansion during the next maintenance window, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.
           
    The valid values range from `0` to `100`.

  * `emergencyUsageThreshold`: Storage utilization threshold to trigger an immediate expansion, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.
           
    The valid values range from `0` to `100`. 

  * `diskSizeLimit`: Maximum storage capacity after expansion, in bytes. 

  {% note warning %}
  
  * When using the `plannedUsageThreshold` setting, make sure to specify `maintenanceWindow`.
        
  * If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

  {% endnote %}

    Learn more about the storage expansion criteria [here](../../../managed-postgresql/concepts/storage.md#auto-rescale).