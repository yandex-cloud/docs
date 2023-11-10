To set up statistics collection, to the `config` section, add the `performance_diagnostics` section:

```hcl
resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
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

Where:

* `enabled`: Enable statistics collection, `true` or `false`.
* `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
* `statements_sampling_interval`: Statement sampling interval, from `60` to `86400` seconds.
