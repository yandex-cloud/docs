# yc iam

Manage {{ iam-full-name }} resources.

#### Usage

Syntax:

`yc iam <group|command>`

#### Commands

- `yc iam create-token` — [create IAM token and print to STDOUT](../../../iam/operations/iam-token/create.md).

#### Groups

- `yc iam role` — manage [roles](../../../iam/concepts/access-control/roles.md).
    - `get` — show information about the specified role.
    - `list` — list roles.
- `yc iam service-account` — manage [service accounts](../../../iam/concepts/users/service-accounts.md).
    - `get` — show information about the specified service account.
    - `list` — list service accounts.
    - `create` — [create a service account](../../../iam/operations/sa/create.md).
    - `update` — [update the specified service account](../../../iam/operations/sa/update.md).
    - `delete` — [delete the specified service account](../../../iam/operations/sa/delete.md).
    - `list-access-bindings` — list access bindings for ACCESSING the specified service account.
    - `set-access-bindings` — [set access bindings for ACCESSING the specified service account](../../../iam/operations/sa/set-access-bindings.md#multiple-roles) and DELETE all existing access bindings if there were any.
    - `add-access-binding` —  [Add access binding to ACCESS the specified service account as a resource](../../../iam/operations/sa/set-access-bindings.md).
    - `remove-access-binding` — remove access binding for ACCESSING the specified service account as a resource.
    - `list-operations` — list operations for the specified service account.
- `yc iam key` — manage [IAM keys](../../../iam/concepts/authorization/key.md).
    - `get` — show information about the specified IAM key.
    - `list` — list IAM keys for authenticated account or the specified service account.
    - `create` — [create an IAM key for authenticated account or the specified service account](../../../iam/operations/iam-token/create-for-sa.md#keys-create).
    - `delete` — delete the specified IAM key.
- `yc iam access-key` — manage service account [access keys](../../../iam/concepts/authorization/access-key.md).
    - `get` — show information about the specified access key.
    - `list` — list access keys for the specified service account.
    - `create` — [create an access key for the specified service account](../../../iam/operations/sa/create-access-key.md).
    - `delete` — delete the specified access key.
- `yc iam user-account` — manage [user accounts](../../../iam/concepts/index.md#accounts).
    - `get` — [show information about the specified user account](../../../iam/operations/users/get.md).













