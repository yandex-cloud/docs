{% note warning "Timeouts" %}

The {{ TF }} provider limits operations with {{ alb-name }} target groups to 10 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add the `timeouts` section to the target group description, e.g.:

```hcl
resource "yandex_alb_target_group" "<target_group_name>" {
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