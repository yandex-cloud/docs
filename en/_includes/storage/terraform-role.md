{% note info %}

If you access {{ objstorage-name }} via {{ TF }} under a [service account](../../iam/concepts/users/service-accounts.md), [assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the relevant [role](../../storage/security/index.md#roles-list), e.g., `storage.admin`, for the folder you are going to create the resources in.

{% endnote %}