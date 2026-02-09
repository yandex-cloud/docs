---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_service_account.md
---

# yandex_iam_service_account (DataSource)

Get information about a Yandex IAM service account. For more information about accounts, see [Yandex Cloud IAM accounts](https://yandex.cloud/docs/iam/concepts/#accounts).

{% note warning %}

One of `service_account_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IAM Service Account (SA).
//
data "yandex_iam_service_account" "builder" {
  service_account_id = "aje5a**********qspd3"
}

data "yandex_iam_service_account" "deployer" {
  name = "sa_name"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `name` (String). The resource name.
- `service_account_id` (String). ID of a specific service account.


