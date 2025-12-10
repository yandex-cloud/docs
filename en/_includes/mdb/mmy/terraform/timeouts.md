{% note warning "Timeouts" %}

The {{ TF }} provider sets the following timeouts for {{ mmy-name }} cluster operations:

* Creating a cluster, including by restoring it from a backup: 15 minutes.
* Updating a cluster, including the {{ MY }} version update: 60 minutes.
* Deleting a cluster: 15 minutes.

Operations exceeding the timeout are aborted.

{% cut "How do I change these limits?" %}

Add the `timeouts` section to the cluster description, such as the following:

```hcl
resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
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
