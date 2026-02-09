---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_role.md
---

# yandex_iam_role (DataSource)

Generates an [IAM](https://yandex.cloud/docs/iam/) role document that may be referenced by and applied to other Yandex Cloud Platform resources, such as the `yandex_resourcemanager_folder` resource. For more information, see [the official documentation](https://yandex.cloud/docs/iam/concepts/access-control/roles).

This data source is used to define [IAM](https://yandex.cloud/docs/iam/) roles in order to apply them to other resources. Currently, defining a role through a data source and referencing that role from another resource is the only way to apply an IAM role to a resource.

## Example usage

```terraform
//
// Get information about existing IAM Role.
//
data "yandex_iam_role" "admin" {
  binding {
    role = "admin"

    members = [
      "userAccount:user_id_1"
    ]
  }
}
```

## Arguments & Attributes Reference

- `description` (String). 
- `id` (String). 
- `role_id` (String).


