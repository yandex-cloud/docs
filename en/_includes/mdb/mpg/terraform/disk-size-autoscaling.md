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

* `disk_size_limit`: Maximum storage capacity after expansion, in GB.
* `emergency_usage_threshold`: Storage usage percentage threshold triggering an immediate storage expansion. This is an optional setting. The default value is `0` (autoscale disabled).

  Values for this setting can range from `0` to `100`.
     
* `planned_usage_threshold`: Storage usage percentage threshold triggering a storage expansion during the next maintenance window. This is an optional setting. The default value is `0` (autoscale disabled).
       
  Values for this setting can range from `0` to `100`.

For more information on storage scaling rules, see [this section](../../../../managed-postgresql/concepts/storage.md#auto-rescale).