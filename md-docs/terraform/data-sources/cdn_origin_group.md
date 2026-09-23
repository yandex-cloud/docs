[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud CDN > Data Sources > cdn_origin_group

# yandex_cdn_origin_group (DataSource)

Get information about a Yandex CDN Origin Group. For more information, see [the official documentation](../../cdn/concepts/origins.md).

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
- `name` (String). The resource name.
- `origin` (*Read-Only*) (Set Of Object). A set of available origins.
  - `backup` . 
  - `enabled` . 
  - `origin_group_id` . 
  - `source` . 
- `origin_group_id` (String). The ID of a specific origin group.
- `provider_type` (*Read-Only*) (String). CDN provider is a content delivery service provider
- `use_next` (*Read-Only*) (Bool). If the option is active (has true value), in case the origin responds with 4XX or 5XX codes, use the next origin from the list.