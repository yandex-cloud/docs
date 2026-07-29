```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  ...
  maintenance_window = {
    type = <maintenance_type>
    day  = <day_of_week>
    hour = <sequence_number_of_hour_interval>
  }
  ...
}
```

{% include [Maintenance window description](../../mdb/terraform/maintenance-window-description.md) %}
