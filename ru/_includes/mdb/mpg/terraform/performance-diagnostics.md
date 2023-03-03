Чтобы настроить сбор статистики, добавьте в блок `config` блок `performance_diagnostics`:

```hcl
resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
  ...
  config {
    ...
    performance_diagnostics {
      enabled                      = <активация сбора статистики: true или false>
      sessions_sampling_interval   = <интервал сбора сессий>
      statements_sampling_interval = <интервала сбора запросов>
    }
    ...
  }
  ...
}
```

Допустимые значения параметров:

- `sessions_sampling_interval` — от `1` до `86400` секунд.
- `statements_sampling_interval` — от `60` до `86400` секунд.
