{% note warning "Timeouts" %}

The {{ TF }} provider sets the following timeouts for {{ mch-name }} cluster operations:

* Creating a cluster, including by restoring from a backup: 60 minutes.
* Updating a cluster: 90 minutes.
* Deleting a cluster: 30 minutes.

Operations exceeding the timeout are aborted.

{% cut "How to change these limits" %}

Add the `timeouts` section to your cluster description, such as the following:

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
  ...
  timeouts = {
    create = "1h30m" # 1 hour 30 minutes
    update = "2h"    # 2 hours
    delete = "30m"   # 30 minutes
  }
}
```

{% endcut %}

{% endnote %}
