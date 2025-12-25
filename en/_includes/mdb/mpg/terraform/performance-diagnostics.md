To set up statistics collection, add the `performance_diagnostics` block to the `config` section:

```hcl
resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
  ...
  config {
    ...
    performance_diagnostics {
      enabled                      = <activate_statistics_collection>
      sessions_sampling_interval   = <session_sampling_interval>
      statements_sampling_interval = <statement_sampling_interval>
    }
    ...
  }
  ...
}
```

Where:

* `enabled`: Enable statistics collection, `true` or `false`.
* `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
* `statements_sampling_interval`: Statement sampling interval, from `60` to `86400` seconds.
