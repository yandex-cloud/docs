* `--disk-size-autoscaling`: [Automatic storage size increase](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
  * `planned-usage-threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`.

  * `emergency-usage-threshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
    The valid values range from `0` to `100`. 

  * `disk-size-limit`: Maximum object size after increase, in GB. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `planned-usage-threshold`, make sure to specify the `--maintenance-window` setting.
        
  * If you specify both thresholds, `emergency-usage-threshold` must be greater than `planned-usage-threshold`.

  {% endnote %}