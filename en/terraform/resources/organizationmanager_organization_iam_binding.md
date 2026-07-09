---
subcategory: Identity Hub
---

# yandex_organizationmanager_organization_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `organization`.

{% note warning %}

**Warning:** This resource is authoritative for the given `role` on the target `organization` and manages the complete set of its members. When you change or delete `yandex_organizationmanager_organization_iam_binding`, the `role` may be removed from other subjects on the `organization` as well — including subjects granted outside of this resource (via the corresponding `*_iam_member` resource, the management console, CLI or API). Those subjects are not tracked in the Terraform state, so a plain `terraform plan` does not list them. Be careful.

{% endnote %}


## Example usage

```terraform
//
// Create a new OrganizationManager Organization IAM Binding.
//
resource "yandex_organizationmanager_organization_iam_binding" "editor" {
  organization_id = "some_organization_id"

  role = "editor"

  members = [
    "userAccount:some_user_id",
  ]
}
```

## Arguments & Attributes Reference

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

for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

{% endnote %}



- `organization_id` (**Required**)(String). The ID of the compute `organization` to attach the policy to.
- `role` (**Required**)(String). The role that should be assigned. Only one yandex_organizationmanager_organization_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_organization_iam_binding.<resource Name> "<resource Id>,<resource Role>"
terraform import yandex_organizationmanager_organization_iam_binding.editor "abjjf**********p3gp8,editor"
```
