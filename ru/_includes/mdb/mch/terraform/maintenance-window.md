Чтобы настроить время [технического обслуживания](../../../../managed-clickhouse/concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
  ...
  maintenance_window {
    type = <тип технического обслуживания: ANYTIME или WEEKLY>
    day  = <день недели для типа WEEKLY>
    hour = <час дня для типа WEEKLY>
  }
  ...
}
```

{% include [maintenance-window-description](../../terraform/maintenance-window-description.md) %}
