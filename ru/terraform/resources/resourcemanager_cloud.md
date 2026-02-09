---
subcategory: Resource Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/resourcemanager_cloud.md
---

# yandex_resourcemanager_cloud (Resource)

A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).

## Example usage

```terraform
//
// Create a new Cloud.
//
resource "yandex_resourcemanager_cloud" "my_cloud" {
  organization_id = "my_organization_id"
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). ID of the cloud.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (String). 
- `labels` (Map Of String). Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (String). The resource name.
- `organization_id` (String). ID of the organization that the cloud belongs to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_resourcemanager_cloud.<resource Name> <resource Id>
terraform import yandex_resourcemanager_cloud.my_cloud b1g3a**********qc5df
```
