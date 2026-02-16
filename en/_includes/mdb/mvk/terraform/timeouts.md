{% note warning "Timeouts" %}

The {{ TF }} provider sets the following timeouts for {{ mrd-name }} cluster operations:

* Creating a cluster, including by restoring it from a backup: 15 minutes.
* Editing a cluster: 60 minutes.
* Deleting a cluster: 15 minutes.

Operations exceeding the timeout are aborted.

{% cut "How do I change these limits?" %}

Add the `timeouts` section to your cluster description, such as the following:

```hcl
resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
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
