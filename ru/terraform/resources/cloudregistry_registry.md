---
subcategory: Cloud Registry
---

# yandex_cloudregistry_registry (Resource)

A Registry resource. For more information, see the [Registry](/docs/cloud-registry/concepts/registry) section of the documentation.

## Example usage

```terraform
//
// Create a new Cloud Registry.
//
resource "yandex_cloudregistry_registry" "default" {
  name      = "test-registry"
  folder_id = "test_folder_id"

  labels = {
    my-label = "my-label-value"
  }
  kind      = "DOCKER"
  type      = "LOCAL"

  description = "Some desctiption"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the registry.
- `folder_id` (String). ID of the folder that the registry belongs to.
- `id` (String). ID of the Registry resource to return.

 To get the registry ID use a [RegistryService.List] request.
- `kind` (**Required**)(String). Kind of the registry.
- `labels` (Map Of String). Resource labels as `key:value` pairs. Maximum of 64 per resource.
- `modified_at` (*Read-Only*) (String). Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `name` (String). Name of the registry.
- `properties` (Map Of String). Resource properties as `key:value` pairs. Maximum of 64 per resource.
- `registry_id` (String). ID of the Registry resource to return.

 To get the registry ID use a [RegistryService.List] request.
- `status` (*Read-Only*) (String). Output only. Status of the registry.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `type` (**Required**)(String). Type of the registry.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cloudregistry_registry.<resource Name> <resource Id>
terraform import yandex_cloudregistry_registry.my_registry crps9**********k9psn
```
