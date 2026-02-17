---
subcategory: Resource Manager
---

# yandex_resourcemanager_cloud (DataSource)

Use this data source to get cloud details. For more information, see [the official documentation](https://yandex.cloud/docs/resource-manager/concepts/resources-hierarchy#cloud).

{% note warning %}

Either `cloud_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Cloud.
//
data "yandex_resourcemanager_cloud" "my_cloud" {
  name = "foo-cloud"
}

output "cloud_create_timestamp" {
  value = data.yandex_resourcemanager_cloud.my_cloud.created_at
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). ID of the cloud.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (String). 
- `name` (String). The resource name.


