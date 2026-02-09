---
subcategory: Billing
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/billing_cloud_binding.md
---

# yandex_billing_cloud_binding (DataSource)



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

## Arguments & Attributes Reference

- `billing_account_id` (**Required**)(String). The ID of billing account to bind cloud to.
- `cloud_id` (**Required**)(String). Service Instance ID.
- `id` (*Read-Only*) (String). The resource identifier.


