---
subcategory: Resource Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/resourcemanager_folder.md
---

# yandex_resourcemanager_folder (DataSource)

Use this data source to get information about a Yandex Resource Manager Folder. For more information, see [the official documentation](https://yandex.cloud/docs/resource-manager/concepts/resources-hierarchy#folder).

{% note warning %}

Either `folder_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Folder.
//
data "yandex_resourcemanager_folder" "my_folder_1" {
  folder_id = "folder_id_number_1"
}

# Get folder by name in specific cloud
data "yandex_resourcemanager_folder" "my_folder_2" {
  name     = "folder_name"
  cloud_id = "some_cloud_id"
}

output "my_folder_1_name" {
  value = data.yandex_resourcemanager_folder.my_folder_1.name
}

output "my_folder_2_cloud_id" {
  value = data.yandex_resourcemanager_folder.my_folder_2.cloud_id
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


