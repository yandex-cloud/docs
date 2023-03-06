#### iam.serviceAccounts.user {#sa-user}

The `iam.serviceAccounts.user` role means that the user has the right to use service accounts.
This role is necessary when the user asks the service to perform operations on behalf of a service account.

For example, when creating an instance group, you specify the service account and the IAM checks whether you have permission to use it.

The following permissions are included in the `iam.serviceAccounts.user` role:

- Get a list of service accounts.
- Get information about a service account.
- Use the service account to perform operations on its behalf.

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}
