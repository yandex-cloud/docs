To set up statistics collection, to the `config` section, add the `performance_diagnostics` section:

```hcl
resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
  ...
  config {
    ...
    performance_diagnostics {
      enabled = <enables statistics collection: true or false>
      sessions_sampling_interval  = <sessions sampling interval>
      statements_sampling_interval = <statements sampling interval>
    }
    ...
  }
  ...
}
```

Acceptable parameter values:

- `sessions_sampling_interval`: From `1` to `86400` seconds.
- `statements_sampling_interval`: From `60` to `86400` seconds.
