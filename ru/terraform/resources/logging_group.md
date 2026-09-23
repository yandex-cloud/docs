---
subcategory: Cloud Logging
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

- `cloud_id` (String). Log group cloud ID.
- `created_at` (*Read-Only*) (String). Log group creation time.
- `data_stream` (String). Data stream name
- `description` (String). Log group description.
- `folder_id` (String). Log group folder ID.
- `id` (String). ID of the log group to return.
 To get a log group ID make a [LogGroupService.List] request.
- `labels` (Map Of String). Log group labels.
- `log_group_id` (String). ID of the log group to return.
 To get a log group ID make a [LogGroupService.List] request.
- `name` (String). Log group name.
- `retention_period` (String). Log group entry retention period.
 Entries will be present in group during this period.
- `status` (*Read-Only*) (String). Status of the log group.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_logging_group.<resource Name> <resource Id>
terraform import yandex_logging_group.group1 ...
```
