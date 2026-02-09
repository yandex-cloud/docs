---
subcategory: Resource Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/resourcemanager_folder.md
---

# yandex_resourcemanager_folder (Resource)

A Folder resource. For more information, see [Folder](/docs/resource-manager/concepts/resources-hierarchy#folder).

## Example usage

```terraform
//
// Create a new Folder.
//
resource "yandex_resourcemanager_folder" "folder1" {
  cloud_id = "my_cloud_id"
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). Cloud that the resource belongs to. If value is omitted, the default provider cloud is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). ID of the folder.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). Current status of the folder.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_resourcemanager_folder.<resource Name> <resource Id>
terraform import yandex_resourcemanager_folder.my_foldeer b1g5r**********dqmsp
```
