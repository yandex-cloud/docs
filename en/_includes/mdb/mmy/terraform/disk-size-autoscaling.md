To configure [automatic storage expansion](../../../../managed-mysql/concepts/storage.md#disk-size-autoscaling), add the `disk_size_autoscaling` section to the cluster description:

```hcl
resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
  ...
  disk_size_autoscaling {
    disk_size_limit           = <maximum_storage_size_in_GB>
    emergency_usage_threshold = <threshold_for_immediate_expansion_in_percent>
    planned_usage_threshold   = <threshold_for_scheduled_expansion_in_percent>
  }
  ...
}
```

Where:
         
* `disk_size_limit`: Maximum storage capacity after expansion, in GB. 

* `emergency_usage_threshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
  The valid values range from `0` to `100`.
  
* `planned_usage_threshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (automatic expansion disabled).
           
  The valid values range from `0` to `100`.

{% note warning %}
  
{% include [note-storage-resize](../note-storage-resize.md) %}

* When using `planned_usage_threshold`, make sure to set the `maintenance_window`.
        
* If you specify both thresholds, `emergency_usage_threshold` must be greater than `planned_usage_threshold`.

{% endnote %}