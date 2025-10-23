To configure [automatic increase of storage size](../../../../managed-mysql/concepts/storage.md#disk-size-autoscaling), add the `disk_size_autoscaling` section to the cluster description:

```hcl
resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
  ...
  disk_size_autoscaling {
    disk_size_limit           = <maximum_storage_size_in_GB>
    emergency_usage_threshold = <threshold_for_immediate_increase_in_percent>
    planned_usage_threshold   = <threshold_for_scheduled_increase_in_percent>
  }
  ...
}
```

Where:
         
* `disk_size_limit`: Maximum object size after increase, in gibibytes. 

* `emergency_usage_threshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
  The valid values range from `0` to `100`.
  
* `planned_usage_threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default setting is `0` (automatic increase disabled).
           
  The valid values range from `0` to `100`.

{% note warning %}
  
{% include [note-storage-resize](../note-storage-resize.md) %}

* When using `planned_usage_threshold`, make sure to set the `maintenance_window`.
        
* If you specify both thresholds, `emergency_usage_threshold` must be greater than `planned_usage_threshold`.

{% endnote %}