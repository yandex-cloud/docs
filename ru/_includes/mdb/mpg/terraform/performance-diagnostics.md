Чтобы настроить сбор статистики, добавьте в блок `config` блок `performance_diagnostics`:

```hcl
resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
  ...
  config {
    ...
    performance_diagnostics {
      enabled                      = <активация_сбора_статистики>
      sessions_sampling_interval   = <интервал_сбора_сессий>
      statements_sampling_interval = <интервала_сбора_запросов>
    }
    ...
  }
  ...
}
```

Где:

* `enabled` — активация сбора статистики: `true` или `false`.
* `sessions_sampling_interval` — интервал сбора сессий от `1` до `86400` секунд.
* `statements_sampling_interval` — интервала сбора запросов от `60` до `86400` секунд.
