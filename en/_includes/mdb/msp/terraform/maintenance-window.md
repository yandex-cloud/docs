To set up the maintenance window (for disabled clusters as well), add the `maintenance_window` section to the cluster description:

```hcl
resource "yandex_spark_cluster" "<cluster_name>" {
  ...
  maintenance_window {
    type = <maintenance_type>
    day  = <day_of_week>
    hour = <hour>
  }
  ...
}
```

{% include [Maintenance window description](../../terraform/maintenance-window-description.md) %}
