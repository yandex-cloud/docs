* `plannedUsageThreshold`: Utilization threshold for the {{ ZK }} storage capacity, in percent, to trigger an increase during the next maintenance window. The default value is `0` (auto increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergencyUsageThreshold`: Utilization threshold for the {{ ZK }} storage capacity, in percent, to trigger an immediate increase. The default value is `0` (auto increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `diskSizeLimit`: Maximum {{ ZK }} storage size, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.
                      
* When using `plannedUsageThreshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}