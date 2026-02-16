```hcl
resource "yandex_trino_cluster" "<имя_кластера>" {
  ...
  maintenance_window = {
    type = <тип_технического_обслуживания>
    day  = <день_недели>
    hour = <час_дня>
  }
  ...
}
```

{% include [Maintenance window description](../../mdb/terraform/maintenance-window-description.md) %}
