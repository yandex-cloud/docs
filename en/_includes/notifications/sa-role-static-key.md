For authentication in {{ cns-name }}, use a [static access key](../../iam/concepts/authorization/access-key.md). The key is issued for the [service account](../../iam/concepts/users/service-accounts.md), and all actions are performed on behalf of that service account.

To get a static access key:
1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-editor }}` [role](../../iam/roles-reference.md#editor) for the folder to the service account.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key for the service account.

    Save the ID and secret key.
