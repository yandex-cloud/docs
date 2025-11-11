{% note warning "Timeouts" %}

The {{ TF }} provider sets time limits for operations with {{ managed-k8s-name }} cluster and node group:

* Creating and editing a cluster: 30 minutes.
* Creating and updating a node group: 60 minutes.
* Deleting a node group: 20 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add the `timeouts` sections (the `yandex_kubernetes_cluster` and `yandex_kubernetes_node_group` resources, respectively) to the cluster and node group description.

Here is an example:

```hcl
resource "yandex_kubernetes_node_group" "<node_group_name>" {
  ...
  timeouts {
    create = "1h30m"
    update = "1h30m"
    delete = "30m"
  }
}
```

{% endcut %}

{% endnote %}

