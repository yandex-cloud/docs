---
subcategory: Container Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/container_repository.md
---

# yandex_container_repository (Resource)

A Repository resource. For more information, see [Repository](/docs/container-registry/concepts/repository).

## Example usage

```terraform
//
// Create a new Container Registry and new Repository with it.
//
resource "yandex_container_registry" "my-registry" {
  name = "test-registry"
}

resource "yandex_container_repository" "my-repository" {
  name = "${yandex_container_registry.my-registry.id}/test-repository"
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `name` (String). A name of the repository. The name of the repository should start with id of a container registry and match the name of the images that will be pushed in the repository.
- `repository_id` (String). The ID of a specific repository.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_container_repository.<resource Name> <repository_id>
terraform import yandex_container_repository.my-repository crps9**********k9psn
```
