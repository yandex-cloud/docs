{% note warning "Time limits" %}

A {{ TF }} provider sets the timeout for {{ mch-name }} cluster operations:

* Creating a cluster, including by restoring one from a backup: 60 minutes.
* Editing a cluster: 90 minutes.
* Deleting a cluster: 30 minutes.

Operations exceeding the set timeout are interrupted.

{% cut "How do I change these limits?" %}

Add the `timeouts` block to the cluster description, for example:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
  ...
  timeouts {
    create = "1h30m" # 1 hour 30 minutes
    update = "2h"    # 2 hours
    delete = "30m"   # 30 minutes
  }
}
```

{% endcut %}

{% endnote %}
