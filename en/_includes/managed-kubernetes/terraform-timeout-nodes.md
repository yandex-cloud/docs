{% note warning "Timeouts" %}

The {{ TF }} provider sets time limits for operations with {{ managed-k8s-name }} cluster node groups:

* Creating and editing: 60 minutes.
* Deleting: 20 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add the `timeouts` section to the cluster node group description, e.g.:

```hcl
resource "yandex_kubernetes_node_group" "<node_group_name>" {
  ...
  timeouts {
    create = "1h30m"
    update = "1h30m"
    delete = "60m"
  }
}
```

{% endcut %}

{% endnote %}