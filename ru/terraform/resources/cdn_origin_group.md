---
subcategory: Cloud CDN
---

# yandex_cdn_origin_group (Resource)

Allows management of [Yandex Cloud CDN Origin Groups](https://yandex.cloud/docs/cdn/concepts/origins).

## Example usage

```terraform
//
// Create a new CDN Origin Group
//
resource "yandex_cdn_origin_group" "my_group" {
  name     = "My Origin group"
  use_next = true

  origin {
    source = "ya.ru"
  }

  origin {
    source = "yandex.ru"
  }

  origin {
    source = "goo.gl"
  }

  origin {
    source = "amazon.com"
    backup = false
  }
}
```

## Arguments & Attributes Reference

- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `provider_type` (String). CDN provider is a content delivery service provider. Possible values: "ourcdn" (default) or "gcore"
- `use_next` (Bool). If the option is active (has true value), in case the origin responds with 4XX or 5XX codes, use the next origin from the list.
- `origin` [Block]. A set of available origins, an origins group must contain at least one enabled origin with fields below.
  - `backup` (Bool). Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable.
  - `enabled` (Bool). The origin is enabled and used as a source for the CDN. Default `enabled`.
  - `origin_group_id` (*Read-Only*) (String). The ID of a specific origin group.
  - `source` (**Required**)(String). IP address or Domain name of your origin and the port.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cdn_origin_group.<resource Name> <resource Id>
terraform import yandex_cdn_origin_group.my_cdn_group ...
```
