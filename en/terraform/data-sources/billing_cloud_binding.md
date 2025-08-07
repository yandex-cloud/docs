---
subcategory: Cloud Billing
page_title: 'Yandex: yandex_billing_cloud_binding'
description: Retrieve Yandex Billing cloud to billing account bind details.
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/billing_cloud_binding.md
---

# yandex_billing_cloud_binding (Data Source)



Use this data source to get cloud to billing account bind details. For more information, see [Cloud binding](https://yandex.cloud/docs/billing/operations/pin-cloud).

## Example usage

```terraform
//
// Get information about existing Billing Cloud Binding
//
data "yandex_billing_cloud_binding" "foo" {
  billing_account_id = "foo-ba-id"
  cloud_id           = "foo-cloud-id"
}

output "bound_cloud_id" {
  value = data.yandex_billing_cloud_binding.foo.cloud_id
}
```


## Argument Reference

The following arguments are supported:

* `billing_account_id` - (Required) ID of the billing account.
* `cloud_id` - (Required) ID of the cloud.
