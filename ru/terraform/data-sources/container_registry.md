---
subcategory: Container Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/container_registry.md
---

# yandex_container_registry (DataSource)

Get information about a Yandex Container Registry. For more information, see [the official documentation](https://yandex.cloud/docs/container-registry/concepts/registry)

## Example usage

```terraform
//
// Get information about existing Container Registry.
//
data "yandex_container_registry" "source" {
  registry_id = "some_registry_id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `registry_id` (String). The ID of a specific registry.
- `status` (*Read-Only*) (String). Status of the registry.


