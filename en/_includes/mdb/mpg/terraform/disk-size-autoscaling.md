```hcl
  resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
    ...
    config {
      ...
      disk_size_autoscaling {
        disk_size_limit           = <maximum_storage_size_GiB>
        emergency_usage_threshold = <immediate_expansion_threshold_in_percent>
        planned_usage_threshold   = <scheduled_expansion_threshold_in_percent>
      }
      ...
    }
    ...
  }
```
Where:

* `disk_size_limit`: Maximum storage capacity after expansion, in GB.
* `emergency_usage_threshold`: Storage utilization threshold to trigger an immediate expansion, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.

  The valid values range from `0` to `100`.
     
* `planned_usage_threshold`: Storage utilization threshold to trigger a storage increase during the next maintenance window, in percent. This is an optional setting. The default value is `0`, i.e., automatic expansion is disabled.
       
  The valid values range from `0` to `100`.

Learn more about the storage expansion criteria [here](../../../../managed-postgresql/concepts/storage.md#auto-rescale).