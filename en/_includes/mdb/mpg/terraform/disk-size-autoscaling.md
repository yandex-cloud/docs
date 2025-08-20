```hcl
  resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
    ...
    config {
      ...
      disk_size_autoscaling {
        disk_size_limit           = <maximum_storage_size_GiB>
        emergency_usage_threshold = <threshold_for_immediate_increase_in_percent>
        planned_usage_threshold   = <threshold_for_scheduled_increase_in_percent>
      }
      ...
    }
    ...
  }
```
Where:

* `disk_size_limit`: Maximum object size after increase, in gibibytes.
* `emergency_usage_threshold`: Storage utilization threshold to trigger a storage increase right away, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).

  The possible values range from `0` to `100`.
     
* `planned_usage_threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default value is `0` (automatic increase is disabled).
       
  The possible values range from `0` to `100`.

For more information about storage increase conditions, see [this section](../../../../managed-postgresql/concepts/storage.md#auto-rescale).