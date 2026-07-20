[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Resources > compute_disk_placement_group_iam_binding

# yandex_compute_disk_placement_group_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `disk_placement_group`.

{% note warning %}

**Warning:** This resource is authoritative for the given `role` on the target `disk_placement_group` and manages the complete set of its members. When you change or delete `yandex_compute_disk_placement_group_iam_binding`, the `role` may be removed from other subjects on the `disk_placement_group` as well — including subjects granted outside of this resource (via the corresponding `*_iam_member` resource, the management console, CLI or API). Those subjects are not tracked in the Terraform state, so a plain `terraform plan` does not list them. Be careful.

{% endnote %}


## Example usage

```terraform
//
// Create a new Disk Placement Group and new IAM Binding for it.
//
resource "yandex_compute_disk_placement_group" "group1" {
  name        = "test-pg"
  folder_id   = "abc*********123"
  description = "my description"
}

resource "yandex_compute_disk_placement_group_iam_binding" "editor" {
  disk_placement_group_id = data.yandex_compute_disk_placement_group.group1.id

  role = "editor"

  members = [
    "userAccount:some_user_id",
  ]
}
```

## Arguments & Attributes Reference

- `disk_placement_group_id` (**Required**)(String). The ID of the `disk_placement_group` to attach the policy to.
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



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_compute_disk_placement_group_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay