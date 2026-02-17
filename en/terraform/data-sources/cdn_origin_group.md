---
subcategory: Cloud CDN
---

# yandex_cdn_origin_group (DataSource)

Get information about a Yandex CDN Origin Group. For more information, see [the official documentation](https://yandex.cloud/docs/cdn/concepts/origins).

{% note warning %}

One of `origin_group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing CDN Origin Group
//
data "yandex_cdn_origin_group" "my_group" {
  origin_group_id = "some_instance_id"
}

output "origin_group_name" {
  value = data.yandex_cdn_origin_group.my_group.name
}
```

## Arguments & Attributes Reference

- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `origin` [Block]. A set of available origins, an origins group must contain at least one enabled origin with fields below.
  - `backup` (Bool). Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable.
  - `enabled` (Bool). The origin is enabled and used as a source for the CDN. Default `enabled`.
  - `origin_group_id` (*Read-Only*) (String). The ID of a specific origin group.
  - `source` (**Required**)(String). IP address or Domain name of your origin and the port.
- `origin_group_id` (String). The ID of a specific origin group.
- `provider_type` (String). CDN provider is a content delivery service provider. Possible values: "ourcdn" (default) or "gcore"
- `use_next` (Bool). If the option is active (has true value), in case the origin responds with 4XX or 5XX codes, use the next origin from the list.


