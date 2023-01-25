# yc iam

Managing {{ iam-full-name }} resources.

#### Command usage

Syntax:

`yc iam <group|command>`

#### Commands

- `yc iam create-token`: [Create an IAM token and output it to STDOUT](../../../iam/operations/iam-token/create.md).

#### Groups

- `yc iam role`: Manage [roles](../../../iam/concepts/access-control/roles.md).
   - `get`: Get information about the specified role.
   - `list`: Get a list of roles.
- `yc iam service-account`: Manage [service accounts](../../../iam/concepts/users/service-accounts.md).
   - `get`: Get information about the specified service account.
   - `list`: Get a list of service accounts.
   - `create`: [Create a service account](../../../iam/operations/sa/create.md).
   - `update`: [Update the specified service account](../../../iam/operations/sa/update.md).
   - `delete`: [Delete the specified service account](../../../iam/operations/sa/delete.md).
   - `list-access-bindings`: Get a list of roles for the specified service account.
   - `add-access-binding`: [Assign a role to enable access to the specified service account as a resource](../../../iam/operations/sa/set-access-bindings.md).
   - `set-access-bindings`: [Assign roles to enable access to the specified service account as a resource](../../../iam/operations/sa/set-access-bindings.md#multiple-roles) and remove all the current roles (if any).
   - `remove-access-binding`: Remove a role that enables access to the specified service account as a resource.
   - `list-operations`: Get a list of operations for the specified service account.
- `yc iam key`: Manage [authorized keys](../../../iam/concepts/authorization/key.md).
   - `get`: Get information about the specified authorized key.
   - `list`: Get a list of authorized keys for an authenticated account or the specified service account.
   - `create`: [Create an authorized key for an authenticated account or the specified service account](../../../iam/operations/iam-token/create-for-sa.md#keys-create).
   - `delete`: Delete the specified authorized key.
- `yc iam access-key`: Manage [static access keys](../../../iam/concepts/authorization/access-key.md) for service accounts.
   - `get`: Get information about the specified static access key.
   - `list`: Get a list of static access keys for the specified service account.
   - `create`: [Create a static access key for the specified service account](../../../iam/operations/sa/create-access-key.md).
   - `delete`: Delete the specified static access key.
- `yc iam user-account`: Manage user [accounts](../../../iam/concepts/index.md#accounts).
   - `get`: [Get information about the specified user account](../../../iam/operations/users/get.md).


