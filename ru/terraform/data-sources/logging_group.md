---
subcategory: Cloud Logging
---

# yandex_logging_group (DataSource)

Get information about a Yandex Cloud Logging group. For more information, see [the official documentation](https://yandex.cloud/docs/logging/concepts/log-group).

{% note warning %}

If `group_id` is not specified `name` and `folder_id` will be used to designate Yandex Cloud Logging group.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Logging Group.
//
data "yandex_logging_group" "my_group" {
  group_id = "some_yandex_logging_group_id"
}

output "log_group_retention_period" {
  value = data.yandex_logging_group.my_group.retention_period
}
```

## Arguments & Attributes Reference

- `cloud_id` (*Read-Only*) (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `data_stream` (*Read-Only*) (String). Data Stream.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `group_id` (String). The Yandex Cloud Logging group ID.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `retention_period` (*Read-Only*) (String). Log entries retention period for the Yandex Cloud Logging group.
- `status` (*Read-Only*) (String). The Yandex Cloud Logging group status.


