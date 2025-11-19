{% note warning "Timeouts" %}

The {{ TF }} provider limits the time for creating and updating a {{ managed-k8s-name }} cluster to 30 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add a `timeouts` block to the cluster description, e.g.:

```hcl
resource "yandex_kubernetes_cluster" "<cluster_name>" {
  ...
  timeouts {
    create = "60m"
    update = "60m"
  }
}
```

{% endcut %}

{% endnote %}