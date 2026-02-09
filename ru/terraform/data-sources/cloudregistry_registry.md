---
subcategory: Cloud Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/cloudregistry_registry.md
---

# yandex_cloudregistry_registry (DataSource)

A Registry resource. For more information, see the [Registry](/docs/cloud-registry/concepts/registry) section of the documentation.

## Example usage

```terraform
//
// Get information about existing Cloud Registry.
//
data "yandex_cloudregistry_registry" "source" {
  registry_id = "some_registry_id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the registry.
- `folder_id` (String). ID of the folder that the registry belongs to.
- `id` (String). ID of the Registry resource to return. To get the registry ID use a [RegistryService.List] request.
- `kind` (**Required**)(String). Kind of the registry.
- `labels` (Map Of String). Resource labels as `key:value` pairs. Maximum of 64 per resource.
- `modified_at` (*Read-Only*) (String). Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `name` (String). Name of the registry.
- `properties` (Map Of String). Resource properties as `key:value` pairs. Maximum of 64 per resource.
- `registry_id` (String). ID of the Registry resource to return. To get the registry ID use a [RegistryService.List] request.
- `status` (*Read-Only*) (String). Output only. Status of the registry.
- `type` (**Required**)(String). Type of the registry.


