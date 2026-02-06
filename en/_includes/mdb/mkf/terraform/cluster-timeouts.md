{% note warning "Timeouts" %}

The {{ TF }} provider limits the time for all operations with the {{ mkf-name }} cluster to 60 minutes.

Operations exceeding the timeout are aborted.

{% cut "How do I change these limits?" %}

Add the `timeouts` section to your cluster description, such as the following:

```hcl
resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
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
