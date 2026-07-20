[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Resource Manager > Resources > resourcemanager_folder_iam_binding

# yandex_resourcemanager_folder_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `folder`.

{% note warning %}

**Warning:** This resource is authoritative for the given `role` on the target `folder` and manages the complete set of its members. When you change or delete `yandex_resourcemanager_folder_iam_binding`, the `role` may be removed from other subjects on the `folder` as well — including subjects granted outside of this resource (via the corresponding `*_iam_member` resource, the management console, CLI or API). Those subjects are not tracked in the Terraform state, so a plain `terraform plan` does not list them. Be careful.

{% endnote %}


## Example usage

```terraform
//
// Create a new IAM Binding for existing Folder.
//
data "yandex_resourcemanager_folder" "project1" {
  folder_id = "some_folder_id"
}

resource "yandex_resourcemanager_folder_iam_binding" "admin" {
  folder_id = data.yandex_resourcemanager_folder.project1.id

  role = "editor"

  members = [
    "userAccount:some_user_id",
  ]
}
```

## Arguments & Attributes Reference

- `folder_id` (**Required**)(String). The ID of the `folder` to attach the policy to.
- `id` (String). The ID of this resource.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
 * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
 * **serviceAccount:{service_account_id}**: A unique service account ID.
 * **federatedUser:{federated_user_id}**: A unique federated user ID.
 * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID.
 * **group:{group_id}**: A unique group ID.
 * **system:group:federation:{federation_id}:users**: All users in federation.
 * **system:group:organization:{organization_id}:users**: All users in organization.
 * **system:allAuthenticatedUsers**: All authenticated users.
 * **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

for more information about system groups, see [Cloud Documentation](../../iam/concepts/access-control/system-group.md).

{% endnote %}



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_resourcemanager_folder_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_resourcemanager_folder_iam_binding.<resource Name> "<resource Id>,<resource Role>"
terraform import yandex_resourcemanager_folder_iam_binding.admin "b1g5r**********dqmsp,admin"
```