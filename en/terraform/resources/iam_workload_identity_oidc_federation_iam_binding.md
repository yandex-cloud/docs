---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_workload_identity_oidc_federation_iam_binding.md
---

# yandex_iam_workload_identity_oidc_federation_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `federation`.

## Example usage

```terraform
//
// Create a new IAM workload identity federation IAM Binding.
//
resource "yandex_iam_workload_identity_oidc_federation_iam_binding" "viewer" {
  federation_id = "example_federation_id"
  role          = "viewer"

  members = [
    "userAccount:foo_user_id",
  ]
}
```

## Arguments & Attributes Reference

- `federation_id` (**Required**)(String). The ID of the compute `federation` to attach the policy to.
- `id` (String). The ID of this resource.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values: * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account. * **serviceAccount:{service_account_id}**: A unique service account ID. * **federatedUser:{federated_user_id}**: A unique federated user ID. * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID. * **group:{group_id}**: A unique group ID. * **system:group:federation:{federation_id}:users**: All users in federation. * **system:group:organization:{organization_id}:users**: All users in organization. * **system:allAuthenticatedUsers**: All authenticated users. * **system:allUsers**: All users, including unauthenticated ones.

    {% note warning %}

    for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

    {% endnote %}
- `role` (**Required**)(String). The role that should be assigned. Only one yandex_iam_workload_identity_oidc_federation_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_workload_identity_oidc_federation_iam_binding.<resource Name> "federation_id,roles/<resource Role>"
terraform import yandex_iam_workload_identity_oidc_federation_iam_binding.viewer "example_federation_id,roles/viewer"
```
