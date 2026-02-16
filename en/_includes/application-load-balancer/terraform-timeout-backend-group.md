{% note warning "Timeouts" %}

The {{ TF }} provider limits operations with {{ alb-name }} backend groups to 10 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add a `timeouts` section to the backend group description:

```hcl
resource "yandex_alb_backend_group" "<backend_group_name>" {
  ...
  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}
```

{% endcut %}

{% endnote %}