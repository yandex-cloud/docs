* `planned_usage_threshold`: {{ ZK }} subcluster storage utilization threshold to trigger a storage expansion during the next maintenance window, in percent. The default value is `0` (automatic expansion disabled).
                      
  The valid values range from `0` to `100`.
                      
* `emergency_usage_threshold`: {{ ZK }} subcluster storage utilization threshold to trigger an immediate storage expansion, in percent. The default value is `0` (automatic expansion disabled).
                      
  The valid values range from `0` to `100`.
                      
* `disk_size_limit`: Maximum storage size for a {{ ZK }} subcluster, in bytes.
                      
{% note warning %}
                      
* If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
                      
* When using `planned_usage_threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).
                      
{% endnote %}