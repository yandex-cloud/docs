---
subcategory: Cloud Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/cloudregistry_registry_ip_permission.md
---

# yandex_cloudregistry_registry_ip_permission (Resource)

Creates a new Cloud Registry IP Permission. For more information, see [the official documentation](https://yandex.cloud/docs/cloud-registry/operations/registry/registry-access)

## Example usage

```terraform
//
// Create a new Cloud Registry and new IP Permissions for it.
//
resource "yandex_cloudregistry_registry" "my_registry" {
  name      = "test-registry"
  folder_id = "test_folder_id"

  labels = {
    my-label = "my-label-value"
  }
  kind      = "DOCKER"
  type      = "LOCAL"

  description = "Some desctiption"
}

resource "yandex_cloudregistry_registry_ip_permission" "my_ip_permission" {
  registry_id = yandex_cloudregistry_registry.my_registry.id
  push        = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
  pull        = ["10.1.0.0/16", "10.5.0/16"]
}
```

## Arguments & Attributes Reference

- `id` (*Read-Only*) (String). The ID of IP permission.
- `pull` (Set Of String). List of configured CIDRs from which `pull` operations are allowed.
- `push` (Set Of String). List of configured CIDRs from which `push` operations are allowed.
- `registry_id` (**Required**)(String). The ID of the registry that IP restrictions are applied to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cloudregistry_registry_ip_permission.<resource Name> <registry_id>
terraform import yandex_cloudregistry_registry_ip_permission.my_ip_permission crps9**********k9psn
```
