---
subcategory: Serverless Workflows
---

# yandex_serverless_workflow_iam_member (Resource)

Allows creation and management of a single binding within IAM policy for an existing `workflow`.


## Arguments & Attributes Reference

- `id` (String). The ID of this resource.
- `member` (**Required**)(String). An identity that will be granted the privilege in the `role`. It can have one of the following values:
 * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
 * **serviceAccount:{service_account_id}**: A unique service account ID.
 * **federatedUser:{federated_user_id}**: A unique federated user ID.
 * **group:{group_id}**: A unique group ID.
 * **system:group:federation:{federation_id}:users**: All users in federation.
 * **system:group:organization:{organization_id}:users**: All users in organization.
 * **system:allAuthenticatedUsers**: All authenticated users.
 * **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

{% endnote %}



- `role` (**Required**)(String). The role that should be assigned to the member.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay
- `workflow_id` (**Required**)(String). The ID of the `workflow` to attach the policy to.


