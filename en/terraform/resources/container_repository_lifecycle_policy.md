---
subcategory: Container Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/container_repository_lifecycle_policy.md
---

# yandex_container_repository_lifecycle_policy (Resource)

Creates a new container repository lifecycle policy. For more information, see [the official documentation](https://yandex.cloud/docs/container-registry/concepts/lifecycle-policy).

## Example usage

```terraform
//
// Create new Container Repository and Container Repository Lifecycle Policy for it.
//
resource "yandex_container_registry" "my_registry" {
  name = "test-registry"
}

resource "yandex_container_repository" "my_repository" {
  name = "${yandex_container_registry.my_registry.id}/test-repository"
}

resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
  name          = "test-lifecycle-policy-name"
  status        = "active"
  repository_id = yandex_container_repository.my_repository.id

  rule {
    description  = "my description"
    untagged     = true
    tag_regexp   = ".*"
    retained_top = 1
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (String). 
- `name` (String). The resource name.
- `repository_id` (**Required**)(String). The ID of the repository that the resource belongs to.
- `status` (**Required**)(String). The status of lifecycle policy. Must be `active` or `disabled`.
- `rule` [Block]. Repository rules.
  - `description` (String). Description of the lifecycle policy.
  - `expire_period` (String). The period of time that must pass after creating a image for it to suit the automatic deletion criteria. It must be a multiple of 24 hours.
  - `retained_top` (Number). The number of images to be retained even if the `expire_period` already expired.
  - `tag_regexp` (String). Tag to specify a filter as a regular expression. For example `.*` - all images with tags.
  - `untagged` (Bool). If enabled, rules apply to untagged Docker images.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_container_repository_lifecycle_policy.<resource Name> <resource Id>
terraform import yandex_container_repository_lifecycle_policy.my_lifecycle_policy ...
```
