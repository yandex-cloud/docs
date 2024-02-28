Чтобы настроить время [технического обслуживания](../../../../managed-opensearch/concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:

```hcl
resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
  ...
  maintenance_window {
    type = <тип_технического_обслуживания>
    day  = <день_недели>
    hour = <час_дня>
  }
  ...
}
```

{% include [Maintenance window description](../../terraform/maintenance-window-description.md) %}
