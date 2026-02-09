---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/logging_group.md
---

# yandex_logging_group (Resource)



## Example usage

```terraform
//
// Create a new Logging Group.
//
resource "yandex_logging_group" "group1" {
  name      = "test-logging-group"
  folder_id = data.yandex_resourcemanager_folder.test_folder.id
}
```

## Arguments & Attributes Reference

- `cloud_id` (*Read-Only*) (String). The `Cloud ID` which resource belongs to. If it is not provided, the default provider `cloud-id` is used.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `data_stream` (*Read-Only*) (String). Data Stream.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (String). ID of the log group to return. To get a log group ID make a [LogGroupService.List] request.
- `name` (String). The resource name.
- `retention_period` (*Read-Only*) (String). Log entries retention period for the Yandex Cloud Logging group.
- `status` (*Read-Only*) (String). The Yandex Cloud Logging group status.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_logging_group.<resource Name> <resource Id>
terraform import yandex_logging_group.group1 ...
```
