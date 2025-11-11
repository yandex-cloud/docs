{% note warning "Timeouts" %}

The {{ TF }} provider limits the execution time for operations with {{ alb-name }} HTTP routers and virtual hosts to 10 minutes.

Operations in excess of this time will be interrupted.

{% cut "How do I modify these limits?" %}

Add the `timeouts` section to the descriptions of the HTTP router and virtual host (the `yandex_alb_http_router` and `yandex_alb_virtual_host` resources, respectively).

Here is an example:

```hcl
resource "yandex_alb_http_router" "<router_name>" {
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