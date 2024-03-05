{% note warning "Timeouts" %}

The {{ TF }} provider sets the following timeouts for {{ mmg-name }} cluster operations:

* Creating a cluster, including by restoring one from a backup: 30 minutes.
* Editing a cluster: 60 minutes.

Operations exceeding the set timeout are interrupted.

{% cut "How do I change these limits?" %}

Add the `timeouts` block to the cluster description, for example:

```hcl
resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
  ...
  timeouts {
    create = "1h30m" # An hour and a half
    update = "2h"    # Two hours
  }
}
```

{% endcut %}

{% endnote %}
