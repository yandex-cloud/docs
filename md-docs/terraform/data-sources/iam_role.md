[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Identity and Access Management > Data Sources > iam_role

# yandex_iam_role (DataSource)

Generates an [IAM](../../iam/index.md) role document that may be referenced by and applied to other Yandex Cloud Platform resources, such as the `yandex_resourcemanager_folder` resource. For more information, see [the official documentation](../../iam/concepts/access-control/roles.md).

This data source is used to define [IAM](../../iam/index.md) roles in order to apply them to other resources. Currently, defining a role through a data source and referencing that role from another resource is the only way to apply an IAM role to a resource.

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