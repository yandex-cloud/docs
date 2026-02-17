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

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (String). The resource name.
- `service_account_id` (String). ID of a specific service account.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_service_account.<resource Name> <resource Id>
terraform import yandex_iam_service_account.builder aje5a**********qspd3
```
