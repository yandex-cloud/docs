To set up the [maintenance](../../../../managed-spark/concepts/maintenance.md) window that will also apply to stopped clusters, add the `maintenance_window` section to the cluster description:

```hcl
resource "yandex_spark_cluster" "<cluster_name>" {
  ...
  maintenance_window {
    type = "<maintenance_type>"
    day  = "<day_of_week>"
    hour = <sequence_number_of_hour_interval>
  }
  ...
}
```

{% include [Maintenance window description](../../terraform/maintenance-window-description.md) %}
