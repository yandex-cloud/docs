* `--disk-size-autoscaling`: [Storage autoscaling](../../../managed-mysql/concepts/storage.md#disk-size-autoscaling) settings:
  * `planned-usage-threshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`.

  * `emergency-usage-threshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
    The valid values range from `0` to `100`. 

  * `disk-size-limit`: Maximum storage capacity after expansion, in GB. 

  {% note warning %}
  
  {% include [note-storage-resize](note-storage-resize.md) %}
  * When using `planned-usage-threshold`, make sure to set the `--maintenance-window`.
        
  * If you specify both thresholds, `emergency-usage-threshold` must be greater than `planned-usage-threshold`.

  {% endnote %}