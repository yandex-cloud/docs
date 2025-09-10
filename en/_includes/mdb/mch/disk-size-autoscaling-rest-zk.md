* `plannedUsageThreshold`: {{ ZK }} subcluster storage utilization threshold for storage to be increased during the next maintenance window, in percent. The default value is `0` (automatic increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergencyUsageThreshold`: {{ ZK }} subcluster storage utilization threshold for storage to be increased right away, in percent. The default value is `0` (automatic increase disabled).
                      
  The valid values range from `0` to `100`.
                      
* `diskSizeLimit`: Maximum storage size for a {{ ZK }} subcluster, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.
                      
* When using `plannedUsageThreshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}