* `planned_usage_threshold`: Utilization threshold for the {{ ZK }} storage capacity, in percent, to trigger an increase during the next maintenance window. The default value is `0` (auto increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergency_usage_threshold`: Utilization threshold for the {{ ZK }} storage capacity, in percent, to trigger an immediate increase. The default value is `0` (auto increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `disk_size_limit`: Maximum {{ ZK }} storage size, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
                      
* When using `planned_usage_threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}