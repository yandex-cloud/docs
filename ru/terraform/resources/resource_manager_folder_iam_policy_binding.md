---
subcategory: Unknown
---

# yandex_resource_manager_folder_iam_policy_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `folder`.


## Arguments & Attributes Reference

- `access_policy_template_id` (**Required**)(String). The role that should be assigned. Only one yandex_resource_manager_folder_iam_policy_binding can be used per role.
- `folder_id` (**Required**)(String). The ID of the compute `folder` to attach the policy to.
- `id` (String). The ID of this resource.
- `parameters` (Map Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
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



- `sleep_after` (Number). For test purposes, to compensate IAM operations delay


