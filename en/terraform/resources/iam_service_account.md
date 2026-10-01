---
subcategory: Identity and Access Management
---

# yandex_iam_service_account (Resource)

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

## Example usage

```terraform
//
// Create a new IAM Service Account (SA).
//
resource "yandex_iam_service_account" "builder" {
  name        = "vmmanager"
  description = "service account to manage VMs"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the service account. 0-256 characters long.
- `expires_at` (String). Timestamp when the service account expires.
- `folder_id` (String). ID of the folder that the service account belongs to.
- `id` (String). ID of the ServiceAccount resource to return.
 To get the service account ID, use a [ServiceAccountService.List] request.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (**Required**)(String). Name of the service account.
 The name is unique within the cloud. 3-63 characters long.
- `service_account_id` (String). ID of the ServiceAccount resource to return.
 To get the service account ID, use a [ServiceAccountService.List] request.
- `status` (*Read-Only*) (String). Current status of the service account.
 Determines whether the service account can authenticate and access the system.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_service_account.<resource Name> <resource Id>
terraform import yandex_iam_service_account.builder aje5a**********qspd3
```
