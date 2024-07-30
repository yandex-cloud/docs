{% note info %}

{{ TF }} uses a [service account](../../iam/concepts/users/service-accounts.md) to interact with {{ objstorage-name }}. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the required [role](../../storage/security/index.md#roles-list), e.g., `storage.admin`, for the folder where you are going to create resources.

{% endnote %}