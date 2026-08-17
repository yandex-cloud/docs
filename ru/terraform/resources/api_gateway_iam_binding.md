---
subcategory: Serverless API Gateway
---

# yandex_api_gateway_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `api_gateway`.

{% note warning %}

**Warning:** This resource is authoritative for the given `role` on the target `api_gateway` and manages the complete set of its members. When you change or delete `yandex_api_gateway_iam_binding`, the `role` may be removed from other subjects on the `api_gateway` as well — including subjects granted outside of this resource (via the corresponding `*_iam_member` resource, the management console, CLI or API). Those subjects are not tracked in the Terraform state, so a plain `terraform plan` does not list them. Be careful.

{% endnote %}



## Arguments & Attributes Reference

- `api_gateway_id` (**Required**)(String). The ID of the `api_gateway` to attach the policy to.
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



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_api_gateway_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay


