#### iam.serviceAccounts.user {#sa-user}

The `iam.serviceAccounts.user` role means that the user has the right to use service accounts.
This role is necessary when the user asks the service to perform operations on behalf of a service account.

For example, when creating a group of virtual machines, you specify the service account and the IAM checks that you have permission to use this account.

The following permissions are included in the `iam.serviceAccounts.user` role:

- Get a list of service accounts
- Get information about a service account
- Use the service account to perform operations on its behalf

[!INCLUDE [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md)]

