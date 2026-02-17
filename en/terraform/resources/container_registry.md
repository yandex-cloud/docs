---
subcategory: Container Registry
---

# yandex_container_registry (Resource)

A Registry resource. For more information, see the [Registry](/docs/container-registry/concepts/registry) section of the documentation.

## Example usage

```terraform
//
// Create a new Container Registry.
//
resource "yandex_container_registry" "default" {
  name      = "test-registry"
  folder_id = "test_folder_id"

  labels = {
    my-label = "my-label-value"
  }
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_container_registry.<resource Name> <resource Id>
terraform import yandex_container_registry.my_registry crps9**********k9psn
```
